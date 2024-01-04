import pandas as pd
from plotnine import ggplot, geom_col, aes, ggsave

data = pd.read_csv("data.csv")
plot = (
    ggplot(data) + 
    geom_col(aes(x="platform", fill="platform", y="marketing_cost"))
)
ggsave(plot, "plot.png")