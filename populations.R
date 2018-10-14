pops <- rio::import("data/acs2016_5yr_B01003_06000US2502141515.zip") %>%
  slice(-1) %>%
  rename(Place = name, Population = B01003001, MoE = `B01003001, Error`) %>%
  arrange(desc(Population))

pops$number <- as.integer(rownames(pops))
framingham <- pops$number[str_detect(pops$Place, "Framingham")]

smaller5 <- framingham + 5
larger5 <- framingham - 5
cities <- pops[smaller5:larger5,]

pops$Place <- ifelse(pops$Place == "Fall River city, Bristol County, MA", "Fall River", str_replace(pops$Place, "(.*?)\\s.*$", "\\1") )
pop_lookup <- pops$Population
names(pop_lookup) <- pops$Place

income <- rio::import("data/acs2016_5yr_B19013_06000US2502141515/acs2016_5yr_B19013_06000US2502141515/acs2016_5yr_B19013_06000US2502141515.csv") %>%
  slice(-1) %>%
  rename(Place = name, MedianIncome = B19013001) %>%
  arrange(desc(MedianIncome))

income$Place <- ifelse(income$Place == "Fall River city, Bristol County, MA", "Fall River", str_replace(income$Place, "(.*?)\\s.*$", "\\1") )
income_lookup <- income$MedianIncome
names(income_lookup) <- income$Place
