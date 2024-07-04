from internal_interface import InternalInterface
from credit_card import CreditCard
from month_year_date import MonthYearDate
from response import Response
from oauth_authentication_system import OAuthAuthenticationSystem
from cashier import Cashier
from typing import Callable
from timekeeper import Timekeeper


class ExternalInterface:
    def __init__(
        self,
        catalog: dict,
        authenticator: OAuthAuthenticationSystem,
        cashier: Cashier,
        tell_today: Callable,
        session: Timekeeper,
    ):
        self._interface = InternalInterface(catalog, authenticator, cashier, session)
        self._tell_today = tell_today

    def create_cart(self, request: dict) -> Response:
        try:
            client_id = request["clientId"]
            password = request["password"]
        except KeyError:
            return Response.key_not_found()

        try:
            cart_id = self._interface.create_cart(client_id, password)
        except Exception as e:
            return Response.failure(e)

        return Response.success(cart_id)

    def list_cart(self, request: dict) -> Response:
        try:
            cart_id = request["cartId"]
        except KeyError:
            return Response.key_not_found()

        try:
            books = self._interface.list_cart(cart_id)
        except Exception as e:
            return Response.failure(e)

        formatted_list = [f"{isbn_code}|{books[isbn_code]}" for isbn_code in books]

        return Response.success("|".join(formatted_list))

    def add_to_cart(self, request: dict) -> Response:
        try:
            cart_id = request["cartId"]
            isbn = request["bookIsbn"]
            quantity = int(request["bookQuantity"])
        except KeyError:
            return Response.key_not_found()
        except ValueError:
            return Response.book_quantity_is_not_numeric()

        try:
            self._interface.add_to_cart(cart_id, isbn, quantity)
        except Exception as e:
            return Response.failure(e)

        return Response.success("OK")

    def checkout_cart(self, request: dict) -> Response:
        try:
            cart_id = request["cartId"]
        except KeyError:
            return Response.key_not_found()

        try:
            credit_card_number = request["ccn"]
            owner = request["cco"]
            expiration_date = request["cced"]
        except KeyError:
            return Response.failure("The credit card information is incomplete")

        try:
            expiration_month = int(expiration_date[:2])
            expiration_year = int(expiration_date[2:6])
            expiration_date = MonthYearDate(expiration_month, expiration_year)
        except ValueError as e:
            return Response.expiration_month_year_not_numeric()
        except Exception as e:
            return Response.failure(e)

        try:
            credit_card = CreditCard(credit_card_number, expiration_date, owner)
        except Exception as e:
            return Response.failure(e)

        today = self._tell_today()
        try:
            transaction_id = self._interface.checkout_cart(cart_id, credit_card, today)
        except Exception as e:
            return Response.failure(e)

        return Response.success(transaction_id)

    def list_purchases(self, request: dict) -> Response:
        try:
            client_id = request["clientId"]
            password = request["password"]
        except KeyError:
            return Response.key_not_found()

        try:
            purchases, total_amount = self._interface.list_purchases(
                client_id, password
            )
        except Exception as e:
            return Response.failure(e)

        formatted_list = [f"{book}|{purchases[book]}" for book in purchases]

        return Response.success("|".join(formatted_list) + "|" + str(total_amount))
