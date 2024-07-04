import unittest
from cashier import Cashier
from cart import Cart
from credit_card import CreditCard
from month_year_date import MonthYearDate
from test_utils import PosnetStub
from typing import Callable, Any
from shopping_notebook import ShoppingNotebook
from receipt import Receipt
from cashier import Cashier


class TestCashier(unittest.TestCase):
    catalog = {"isbn_book": 4.0}
    testing_posnet = PosnetStub(lambda amount, credit_card_number: None)
    always_valid_merchant_processor = PosnetStub(
        lambda amount, credit_card_number: None
    )

    def credit_card(self) -> CreditCard:
        expiration_date = MonthYearDate(6, 2030)
        credit_card = CreditCard("123412341234", expiration_date, "pepe")
        return credit_card

    def cart_with_items(self, books: list) -> Cart:
        cart = Cart()
        for book in books:
            cart.add_book(book)
        return cart

    def errors_and_msg_is(self, f: Callable, msg: str) -> Any:
        try:
            f()
            self.fail()
        except Exception as e:
            self.assertEqual(str(e), msg)

    def valid_credit_card(self) -> tuple[CreditCard, MonthYearDate]:
        valid_credit_card = self.credit_card()
        today = MonthYearDate(6, 2024)
        return valid_credit_card, today

    def expired_credit_card(self) -> tuple[CreditCard, MonthYearDate]:
        expiration_date = MonthYearDate(6, 2020)
        expired_credit_card = CreditCard(
            "123412341234", expiration_date, "pepe")
        today = MonthYearDate(6, 2024)
        return expired_credit_card, today

    def test01_Cannot_checkout_an_empty_cart(self):
        cashier = Cashier(self.testing_posnet)
        empty_cart = Cart()

        valid_credit_card, today = self.expired_credit_card()
        self.errors_and_msg_is(
            lambda: cashier.checkout(
                empty_cart, valid_credit_card, today, "username"),
            Cashier.empty_cart(),
        )

    def test02_Cannot_create_a_credit_card_with_an_invalid_expiration_date(self):
        self.errors_and_msg_is(
            lambda: MonthYearDate(13, 24), MonthYearDate.invalid_date()
        )

    def test03_Cannot_use_an_expired_credit_card_to_check_out(self):
        cashier = Cashier(self.testing_posnet)
        cart = Cart(self.catalog)
        cart.add_book("isbn_book")

        expired_credit_card, today = self.expired_credit_card()
        self.errors_and_msg_is(
            lambda: cashier.checkout(
                cart, expired_credit_card, today, "username"),
            Cashier.expired_credit_card(),
        )

    def test04_A_valid_purchase_generates_a_receipt_with_a_transaction_id(self):
        cashier = Cashier(self.testing_posnet)
        cart = Cart(self.catalog)
        cart.add_book("isbn_book")

        valid_credit_card, today = self.valid_credit_card()
        receipt = cashier.checkout(cart, valid_credit_card, today, "username")

        self.assertTrue(receipt.has_items(cart.list()))
        self.assertTrue(len(receipt.id()) > 0)
        self.assertTrue(receipt.has_cost(cart.cost()))

    def test05_an_empty_shopping_notebook_has_cero_payments_registered(self):
        cashier = Cashier(self.always_valid_merchant_processor)

        self.assertTrue(cashier.client_has_n_purchases("a_valid_user_id", 0))

    def test06_a_payment_can_be_registered_to_a_given_user_and_later_listed(self):
        books = ["a_book_isbn"]
        cashier = Cashier(self.always_valid_merchant_processor)
        cart = self.cart_with_items(books)
        credit_card, today = self.valid_credit_card()

        cashier.checkout(cart, credit_card, today, "a_valid_user_id")
        purchases, _ = cashier.list_purchases("a_valid_user_id")

        self.assertEqual(len(purchases), len(books))
        self.assertTrue("a_book_isbn" in purchases)

    def test07_more_than_one_payment_can_be_registered_to_a_given_user_and_later_listed(
        self,
    ):
        cashier = Cashier(self.always_valid_merchant_processor)
        books = ["a_book_isbn", "another_book_isbn"]
        cart = self.cart_with_items(books)
        credit_card, today = self.valid_credit_card()

        cashier.checkout(cart, credit_card, today, "a_valid_user_id")
        purchases, _ = cashier.list_purchases("a_valid_user_id")

        self.assertEqual(len(purchases), len(books))
        self.assertTrue("a_book_isbn" in purchases)
        self.assertTrue("another_book_isbn" in purchases)

    def test08_listing_purchases_for_a_user_with_no_purchases_gives_an_empty_list_of_books(self):
        cashier = Cashier(self.always_valid_merchant_processor)
        purchases, _ = cashier.list_purchases("user with no payments")
        self.assertEqual(len(purchases), 0)


if __name__ == "__main__":
    unittest.main()

