from receipt import Receipt
from mercado_pago import MercadoPago
from cart import Cart
from credit_card import CreditCard
from month_year_date import MonthYearDate
from shopping_notebook import ShoppingNotebook
from collections import Counter


class Cashier:
    def __init__(self, merchant_processor: MercadoPago):
        self._merchant_processor = merchant_processor
        self._shopping_notebook = ShoppingNotebook()

    def checkout(
        self, cart: Cart, credit_card: CreditCard, date: MonthYearDate, user_id: str
    ) -> Receipt:
        if cart.is_empty():
            raise Exception(self.__class__.empty_cart())

        if credit_card.is_expired(date):
            raise Exception(self.__class__.expired_credit_card())

        self._merchant_processor.debit(cart.cost(), credit_card)
        receipt = Receipt(cart, credit_card)
        self._shopping_notebook.register(user_id, receipt)
        return receipt

    def client_has_n_purchases(self, user_id: str, amount_of_purchaces: int) -> bool:
        return self._shopping_notebook.has_n_purchases(user_id, amount_of_purchaces)

    def list_purchases(self, user_id: str) -> tuple[Counter[str], float]:
        return self._shopping_notebook.purchases(user_id)

    def contains_transaction(self, transaction_id: str) -> bool:
        return self._shopping_notebook.contains_transaction(transaction_id)

    @classmethod
    def empty_cart(cls) -> str:
        return "The cart provided is empty"

    @classmethod
    def expired_credit_card(cls) -> str:
        return "The credit card provided is expired"
