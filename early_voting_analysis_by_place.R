non_business_hours_by_place <- early_voting %>%
  group_by(Place) %>%
  summarize(
    EarlyHours = sum(MorningHours),
    LateHours = sum(EveningHours),
    WeekendHours = sum(WeekendHours),
    NonBizHours = sum(TotalNonBusiness),
    TotalHours = sum(TotalHours)
  ) %>%
  arrange(desc(NonBizHours)) %>%
  mutate(
    Population = unname(pop_lookup[Place]),
    MedianHouseholdIncome = unname(income_lookup[Place]),
    PopPerNonBizHour = round(Population/NonBizHours),
    IncomePerNonBizHour = round(MedianHouseholdIncome/NonBizHours),
    PopPerHour = round(Population/TotalHours),
    IncomePerHour = round(MedianHouseholdIncome/TotalHours)
  )


framingham_and_similar_size <- early_voting %>%
  filter(Place %in% alltabs[1:11]) %>%
  group_by(Place) %>%
  summarize(
    EarlyHours = sum(MorningHours),
    LateHours = sum(EveningHours),
    WeekendHours = sum(WeekendHours),
    NonBizHours = sum(TotalNonBusiness),
    TotalHours = sum(TotalHours)
  ) %>%
  arrange(desc(NonBizHours)) %>%
  mutate(
    Population = unname(pop_lookup[Place]),
    MedianHouseholdIncome = unname(income_lookup[Place]),
    PopPerNonBizHour = round(Population/NonBizHours),
    IncomePerNonBizHour = round(MedianHouseholdIncome/NonBizHours),
    PopPerHour = round(Population/TotalHours),
    IncomePerHour = round(MedianHouseholdIncome/TotalHours)
  )

  

