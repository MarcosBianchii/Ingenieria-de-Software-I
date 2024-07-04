from __future__ import annotations


class MonthYearDate:
    def __init__(self, month: int, year: int):
        cls = self.__class__

        if not cls.is_valid_date(month, year):
            raise Exception(cls.invalid_date())

        self.month = month
        self.year = year

    def preceeds(self, a_date: MonthYearDate) -> bool:
        if self.year < a_date.year:
            return True

        if self.year == a_date.year:
            return self.month < a_date.month

        return False

    @classmethod
    def is_valid_date(cls, month: int, year: int) -> bool:
        if year < 0:
            return False

        if month not in range(1, 13):
            return False

        return True

    @classmethod
    def invalid_date(cls) -> str:
        return "The given date is invalid"
