if(!require("pacman")){
  install.packages("pacman")
}

p_load(rio, dplyr, lubridate, stringr, purrr, hms, glue, ggplot2)
p_load_gh("hrbrmstr/taucharts")
