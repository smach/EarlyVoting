# Note: You need a US Census API key to run this file/ See tidycensus vignette on how to install it. I ran this for you and saved the results in the data/commute_times.xlsx file.

library(tidycensus)

commute_times_long <- get_acs(geography = "place", state = "MA", variables = c("B08303_001", "B08303_002", "B08303_003", "B08303_004", "B08303_005", "B08303_006", "B08303_007", "B08303_008", "B08303_009", "B08303_010", "B08303_011","B08303_012", "B08303_013"), survey = "acs5")

commute_times <- select(commute_times_long, -moe, -GEOID) %>%
  spread("variable", "estimate")
names(commute_times) <- c("Place", "Total", "Less_than_5_mins", "5_to_9_mins", "10_to_14_mins", "15_to_19_mins", "20_to_24_mins", "25_to_29_mins", "30_to_34_mins", "35_to_39_mins", "40_to_44_mins", "45_to_59_mins", "60_to_89_mins", "90_mins_or_more")

commute_times <- mutate(commute_times, thirty_or_more = (`30_to_34_mins` + `35_to_39_mins` + `40_to_44_mins` + `45_to_59_mins` + `60_to_89_mins` + `90_mins_or_more`) / Total)
commute_times$thirty_or_more <- round(commute_times$thirty_or_more * 100, 1)

rio::export(commute_times, "data/commute_times.xlsx")
