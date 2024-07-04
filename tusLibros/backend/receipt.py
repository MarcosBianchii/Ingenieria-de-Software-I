import uuid
from credit_card import CreditCard
from cart import Cart
from typing import Iterable
from collections import Counter


class Receipt:
    def __init__(self, cart: Cart, credit_card: CreditCard):
        self._items = cart.list()
        self._cost = cart.cost()
        self._credit_card = credit_card
        self._id = self.__class__.generate_transaction_id()

    @classmethod
    def generate_transaction_id(cls) -> str:
        return str(uuid.uuid1())

    def id(self) -> str:
        return self._id

    def list(self) -> Counter[str]:
        return self._items.copy()

    def cost(self) -> int:
        return self._cost

    def has_items(self, items: Iterable) -> bool:
        return all([item in self._items for item in items])

    def has_cost(self, a_cost: int) -> bool:
        return self._cost == a_cost
