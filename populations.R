pops <- rio::import("data/acs2016_5yr_B01003_06000US2502141515.zip") %>%
  slice(-1) %>%
  rename(Place = name, Population = B01003001, MoE = `B01003001, Error`) %>%
  arrange(desc(Population))

pops$number <- as.integer(rownames(pops))
framingham <- pops$number[str_detect(pops$Place, "Framingham")]

smaller5 <- framingham + 5
larger5 <- framingham - 5
cities <- pops[smaller5:larger5,]

voters <- rio::import("data/enrollment_count_20180815.xlsx") %>%
  rename(Place = `Aggregate Totals`) %>%
  arrange(desc(Voters)) %>%
  mutate(
    Place = tolower(Place),
    Place = tools::toTitleCase(Place)
  )



pops$Place <- ifelse(pops$Place == "Fall River city, Bristol County, MA", "Fall River", str_replace(pops$Place, "(.*?)\\s.*$", "\\1") )
pop_lookup <- pops$Population
names(pop_lookup) <- pops$Place

voters_lookup <- voters$Voters
names(voters_lookup) <- voters$Place

income <- rio::import("data/acs2016_5yr_B19013_06000US2502141515/acs2016_5yr_B19013_06000US2502141515/acs2016_5yr_B19013_06000US2502141515.csv") %>%
  slice(-1) %>%
  rename(Place = name, MedianIncome = B19013001) %>%
  arrange(desc(MedianIncome))

income$Place <- ifelse(income$Place == "Fall River city, Bristol County, MA", "Fall River", str_replace(income$Place, "(.*?)\\s.*$", "\\1") )
income_lookup <- income$MedianIncome
names(income_lookup) <- income$Place

commute_times <- rio::import("data/commute_times.xlsx")
commute_times$Place <- str_remove_all(commute_times$Place, " CDP, Massachusetts")
commute_times$Place <- str_remove_all(commute_times$Place, " Town city, Massachusetts")
commute_times$Place <- str_remove_all(commute_times$Place, " city, Massachusetts")

thirty_or_more_commute <- commute_times$thirty_or_more
names(thirty_or_more_commute) <- commute_times$Place

framingham_voters_by_precinct <- rio::import("data/2017_general_turnout_framingham.csv") %>%
  mutate(
    precinct = as.character(precinct)
  )

early_vote_area <- rio::import("data/PrecinctEarlyVotingLocations.xlsx")
early_vote_area_lookup <- early_vote_area$EarlyVotingLocation
early_vote_area$Precinct <- as.character(early_vote_area$Precinct)
names(early_vote_area_lookup) <- early_vote_area$Precinct

framingham_voters_by_precinct$EarlyVoteLocation <- early_vote_area_lookup[framingham_voters_by_precinct$precinct]

voters_by_location <- framingham_voters_by_precinct %>%
  group_by(EarlyVoteLocation) %>%
  summarize(
    RegisteredVoters = sum(total_registered_voters)
  )

