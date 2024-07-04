from cart import Cart
import uuid
from oauth_authentication_system import OAuthAuthenticationSystem
from cashier import Cashier
from timekeeper import Timekeeper
from month_year_date import MonthYearDate
from credit_card import CreditCard
from collections import Counter


class InternalInterface:
    def __init__(
        self,
        catalog: dict,
        authenticator: OAuthAuthenticationSystem,
        cashier: Cashier,
        session: Timekeeper,
    ):
        self._carts = dict()
        self._cart_owners = dict()
        self._catalog = catalog
        self._authenticator = authenticator
        self._cashier = cashier
        self._timekeeper = session

    def create_cart(self, user_name: str, user_password: str) -> str:
        self._authenticator.authenticate(user_name, user_password)
        return self._register_cart(user_name)

    def list_cart(self, cart_id: str) -> Counter:
        self._register_session_timestamp(cart_id)
        cart = self._cart(cart_id)
        return cart.list()

    def add_to_cart(self, cart_id: str, isbn_code: str, amount: int):
        self._register_session_timestamp(cart_id)
        cart = self._cart(cart_id)
        cart.add_books(isbn_code, amount)

    def checkout_cart(
        self, cart_id: str, credit_card: CreditCard, a_date: MonthYearDate
    ) -> str:
        self._register_session_timestamp(cart_id)
        cart = self._cart(cart_id)
        cart_owner = self._cart_owners[cart_id]

        receipt = self._cashier.checkout(cart, credit_card, a_date, cart_owner)
        cart.clear()
        return receipt.id()

    def list_purchases(
        self, user_name: str, password: str
    ) -> tuple[Counter[str], float]:
        self._authenticator.authenticate(user_name, password)
        return self._cashier.list_purchases(user_name)

    def cart_has_n_copies_of_book(
        self, cart_id: str, isbn_code: str, amount: int
    ) -> bool:
        cart = self._cart(cart_id)
        return cart.contains_n(isbn_code, amount)

    def contains_transaction(self, transaction_id: str) -> bool:
        return self._cashier.contains_transaction(transaction_id)

    def _cart(self, cart_id: str) -> Cart:
        try:
            return self._carts[cart_id]
        except KeyError:
            raise Exception(self.__class__.cart_not_found())

    def _register_cart(self, client_id: str) -> str:
        cart_id = str(uuid.uuid1())
        self._carts[cart_id] = Cart(self._catalog)
        self._cart_owners[cart_id] = client_id
        self._timekeeper.refresh(cart_id)
        return cart_id

    def _register_session_timestamp(self, cart_id: str):
        if cart_id not in self._carts:
            raise Exception(InternalInterface.cart_not_found())

        self._timekeeper.refresh_if_not_expired(cart_id)

    @classmethod
    def cart_not_found(cls) -> str:
        return "The cart was not found"
