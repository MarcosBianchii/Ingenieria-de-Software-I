from __future__ import annotations
from typing import Any


class Response:
    def __init__(self, status: int, code: int, body: Any):
        self._status = status
        self._code = code
        self._body = str(body)

    @classmethod
    def success(cls, body: Any) -> Response:
        return cls(200, 0, body)

    @classmethod
    def failure(cls, body: Any) -> Response:
        return cls(404, 1, body)

    def succeeded(self) -> bool:
        return self._status == 200 and self._code == 0

    def failed(self) -> bool:
        return not self.succeeded()

    def body(self) -> str:
        return self._body

    def formatted_response(self) -> tuple[int, str]:
        return self._status, f"{self._code}|{self.body()}"

    @classmethod
    def key_not_found(cls) -> Response:
        return cls.failure("Invalid Request: Field not found")

    @classmethod
    def book_quantity_is_not_numeric(cls) -> Response:
        return cls.failure("Book quantity is not a number")

    @classmethod
    def expiration_month_year_not_numeric(cls) -> Response:
        return cls.failure("The expiration month or year is not numeric")
