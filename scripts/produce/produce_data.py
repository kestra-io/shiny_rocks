from faker import Faker
from faker.providers import BaseProvider
import uuid
import random
from math import pi, sin, cos
import datetime
import csv
import argparse

fake = Faker()

class ShinyRockProvier(BaseProvider):

    def order(self, order_date) -> str:
        return {
            "user_id": uuid.uuid4().hex,
            "order_id": uuid.uuid4().hex,
            "order_date": order_date,
            "product_id": int(select_string({"3": 0.64, "5": 0.36})),
            "utm_source": select_string({"_instagram": 0.2, "_amazon": 0.6, "_facebook": 0.1, "_youtube": 0.1})
        }

    def payment(self, order_id, product_id, order_date):
        return {
            "payment_id": uuid.uuid4().hex,
            "order_id": order_id,
            "order_date": order_date,
            "payment_method": select_string({"PAYPAL": 0.17, "CARD": 0.80, "APPLE_PAY": 0.03}),
            "amount": product_id * 99
        }

    def service(self, user_id, product_id, run_date):
        return {
            "service_id": select_string({"MAPS": 0.3, "MUSIC": 0.4, "PHONE": 0.1, "MESSAGE": 0.2}),
            "user_id": user_id,
            "product_id": product_id,
            "duration": get_random_number(range_a=5, range_b=3600),
            "run_date": run_date
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

def pattern_function(x, amplitude):
    v = -6.1
    t = 1.4
    return int(max(0, 25 * sin(2*pi*x/200 + pi/2) * v * sin(3*pi*x/500+pi/2) * t * cos(pi*x/100 + pi/3) * t + amplitude))

def date_to_int(date):
    dt = datetime.datetime.strptime(date, "%Y-%m-%d")
    return dt.timetuple().tm_yday

def write_list_of_dicts_to_csv(list_of_dicts, filename):
  with open(filename, "w", newline="") as csvfile:
    writer = csv.writer(csvfile, delimiter=",")
    header = list(list_of_dicts[0].keys())
    writer.writerow(header)
    for dict in list_of_dicts:
      row = []
      for key, value in dict.items():
        row.append(str(value))
      writer.writerow(row)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Produce data for the Shiny Rock fictional company")
    parser.add_argument("--date", help="The production date")
    args = parser.parse_args()

    fake.add_provider(ShinyRockProvier)

    order_date = args.date
    int_day = date_to_int(order_date)
    nb_order = pattern_function(int_day, 800)
    print(order_date, int_day, nb_order)

    orders = []    
    for i in range(0, nb_order):
        order = fake.order(order_date=order_date)
        orders.append(order)

    write_list_of_dicts_to_csv(orders, f"orders.csv")

    payments = []
    for order in orders:
        payment = fake.payment(order.get("order_id"), order.get("product_id"), order.get("order_date"))
        payments.append(payment)

    write_list_of_dicts_to_csv(payments, f"payments.csv")

    services = []
    for order in orders:
        for i in range(0, get_random_number(0, 10)):
            service_run = fake.service(order.get("user_id"), order.get("product_id"), order_date)
            services.append(service_run)
    
    write_list_of_dicts_to_csv(services, f"services.csv")