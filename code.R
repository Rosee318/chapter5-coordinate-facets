cafe <- read_csv("cafe.csv")
head(cafe)

ggplot(cafe, aes(x=행정구역, y=`2014년06월`)) +
  geom_bar(stat = "identity") +
  theme_bw(base_family = "NanumGothic") +
  geom_hline(yintercept = median(cafe$`2014년06월`, na.rm = T), 
             color = "red",
             linetype = "dashed")

ggplot(cafe %>% gather("dates", "value", 2:7), 
       aes(x=행정구역, y=value, fill=dates)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_bw(base_family = "NanumGothic") +
  facet_wrap(.~dates)


df_bus <- read_csv("bus.csv")
ggplot(df_bus, aes(x=year, y=total, group = dong, colour = dong)) + 
  geom_line(size = 0.8) + 
  geom_point() +
  facet_wrap(. ~ dong) +
  guides(colour=FALSE) +
  geom_text(aes(label = total), vjust = -1.2)
