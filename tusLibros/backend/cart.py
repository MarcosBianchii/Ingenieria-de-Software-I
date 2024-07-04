from collections import Counter
from typing import Optional


class Cart:
    def __init__(self, catalog: Optional[dict] = None):
        self._catalog = catalog
        self._books = Counter()

    def is_empty(self) -> bool:
        return len(self._books) == 0

    def list(self) -> Counter:
        return self._books.copy()

    def add_book(self, isbn_code: str):
        self.add_books(isbn_code, 1)

    def add_books(self, isbn_code: str, amount_of_copies: int):
        if (self._catalog != None) and (isbn_code not in self._catalog):
            raise Exception(self.__class__.not_in_catalog())

        if amount_of_copies < 1:
            raise Exception(self.__class__.added_less_than_one_book())

        self._add_book_count(isbn_code, amount_of_copies)

    def contains(self, isbn_code: str) -> bool:
        return isbn_code in self._books

    def cost(self) -> int:
        if self._catalog == None:
            return 0

        return sum([self._catalog[book] * self._books[book] for book in self._books])

    def clear(self):
        self._books.clear()

    def contains_n(self, isbn_code: str, amount_of_copies: int) -> bool:
        return self.contains(isbn_code) and self._books[isbn_code] == amount_of_copies

    @classmethod
    def not_in_catalog(cls) -> str:
        return "The book is not in the catalog"

    @classmethod
    def added_less_than_one_book(cls) -> str:
        return "Cant add less than one book"

    def _add_book_count(self, isbn_code: str, amount_of_copies: int):
        previous_quantity = self._books.get(isbn_code, 0)
        self._books[isbn_code] = amount_of_copies + previous_quantity
