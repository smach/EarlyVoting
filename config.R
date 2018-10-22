# Loads necessary packages, installing if needed

if(!require("pacman")){
  install.packages("pacman")
}

p_load(rio, dplyr, lubridate, stringr, purrr, hms, glue, ggplot2, tibble, readr, tidyr, tools, tidycensus, here)
p_load_gh("hrbrmstr/taucharts")


