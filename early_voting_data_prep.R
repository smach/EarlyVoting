# Data import and wrangling for early voting data

# Read in spreadsheet with early voting data for each community in a separate tab:

# Function to read in a tab and add column for Place equal to the tab name
import_tab <- function(tabname, myfile = "data/EarlyVotingTimes.xlsx"){
  x <- readxl::read_xlsx(myfile, tabname)
  x$Place <- tabname
  return(x)
}

# Get name of all tabs in the spreadsheet
alltabs <- readxl::excel_sheets("data/EarlyVotingTimes.xlsx")

# Read in each tab and create data frame
early_voting_basic <- purrr::map_df(alltabs, import_tab)


# Create columns to calculate start and end times, number of morning, evening, and weekend hours
early_voting <- early_voting_basic %>%
  mutate(
  StartTime = parse_time(str_replace(Time, "(.*?) - .*$", "\\1")),
  EndTime = parse_time(str_replace(Time, "(.*?) - (.*$)", "\\2")),
  # StartHour = as.integer(str_replace(StartTime, "(.*?)\\:.*?$", "\\1")),
  # StartMinute = as.integer(str_replace(StartTime, ".*?\\:(..).*?$", "\\1")),
  # StartAMPM = str_replace(StartTime, ".*?(..)$", "\\1"),
  # EndHour = as.integer(str_replace(EndTime, "(.*?)\\:.*?$", "\\1")),
  # EndMinute = as.integer(str_replace(EndTime, ".*?\\:(..).*?$", "\\1")),
  # EndAMPM = str_replace(EndTime, ".*?(..)$", "\\1"),
  # StartHour = ifelse(StartAMPM == "PM" & StartHour < 12, StartHour + 12, StartHour),
  # EndHour = ifelse(EndAMPM == "PM" & EndHour < 12, EndHour + 12, EndHour),
  Weekend = ifelse(Day == "Saturday" | Day == "Sunday", TRUE, FALSE),
 # Morning = ifelse(StartHour < 8, TRUE, FALSE),
 #  Evening = ifelse(EndHour > 18, TRUE, FALSE)
   Morning = ifelse(StartTime < as.hms("08:00:00"), TRUE, FALSE),
   Evening = ifelse(EndTime > as.hms("18:00:00"), TRUE, FALSE)
  )

# discovered readr::parse_time() don't need all this detailed code doing the calculations

# early_voting$StartMinuteFraction <- case_when(
#   early_voting$StartMinute == 0 ~ 0,
#   early_voting$StartMinute == 15 ~ -.25,
#   early_voting$StartMinute == 30 ~ -.5,
#   early_voting$StartMinute == 45 ~ -.75
# )
# 
# early_voting$EndMinuteFraction <- case_when(
#   early_voting$EndMinute == 0 ~ 0,
#   early_voting$EndMinute == 15 ~ .25,
#   early_voting$EndMinute == 30 ~ .50,
#   early_voting$EndMinute == 45 ~ .75
# )

# early_voting <- early_voting %>%
#   mutate(
#     WeekendHours = ifelse(Weekend, (EndHour - StartHour + StartMinuteFraction + EndMinuteFraction), 0),
#     MorningHours = ifelse(Morning, ((8 - StartHour) + StartMinuteFraction), 0),
#     EveningHours = ifelse(Evening, ((EndHour - 18) + EndMinuteFraction), 0),
#     TotalNonBusiness = WeekendHours + MorningHours + EveningHours,
#     TotalHours = EndHour - StartHour + StartMinuteFraction + EndMinuteFraction
#   )


early_voting <- early_voting %>%
  mutate(
    WeekendHours = ifelse(Weekend, (as.integer(EndTime - StartTime)) / 3600, 0),
    MorningHours = ifelse(Morning, (as.integer(as.hms("08:00:00") - StartTime) / 3600), 0),
    # MorningHours = ifelse(Morning, ((8 - StartHour) + StartMinuteFraction), 0),
   # EveningHours = ifelse(Evening, ((EndHour - 18) + EndMinuteFraction), 0),
     EveningHours = ifelse(Evening, (as.integer(EndTime - as.hms("18:00:00"))) / 3600, 0),
    TotalNonBusiness = WeekendHours + MorningHours + EveningHours,
    # TotalHours = EndHour - StartHour + StartMinuteFraction + EndMinuteFraction
   TotalHours = (as.integer(EndTime - StartTime))/3600
  )

