library(taucharts)
tauchart(non_business_hours_by_place[non_business_hours_by_place$Place != "Boston",]) %>%
tau_point("Population", "NonBizHours", size="Population") %>%
tau_guide_x(label="") %>%
tau_guide_y(label="") %>%
tau_tooltip() %>%  # includes all variables in mydf
tau_trendline( showPanel = FALSE )  %>%
tau_title("")


library(taucharts)
tauchart(framingham_and_similar_size) %>%
  tau_point("Population", "NonBizHours", size="Population") %>%
  tau_guide_x(label="") %>%
  tau_guide_y(label="") %>%
  tau_tooltip() %>%  # includes all variables in mydf
  tau_trendline( showPanel = FALSE )  %>%
  tau_title("")


ggplot(data = framingham_and_similar_size, aes(x= reorder(Place, NonBizHours), y=NonBizHours)) +
  geom_bar(stat="identity", color = "black", fill="#0072B2") +
  ggtitle("Non-Business Early Voting Hours") +
  xlab("") +
  ylab("") +
  theme_classic() +
  theme(plot.title=element_text(size=20))# +
 # theme(axis.text.x= element_text(angle=45, hjust = 1.3, vjust = 1.2))

