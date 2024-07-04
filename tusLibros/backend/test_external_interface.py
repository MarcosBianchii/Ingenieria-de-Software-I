import unittest
from external_interface import ExternalInterface
from test_utils import AuthenticatorStub, PosnetStub, ClockStub
from cashier import Cashier
from month_year_date import MonthYearDate
from timekeeper import Timekeeper
from response import Response
from copy import deepcopy


class TestExternalInterface(unittest.TestCase):
    test_catalog = {"isbn1": 1.0, "isbn2": 2.0}
    always_true_authenticator = AuthenticatorStub(lambda username, password: None)
    test_posnet = PosnetStub(lambda amount, credit_card: None)
    test_cashier = Cashier(test_posnet)
    always_valid_session = Timekeeper(ClockStub(), 1000)
    invalid_user = "Invalid user"

    def always_false_behaviour(username, password):
        raise Exception("Invalid user")

    always_false_authenticator = AuthenticatorStub(always_false_behaviour)

    def default_interface(self) -> ExternalInterface:
        catalog = self.test_catalog
        auth = self.always_true_authenticator
        cashier = deepcopy(self.test_cashier)
        session = self.always_valid_session
        return ExternalInterface(catalog, auth, cashier, self.tell_today, session)

    def valid_credit_card(self) -> tuple[str, int, int, str]:
        return "111122223333", 12, 2030, "pepe"

    def tell_today(self) -> MonthYearDate:
        return MonthYearDate(6, 2024)

    def create_cart(self, interface: ExternalInterface) -> Response:
        request = {"clientId": "username", "password": "password"}
        return interface.create_cart(request)

    def list_cart(self, cart_id: str, interface: ExternalInterface) -> Response:
        request = {"cartId": cart_id}
        return interface.list_cart(request)

    def add_to_cart(
        self, cart_id: str, isbn_code: str, quantity: int, interface: ExternalInterface
    ) -> Response:
        request = {
            "cartId": cart_id,
            "bookIsbn": isbn_code,
            "bookQuantity": str(quantity),
        }
        return interface.add_to_cart(request)

    def checkout_cart(
        self,
        cart_id: str,
        credit_card_number: str,
        expiration_month: int,
        expiration_year: int,
        owner: str,
        interface: ExternalInterface,
    ) -> Response:
        request = {
            "cartId": cart_id,
            "ccn": credit_card_number,
            "cced": f"{expiration_month}{expiration_year}",
            "cco": owner,
        }
        return interface.checkout_cart(request)

    def list_purchases(self, username: str, interface: ExternalInterface) -> Response:
        request = {
            "clientId": username,
            "password": "password",
        }
        return interface.list_purchases(request)

    def test01_Listing_a_non_created_cart_errors(self):
        interface = self.default_interface()
        response = self.list_cart("cart_id", interface)
        self.assertTrue(response.failed())

    def test02_A_newly_created_cart_is_empty(self):
        interface = self.default_interface()

        response = self.create_cart(interface)
        cart_id = response.body()
        self.assertTrue(response.succeeded())
        self.assertTrue(len(response.body()) > 0)

        response = self.list_cart(cart_id, interface)
        self.assertTrue(response.succeeded())
        self.assertEqual(len(response.body()), 0)

    def test03_Can_add_books_to_a_cart(self):
        interface = self.default_interface()

        book = "isbn1"
        copies = 1

        response = self.create_cart(interface)
        cart_id = response.body()

        response = self.add_to_cart(cart_id, book, copies, interface)
        self.assertTrue(response.succeeded())
        self.assertEqual(response.body(), "OK")

        response = self.list_cart(cart_id, interface)
        self.assertTrue(response.succeeded())
        self.assertEqual(response.body(), f"{book}|{copies}")

    def test04_Adding_a_book_not_in_the_catalog_errors(self):
        interface = self.default_interface()

        book = "a book not in the catalog"
        copies = 1

        response = self.create_cart(interface)
        cart_id = response.body()

        response = self.add_to_cart(cart_id, book, copies, interface)
        self.assertTrue(response.failed())

    def test05_Adding_more_than_one_book_is_ok(self):
        interface = self.default_interface()

        book1 = "isbn1"
        copies1 = 2

        book2 = "isbn2"
        copies2 = 3

        response = self.create_cart(interface)
        cart_id = response.body()

        self.add_to_cart(cart_id, book1, copies1, interface)
        self.add_to_cart(cart_id, book2, copies2, interface)
        response = self.list_cart(cart_id, interface)

        expected_response = "isbn1|2|isbn2|3"
        self.assertTrue(response.succeeded())
        self.assertEqual(response.body(), expected_response)

    def test06_Adding_less_than_one_copy_of_a_book_does_not_add_the_book_to_a_cart(
        self,
    ):
        interface = self.default_interface()

        book = "isbn1"
        copies = -1

        response = self.create_cart(interface)
        cart_id = response.body()

        response = self.add_to_cart(cart_id, book, copies, interface)
        self.assertTrue(response.failed())

    def test07_Cant_create_a_cart_with_an_invalid_account(self):
        catalog = self.test_catalog
        # false authenticator
        auth = self.always_false_authenticator
        cashier = self.test_cashier
        session = self.always_valid_session
        interface = ExternalInterface(catalog, auth, cashier, self.tell_today, session)

        response = self.create_cart(interface)
        self.assertTrue(response.failed())

    def test08_Cant_add_a_non_numerical_quantity_of_books(self):
        interface = self.default_interface()

        book = "isbn1"
        invalid_copies = "hello"

        response = self.create_cart(interface)
        cart_id = response.body()

        response = self.add_to_cart(cart_id, book, invalid_copies, interface)
        self.assertTrue(response.failed())

    def test09_A_valid_purchase_returns_a_successfull_status_and_transaction_id(self):
        interface = self.default_interface()
        card_number, exp_month, exp_year, owner = self.valid_credit_card()

        book = "isbn1"
        copies = 1

        response = self.create_cart(interface)
        cart_id = response.body()

        self.add_to_cart(cart_id, book, copies, interface)
        response = self.checkout_cart(
            cart_id, card_number, exp_month, exp_year, owner, interface
        )

        self.assertTrue(response.succeeded())
        self.assertTrue(len(response.body()) > 0)

        # agregar el checkeo de listPurchases

    def test10_EXTRA_Cannot_checkout_a_cart_with_an_incomplete_credit_card(self):
        interface = self.default_interface()
        card_number, exp_month, exp_year, owner = self.valid_credit_card()

        book = "isbn1"
        copies = 1

        response = self.create_cart(interface)
        cart_id = response.body()

        self.add_to_cart(cart_id, book, copies, interface)
        response = self.checkout_cart(
            cart_id, "", exp_month, exp_year, owner, interface
        )
        self.assertTrue(response.failed())

        response = self.checkout_cart(
            cart_id, card_number, exp_month, exp_year, "", interface
        )
        self.assertTrue(response.failed())

    def test11_Listing_purchases_of_a_user_with_no_purchases_returns_an_empty_list(
        self,
    ):
        interface = self.default_interface()

        response = self.list_purchases("a user with no purchases", interface)
        self.assertTrue(response.succeeded())

    def test12_Listing_purchases_of_a_user_with_one_purchase_returns_a_list_with_the_only_purchase(
        self,
    ):
        interface = self.default_interface()

        response = self.create_cart(interface)
        cart_id = response.body()

        self.add_to_cart(cart_id, "isbn2", 1, interface)

        card_number, exp_month, exp_year, owner = self.valid_credit_card()
        self.checkout_cart(cart_id, card_number, exp_month, exp_year, owner, interface)
        response = self.list_purchases("username", interface)

        self.assertTrue(response.succeeded())
        self.assertEqual(response.body(), "isbn2|1|2.0")

    def test13_Listing_purchases_of_a_user_wit_more_tan_one_purchase_returns_a_list_with_more_than_purchase(
        self,
    ):
        interface = self.default_interface()

        response = self.create_cart(interface)
        cart_id = response.body()

        self.add_to_cart(cart_id, "isbn1", 1, interface)
        self.add_to_cart(cart_id, "isbn2", 2, interface)

        card_number, exp_month, exp_year, owner = self.valid_credit_card()
        self.checkout_cart(cart_id, card_number, exp_month, exp_year, owner, interface)

        response = self.list_purchases("username", interface)

        self.assertTrue(response.succeeded())
        self.assertEqual(response.body(), "isbn1|1|isbn2|2|5.0")


if __name__ == "__main__":
    unittest.main()
