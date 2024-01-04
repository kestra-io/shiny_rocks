import pandas as pd
from prophet import Prophet

data = (
    pd.read_csv("data.csv")
    .query("product_id == {{ parents[0].taskrun.value }}")
    .rename(columns={"nb_order": "y", "order_date": "ds"})
    .sort_values(by="ds")
)

m = Prophet()
m.fit(data)

future = m.make_future_dataframe(periods=5)
forecast = m.predict(future)

forecast.to_csv("forecast.csv", index=False)
data.to_csv("historic.csv", index=False)
print(data)
print(forecast)