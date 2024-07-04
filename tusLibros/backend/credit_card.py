from month_year_date import MonthYearDate


class CreditCard:
    def __init__(self, number: str, expiration_date: MonthYearDate, owner: str):
        if len(number) == 0 or len(owner) == 0:
            raise Exception(self.__class__.empty_field())

        self._number = number
        self._expiration_date = expiration_date
        self._owner = owner

    def is_expired(self, a_date: MonthYearDate) -> bool:
        return self._expiration_date.preceeds(a_date)

    def number(self) -> str:
        return self._number

    @classmethod
    def empty_field(cls) -> str:
        return "A field in the given credit card is empty"
