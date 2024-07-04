import unittest
from cart import Cart
from typing import Iterable


class TestCart(unittest.TestCase):
    cost_catalog = {"isbn_book_1": 1.0, "isbn_book_2": 2.0}

    def assert_cart_costs(self, cart: Cart, cost_amount: int):
        self.assertEqual(cart.cost(), cost_amount)

    def cart_with_books(self, books: Iterable) -> Cart:
        cart = Cart(self.cost_catalog)
        for book in books:
            cart.add_book(book)
        return cart

    def test01_A_new_cart_is_empty(self):
        self.assertTrue(Cart().is_empty())

    def test02_An_added_book_is_contained_by_the_cart(self):
        cart = Cart()
        cart.add_book("a book")
        self.assertTrue(cart.contains("a book"))

    def test03_Two_added_books_are_contained_by_the_cart(self):
        cart = Cart()
        cart.add_book("a book")
        cart.add_book("another book")
        self.assertTrue(cart.contains("a book"))
        self.assertTrue(cart.contains("another book"))

    def test04_A_book_not_added_in_the_cart_is_not_contained_by_the_cart(self):
        self.assertFalse(Cart().contains("a non added book"))

    def test05_A_book_not_included_in_a_catalog_cant_be_added_to_the_cart(self):
        catalog = ["a book"]

        try:
            Cart(catalog).add_book("a book not in the catalog")
            self.fail()
        except:
            pass

    def test06_More_than_one_book_can_be_added_to_the_cart(self):
        cart = Cart()
        an_amount_of_books = 2

        cart.add_books("a book", an_amount_of_books)
        self.assertTrue(cart.contains_n("a book", an_amount_of_books))

    def test07_Can_add_one_more_copy_of_a_book(self):
        cart = Cart()
        an_amount_of_books = 2
        an_amount_of_books_after_adding_one = an_amount_of_books + 1

        cart.add_books("a book", an_amount_of_books)
        cart.add_book("a book")

        self.assertTrue(cart.contains_n(
            "a book", an_amount_of_books_after_adding_one))

    def test08_Cant_add_less_than_one_copy_of_a_book(self):
        cart = Cart()
        try:
            cart.add_books("a book", -1)
            self.fail()
        except Exception as e:
            self.assertEqual(str(e), Cart.added_less_than_one_book())

    def test09_An_empty_cart_costs_no_money(self):
        empty_cart = Cart(self.cost_catalog)
        self.assert_cart_costs(empty_cart, 0)

    def test10_A_cart_with_one_book_costs_the_same_as_the_book(self):
        book = "isbn_book_1"
        total_cart_cost = self.cost_catalog[book]
        cart_with_one_book = self.cart_with_books([book])
        self.assert_cart_costs(cart_with_one_book, total_cart_cost)

    def test11_A_cart_with_more_than_one_book_costs_the_sum_of_all_book_costs(self):
        books = list(self.cost_catalog.keys())
        total_cart_cost = sum(self.cost_catalog.values())
        cart_with_two_books = self.cart_with_books(books)
        self.assert_cart_costs(cart_with_two_books, total_cart_cost)

    def test12_A_cart_with_a_book_with_more_than_one_copy_costs_the_book_times_its_copies(
        self,
    ):
        copies = 2
        book = "isbn_book_1"
        cart_with_copies = self.cart_with_books([book] * copies)
        total_cart_cost = copies * self.cost_catalog[book]
        self.assert_cart_costs(cart_with_copies, total_cart_cost)


if __name__ == "__main__":
    unittest.main()
