library(taucharts)
tauchart(non_business_hours_by_place[non_business_hours_by_place$Place != "Boston",]) %>%
tau_point("RegVoters", "NonBizHours", size="RegVoters") %>%
tau_guide_x(label="") %>%
tau_guide_y(label="") %>%
tau_tooltip() %>%  # includes all variables in mydf
tau_trendline( showPanel = FALSE )  %>%
tau_title("")



tauchart(framingham_and_similar_size) %>%
  tau_point("RegVoters", "NonBizHours", size="RegVoters") %>%
  tau_guide_x(label="") %>%
  tau_guide_y(label="") %>%
  tau_tooltip() %>%  # includes all variables in mydf
  tau_trendline( showPanel = FALSE )  %>%
  tau_title("")

tauchart(framingham_and_similar_size) %>%
  tau_point("RegVoters", "TotalHours", size="RegVoters") %>%
  tau_guide_x(label="") %>%
  tau_guide_y(label="") %>%
  tau_tooltip() %>%  # includes all variables in mydf
  tau_trendline( showPanel = FALSE )  %>%
  tau_title("")


# This is key for serving commuters

tauchart(framingham_and_similar_size) %>%
  tau_point("PctThirtyMinPlusCommute", "RegVotersPerNonBizHour", size="RegVoters") %>%
  tau_guide_x(label="Pct With Commute of 30 Mins or More") %>%
  tau_guide_y(label="Registered Voters Per Non-Business Early-Voting Hours") %>%
  tau_tooltip() %>%  # includes all variables in mydf
  tau_trendline( showPanel = FALSE )  %>%
  tau_title("Percent Working Population With Commutes of 30 Mins or More vs Registered Voters per Non-Biz Early-Voting Hours")


ggplot(data = framingham_and_similar_size, aes(x= reorder(Place, NonBizHours), y=NonBizHours)) +
  geom_bar(stat="identity", color = "black", fill="#0072B2") +
  ggtitle("Non-Business Early Voting Hours") +
  xlab("") +
  ylab("") +
  theme_classic() +
  theme(plot.title=element_text(size=20))# +
 # theme(axis.text.x= element_text(angle=45, hjust = 1.3, vjust = 1.2))


ggplot(data = framingham_and_similar_size, aes(x= reorder(Place, RegVotersPerNonBizHour), y=RegVotersPerNonBizHour)) +
  geom_bar(stat="identity", color = "black", fill="#0072B2") +
  ggtitle("Registered Voters per Non-Business Early Voting Hours") +
  xlab("") +
  ylab("") +
  theme_classic() +
  theme(plot.title=element_text(size=20))

