from typing import Iterable
from receipt import Receipt
from collections import Counter


class ShoppingNotebook:

    def __init__(self):
        # dict[user_id, set[Receipt]]
        self._purchases: dict[str, set[Receipt]] = dict()
        self._transactions = dict()

    def has_n_purchases(self, user_id: str, amount_of_purchases: int):
        return len(self._purchases.get(user_id, set())) == amount_of_purchases

    def register(self, user_id: str, receipt: Receipt):
        self._transactions[receipt.id()] = receipt

        user_purchases = self._purchases.get(user_id, set())
        user_purchases.add(receipt)
        self._purchases[user_id] = user_purchases

    def purchases(self, user_id: str) -> tuple[Counter[str], float]:
        total_purchases = Counter()
        total_amount = 0.0

        for receipt in self._purchases.get(user_id, []):
            total_purchases += receipt.list()
            total_amount += receipt.cost()

        return total_purchases, total_amount

    def contains_transaction(self, transaction_id: str) -> bool:
        return transaction_id in self._transactions

    @classmethod
    def user_has_no_purchases(cls):
        return "The given user has no purchases"
