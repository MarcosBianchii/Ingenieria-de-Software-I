import unittest
from month_year_date import MonthYearDate
from internal_interface import InternalInterface
from test_utils import AuthenticatorStub, PosnetStub, ClockStub
from credit_card import CreditCard
from cashier import Cashier
from timekeeper import Timekeeper
from typing import Any, Callable
from shopping_notebook import ShoppingNotebook
from copy import deepcopy


class TestsInternalInterface(unittest.TestCase):
    test_catalog = {"isbn_in_catalog": 1.0, "isbn_in_catalog_2": 2.0}
    always_true_authenticator = AuthenticatorStub(lambda username, password: None)
    always_valid_cashier = Cashier(PosnetStub(lambda amount, credit_card_number: None))
    posnet_error = "Invalid credit card"
    timeout_time = 10000

    def always_invalid_posnet(amount, credit_card_number):
        # no se porque si no hardcodeo esto no anda, entendemos que
        # tenemos que usar la variable de arriba
        raise Exception("Invalid credit card")

    always_invalid_cashier = Cashier(PosnetStub(always_invalid_posnet))

    authenticator_error = "User not found"

    def always_false_authenticator(username, password):
        # no se porque si no hardcodeo esto no anda, entendemos que
        # tenemos que usar la variable de arriba
        raise Exception("User not found")

    always_false_authenticator = AuthenticatorStub(always_false_authenticator)

    def new_test_interface(
        self,
        catalog=test_catalog,
        authenticator=always_true_authenticator,
        cashier=always_valid_cashier,
        clock=ClockStub(),
        timeout_time=1000,
    ):
        return InternalInterface(
            catalog,
            authenticator,
            deepcopy(cashier),
            Timekeeper(clock, timeout_time),
        )

    def errors_and_msg_is(self, f: Callable, msg: str) -> Any:
        try:
            f()
            self.fail()
        except Exception as e:
            self.assertEqual(str(e), msg)

    def valid_credit_card(self) -> tuple[CreditCard, MonthYearDate]:
        expiration_date = MonthYearDate(6, 2030)
        valid_credit_card = CreditCard("123412341234", expiration_date, "pepe")
        today = MonthYearDate(6, 2024)
        return valid_credit_card, today

    def expired_credit_card(self) -> tuple[CreditCard, MonthYearDate]:
        expiration_date = MonthYearDate(6, 2020)
        expired_credit_card = CreditCard("123412341234", expiration_date, "pepe")
        today = MonthYearDate(6, 2024)
        return expired_credit_card, today

    def test_01_Requesting_a_list_of_a_non_existant_cart_id_returns_none(self):
        catalog = self.test_catalog
        auth = self.always_true_authenticator
        cashier = self.always_valid_cashier
        self.errors_and_msg_is(
            lambda: InternalInterface(
                catalog, auth, cashier, Timekeeper(ClockStub(), 1000)
            ).list_cart("id"),
            InternalInterface.cart_not_found(),
        )

    def test_02_Requesting_a_list_of_a_cart_with_no_books_returns_an_empty_list(self):
        interface = self.new_test_interface()

        cart_id = interface.create_cart("username", "password")
        cart_list = interface.list_cart(cart_id)

        self.assertEqual(len(cart_list), 0)

    def test_03_Adding_a_book_to_a_cart_id_is_added_to_the_cart_in_the_interface(self):
        interface = self.new_test_interface()
        amount_of_copies = 1

        cart_id = interface.create_cart("username", "password")
        interface.add_to_cart(cart_id, "isbn_in_catalog", amount_of_copies)
        cart_list = interface.list_cart(cart_id)

        self.assertEqual(len(cart_list), 1)
        self.assertTrue("isbn_in_catalog" in cart_list)

    def test_04_Adding_a_book_to_an_unexisting_cart_raises_an_error(self):
        interface = self.new_test_interface()

        cart_id = "id"
        book = "isbn_in_catalog"
        copies = 1
        self.errors_and_msg_is(
            lambda: interface.add_to_cart(cart_id, book, copies),
            InternalInterface.cart_not_found(),
        )

    def test05_Creating_two_cart_id_is_valid_and_have_different_items(self):
        interface = self.new_test_interface()

        amount_of_copies = 1

        cart_id1 = interface.create_cart("username", "password")
        cart_id2 = interface.create_cart("username", "password")

        interface.add_to_cart(cart_id1, "isbn_in_catalog", amount_of_copies)
        interface.add_to_cart(cart_id2, "isbn_in_catalog_2", amount_of_copies)

        cart_list1 = interface.list_cart(cart_id1)
        cart_list2 = interface.list_cart(cart_id2)

        self.assertNotEqual(cart_list1, cart_list2)
        self.assertNotEqual(cart_id1, cart_id2)

    def test06_More_than_one_copy_of_the_same_book_can_be_added_at_once(self):
        interface = self.new_test_interface()

        amount_of_copies = 2

        cart_id = interface.create_cart("username", "password")
        interface.add_to_cart(cart_id, "isbn_in_catalog", amount_of_copies)

        cart_list = interface.list_cart(cart_id)
        self.assertEqual(len(cart_list), 1)
        self.assertTrue(
            interface.cart_has_n_copies_of_book(
                cart_id, "isbn_in_catalog", amount_of_copies
            )
        )

    def test07_Cant_create_a_cart_with_an_invalid_account(self):
        interface = self.new_test_interface(
            authenticator=self.always_false_authenticator
        )

        self.errors_and_msg_is(
            lambda: interface.create_cart("username", "password"),
            self.authenticator_error,
        )

    def test08_A_valid_purchase_generates_a_transaction_id_and_logs_it_in_the_shopping_history(
        self,
    ):
        interface = self.new_test_interface()

        valid_credit_card, today = self.valid_credit_card()

        book = "isbn_in_catalog"
        copies = 1
        cart_id = interface.create_cart("username", "password")
        interface.add_to_cart(cart_id, book, copies)
        transaction_id = interface.checkout_cart(cart_id, valid_credit_card, today)

        self.assertTrue(len(transaction_id) > 0)
        self.assertTrue(interface.contains_transaction(transaction_id))

    def test09_A_payment_will_fail_if_the_credit_card_is_stolen(self):
        interface = self.new_test_interface(cashier=self.always_invalid_cashier)

        cart_id = interface.create_cart("username", "password")
        interface.add_to_cart(cart_id, "isbn_in_catalog", amount=1)

        valid_credit_card, today = self.valid_credit_card()
        self.errors_and_msg_is(
            lambda: interface.checkout_cart(cart_id, valid_credit_card, today),
            self.posnet_error,
        )

    def test10_Listing_a_cart_after_the_session_has_expired_errors(self):
        clock = ClockStub()
        interface = self.new_test_interface(clock=clock, timeout_time=2)

        cart_id = interface.create_cart("username", "password")
        _ = interface.list_cart(cart_id)
        clock.time_leap(2)

        self.errors_and_msg_is(
            lambda: interface.list_cart(cart_id), Timekeeper.session_expired()
        )

    def test11_Adding_a_second_book_to_the_cart_after_the_session_has_expired_erros(
        self,
    ):
        clock = ClockStub()
        interface = self.new_test_interface(clock=clock, timeout_time=2)

        cart_id = interface.create_cart("username", "password")

        interface.add_to_cart(cart_id, "isbn_in_catalog", 1)
        clock.time_leap(2)

        self.errors_and_msg_is(
            lambda: interface.add_to_cart(cart_id, "isbn_in_catalog_2", 1),
            Timekeeper.session_expired(),
        )

    def test12_Trying_to_checkout_a_cart_in_an_expired_session_errors(self):
        clock = ClockStub()
        interface = self.new_test_interface(clock=clock, timeout_time=2)

        cart_id = interface.create_cart("username", "password")
        _ = interface.list_cart(cart_id)

        interface.add_to_cart(cart_id, "isbn_in_catalog", 1)
        valid_credit_card, today = self.valid_credit_card()
        clock.time_leap(2)

        self.errors_and_msg_is(
            lambda: interface.checkout_cart(cart_id, valid_credit_card, today),
            Timekeeper.session_expired(),
        )

    def test13_Making_an_action_inside_the_session_duration_limit_refreshes_its_timestamp(
        self,
    ):
        session_duration = 2
        clock = ClockStub()
        interface = self.new_test_interface(clock=clock, timeout_time=session_duration)

        cart_id = interface.create_cart("username", "password")

        sum_of_leaps = session_duration + 1
        for _ in range(sum_of_leaps):
            clock.time_leap(1)
            _ = interface.list_cart(cart_id)

        self.assertGreaterEqual(sum_of_leaps, session_duration)

    def test14_Listing_purchases_for_a_user_with_no_purchases_errors(self):
        interface = self.new_test_interface()

        purchases, _ = interface.list_purchases("user with no purchases", "password")
        self.assertEqual(len(purchases), 0)


if __name__ == "__main__":
    unittest.main()
