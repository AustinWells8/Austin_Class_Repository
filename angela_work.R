#Build a simple graph

# Load packages
library(ggplot2)
library(EVR628tools)

# Load data
data("data_heatwaves")

?data_heatwaves

# Build a plot
ggplot(data = data_heatwaves,
       mapping = aes(x = year, y = mhw_int_cumulative,
                     group = paste(fishery, eu_rnpa))) + geom_line()

x <- ggplot(data = data_heatwaves,
       mapping = aes(x = year, y = mhw_int_cumulative,
                     group = paste(fishery, eu_rnpa))) + geom_line() +
  labs(title = "Heat waves per year")

x
