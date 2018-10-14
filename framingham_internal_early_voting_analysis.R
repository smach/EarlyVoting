framingham_voting <- early_voting %>%
  filter(Place == "Framingham") %>%
  group_by(Location) %>%
  summarize(
    EarlyHours = sum(MorningHours),
    LateHours = sum(EveningHours),
    WeekendHours = sum(WeekendHours),
    NonBizHours = sum(TotalNonBusiness),
    TotalHours = sum(TotalHours)
  ) 

framingham_voting$Location[1] <- "McAuliffe Library"
  framingham_voting$Location[2] <- "City Hall"
  
  framingham_voting <- merge(framingham_voting, voters_by_location, by.x = "Location", by.y = "EarlyVoteLocation")


framingham_voting <- framingham_voting %>%
  mutate(
  VotersPerNonBizHour = round(RegisteredVoters/NonBizHours),
  VotersPerHour = round(RegisteredVoters/TotalHours)
)

framingham_voting_by_place_and_day <- early_voting %>%
  dplyr::filter(Place == "Framingham") %>%
  group_by(Location, Day) %>%
  summarize(
    TotalHours = sum(TotalHours)
  ) %>%
  mutate(
    Day = factor(Day, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"), ordered = TRUE)
  ) %>%
  ungroup() %>%
  as_tibble()

framingham_voting_by_place_and_day <- tibble::add_row(framingham_voting_by_place_and_day, Location = "MCAULIFFE LIBRARY", Day = "Monday", TotalHours = 0)
framingham_voting_by_place_and_day <- tibble::add_row(framingham_voting_by_place_and_day, Location = "MCAULIFFE LIBRARY", Day = "Friday", TotalHours = 0)
framingham_voting_by_place_and_day <- tibble::add_row(framingham_voting_by_place_and_day, Location = "MCAULIFFE LIBRARY", Day = "Saturday", TotalHours = 0)

ggplot(framingham_voting_by_place_and_day, aes(x=Day, y=TotalHours, fill=Location)) + 
  geom_bar(stat="identity", position="dodge") +
  scale_fill_brewer(palette="Dark2") +
  theme_minimal()

ggplot(framingham_voting, aes(x=Location, y=TotalHours, fill=Location)) + 
  geom_bar(stat="identity", position="dodge") +
  scale_fill_brewer(palette="Dark2") +
  theme_minimal()

ggplot(framingham_voting, aes(x=Location, y=NonBizHours, fill=Location)) + 
  geom_bar(stat="identity", position="dodge") +
  scale_fill_brewer(palette="Dark2") +
  theme_minimal()



