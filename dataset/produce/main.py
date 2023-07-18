from faker import Faker
from faker.providers import BaseProvider
import uuid
import random

fake = Faker()

class ShinyRockProvier(BaseProvider):

    def order(self, order_date) -> str:
        return {
            "user_id": uuid.uuid4().hex,
            "order_id": uuid.uuid4().hex,
            "order_date": order_date,
            "product_id": int(select_string({"3": 0.64, "5": 0.36}))
        }

    def payment(self, order_id, product_id):
        return {
            "payment_id": uuid.uuid4().hex,
            "order_id": order_id,
            "payment_method": select_string({"PAYPAL": 0.17, "CARD": 0.80, "APPLE_PAY": 0.03}),
            "amount": product_id * 99
        }

    def service(self, user_id, product_id, date):
        return {
            "service_id": select_string({"MAPS": 0.3, "MUSIC": 0.4, "PHONE": 0.1, "MESSAGE": 0.2}),
            "user_id": user_id,
            "product_id": product_id,
            "duration": get_random_number(range_a=5, range_b=3600),
            "date": date
        }


def get_random_number(range_a=5, range_b=20):
    return random.randint(range_a, range_b)


def select_string(probabilities):
    total = sum(probabilities.values())
    distribution = {key: value / total for key, value in probabilities.items()}
    rand_value = random.random()
    cumulative_prob = 0
    for key, value in distribution.items():
        cumulative_prob += value
        if rand_value <= cumulative_prob:
            return key

    # If no string is found (e.g., due to rounding errors), return None
    return None

fake.add_provider(ShinyRockProvier)

orders = []
order_date = "2023-07-01"
for i in range(0, get_random_number()):
    order = fake.order(order_date=order_date)
    orders.append(order)

print(orders)


payments = []
for order in orders:
    payment = fake.payment(order.get("order_id"), order.get("product_id"))
    payments.append(payment)

print(payments)

services = []
for order in orders:
    for i in range(0, get_random_number(0, 10)):
        service_run = fake.service(order.get("user_id"), order.get("product_id"), order_date)
        services.append(service_run)

print(services)