from typing import Callable
from external_interface import ExternalInterface
from oauth_authentication_system import OAuthAuthenticationSystem
from month_year_date import MonthYearDate
from timekeeper import Timekeeper
from mercado_pago import MercadoPago
from cashier import Cashier
from flask import Flask, request, Response
from datetime import datetime
import sys


class WebServer:
    SESSION_TIME_IN_SECONDS: int = 60 * 30

    _catalog = {
        "9780137314942": 31_505,
        "9780321278654": 45_405,
        "9780201710915": 45_180,
        "9780321125217": 41_000,
        "9780735619654": 34_900,
        "9780321146533": 29_100,
    }

    _authenticator = OAuthAuthenticationSystem()
    _cashier = Cashier(MercadoPago())
    _session = Timekeeper(datetime, SESSION_TIME_IN_SECONDS)

    def _tell_today(self) -> MonthYearDate:
        today = datetime.now()
        month = int(today.month)
        year = int(today.year)
        return MonthYearDate(month, year)

    def __init__(self, port):
        self._port = port
        self._interface = ExternalInterface(
            self._catalog,
            self._authenticator,
            self._cashier,
            self._tell_today,
            self._session,
        )

    def run(self):
        app = Flask(__name__)

        # Estos métodos devuelven nuestro tipo `Response` pero
        # coliciona con el tipo `Response` de Flask.
        @app.route("/createCart")
        def create_cart():
            return self.endpoint_template(self._interface.create_cart)

        @app.route("/listCart")
        def list_cart():
            return self.endpoint_template(self._interface.list_cart)

        @app.route("/addToCart")
        def add_to_cart():
            return self.endpoint_template(self._interface.add_to_cart)

        @app.route("/checkOutCart")
        def checkout_cart():
            return self.endpoint_template(self._interface.checkout_cart)

        @app.route("/listPurchases")
        def list_purchases():
            return self.endpoint_template(self._interface.list_purchases)

        app.run(port=self._port)

    def endpoint_template(cls, f: Callable) -> Response:
        response = f(request.args.to_dict())
        status, response = response.formatted_response()
        return Response(status=status, response=response)


if __name__ == "__main__":
    args = sys.argv
    if len(args) < 2:
        print(f"python3 {args[0]} [port]")
        exit()

    port = args[1]
    sv = WebServer(port)
    sv.run()
