from typing import Callable, Any
from datetime import datetime, timedelta


class AuthenticatorStub:
    def __init__(self, callable: Callable):
        self._callable = callable

    def authenticate(self, username, password) -> Any:
        return self._callable(username, password)


class PosnetStub:
    def __init__(self, callable: Callable):
        self._callable = callable

    def debit(self, amount_to_debit, credit_card) -> Any:
        return self._callable(amount_to_debit, credit_card)


class ClockStub:
    def __init__(self):
        self._time = datetime.now()

    def time_leap(self, time_in_seconds: int):

        self._time += timedelta(seconds=time_in_seconds)

    def now(self) -> int:
        return self._time
