# Assumes cart_id already exists in self._timestamps
class Timekeeper:
    def __init__(self, clock, session_duration: int):
        self._clock = clock
        self._session_duration = session_duration
        self._timestamps = dict()

    def refresh(self, cart_id: str):
        self._timestamps[cart_id] = self._clock.now()

    def is_expired(self, cart_id: str) -> bool:
        return (
            abs((self._clock.now() - self._timestamps[cart_id]).total_seconds())
            >= self._session_duration
        )

    def refresh_if_not_expired(self, cart_id: str):
        if self.is_expired(cart_id):
            raise Exception(self.__class__.session_expired())

        self.refresh(cart_id)

    @classmethod
    def session_expired(cls) -> str:
        return "The session has expired"
