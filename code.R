library(tidyverse)
library(ggthemes)

#--------------------------------------------------------------
# coordinates : coord_cartesian
#--------------------------------------------------------------
p <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(alpha = 0.6) +
  geom_smooth()

p + scale_x_continuous(limits = c(4.5, 5.5)) # scale_x_continuous
p + xlim(c(4.5, 5.5)) # xlim
p + coord_cartesian(xlim = c(4.5, 5.5)) # coord_cartesian

#--------------------------------------------------------------
# coordinates : coord_flip
#--------------------------------------------------------------
jeonpo <- read_csv("cafe_jeonpo.csv")

# 데이터저널리즘 기사는 데스크탑에만 보는게 아니죠. 그럴때 coord_flip!
ggplot(jeonpo, aes(x = reorder(name, -`2017`), y = `2017`)) +
  geom_bar(stat = "identity") +
  theme_fivethirtyeight(base_family = "NanumGothic") +
  scale_y_continuous(labels = scales::comma)

# coord_flip은 모바일에서 보여줄 때 효과적이다
jeonpo %>% 
  filter(category == "카페" | category == "디저트" | category == "가게") %>% 
ggplot(aes(x = reorder(name, `2017`), y = `2017`, fill = category)) +
  geom_bar(stat = "identity") +
  theme_fivethirtyeight(base_family = "NanumGothic") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "부산 전포동 공시지가 비교", 
       subtitile = "카페, 디저트, 가게 중심으로", 
       caption = "출처 : 정보공개청구") +
  coord_flip()

#--------------------------------------------------------------
# facet을 알아보자
#--------------------------------------------------------------
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
