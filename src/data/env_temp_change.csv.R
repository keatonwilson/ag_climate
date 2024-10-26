library(tidyverse)
library(stringr)
library(lubridate)

# initial data load
env_data <- read_csv("./src/data-files/Environment_Temperature_change_E_All_Data.csv") # nolint: line_length_linter.

# init wrangling
subset_clean <- env_data |>
  select(
    Area,
    Months,
    Element,
    starts_with("Y"),
    -ends_with("F")
  ) |>
  pivot_longer(
    starts_with("Y"),
    names_to = "Year",
    values_to = "temp_change"
  ) |>
  mutate(Year = as.integer(str_remove(Year, "^Y"))) |>
  filter(Months %in% month.name)

# for each year, cumulative change across all months
out = subset_clean |>
  mutate(month_number = month(parse_date_time(Months, "B"))) |>
  group_by(Area) |>
  arrange(Year, month_number) |>
  ungroup() |>
  summarize(temp_change_sum = sum(temp_change, na.rm = TRUE), 
    .by = c("Area", "Year")
  )

# converteing to delimted string so that data can be viewed by Observable
cat(format_csv(out))
