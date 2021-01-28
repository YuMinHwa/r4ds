library(tidyverse)

data(diamonds)
diamonds

ggplot(diamonds) +
  geom_bar(aes(x = cut))

diamonds %>% 
  count(cut)

# geom_bar(1변수), geom_col(2변수), group_by %>% count(2변수) 를 그래프로 표현한 것

diamonds %>% 
  group_by(color) %>% 
  count(cut)

ggplot(diamonds) +
  geom_col(aes(x = color,
            y = cut))

ggplot(diamonds) +
  geom_col(aes(x = color,
               y = cut,
               fill = color))

#연속형 변수

ggplot(diamonds) +
  geom_histogram(aes(x = carat), binwidth = 0.5)

#도수분포표(위의 그래프와 같음)

diamonds %>% 
  count(cut_width(carat, 0.5))

small <- diamonds %>% 
  filter(carat < 3)

ggplot(small, aes(x = carat)) +
  geom_histogram(binwidth = 0.1)

ggplot(small, aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1)
# geom_freqpoly 히스토그램을 선으로 그린 것

ggplot(small, aes(x = carat)) +
  geom_histogram(binwidth = 0.01)
#값을 작게하면 집결이 보인다.

ggplot(faithful, aes(x = eruptions)) +
  geom_histogram(binwidth = 0.25)

#바를 더 작게 만들어서 자세하게 볼 수 있다.
ggplot(faithful, aes(x = eruptions)) +
  geom_histogram(binwidth = 0.05)

#이상치
ggplot(diamonds) +
  geom_histogram(aes(x = y),
                 binwidth = 0.5)

diamonds %>% 
  count(cut_width(y, 0.5))

ggplot(diamonds) +
  geom_histogram(aes(x = y),
                 binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))

#이상치를 뽑아본 것
unusual <- diamonds %>% 
  filter(y < 3 | y > 20) %>% 
  select(price, x, y, z) %>% 
  arrange(y)
unusual
#1~7까지가 이상치임


#문제 7.3.1
ggplot(diamonds) +
  geom_histogram(aes(x = x), binwidth = 0.5)

ggplot(diamonds) +
  geom_histogram(aes(x = y), binwidth = 0.5)

ggplot(diamonds) +
  geom_histogram(aes(x = z), binwidth = 0.5)

diamonds %>% 
  count(cut_width(x, 0.5))

diamonds %>% 
  count(cut_width(y, 0.5))

diamonds %>% 
  count(cut_width(z, 0.5))

#문제 7.3.2
ggplot(diamonds) +
  geom_histogram(aes(x = price))


ggplot(diamonds, aes(x = price, color = cut)) +
  geom_freqpoly(binwidth = 0.3)

#문제 7.3.3
diamonds %>% 
  filter(carat == 0.99)
#23개

diamonds %>% 
  filter(carat == 1)
#1558개

#문제 7.3.4
ggplot(diamonds) +
  geom_histogram(aes(x = price)) +
  coord_cartesian(xlim = c(100, 5000), ylim = c(0, 3000))

ggplot(diamonds) +
  geom_histogram(aes(x = price)) +
  xlim(100, 5000) +
  ylim(0, 3000)

#문제 7.4.1

diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))
#between(y, 3, 20)은 filter(y >= 3 & y <= 20)와 같음

#ifelse로 결측치를 NA로 바꾸기
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

ggplot(diamonds2, aes(x = x,
                      y = y)) +
  geom_point()

#문제 7.4.2
#이렇게 하면 위험 안 뜸
ggplot(diamonds2, aes(x = x,
                      y = y)) +
  geom_point(na.rm = TRUE)

#문제 7.5.1
library(nycflights13)

flights %>% 
  mutate(
    cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot(aes(x = cancelled,
             y = sched_dep_time)) +
  geom_boxplot(aes(color = cancelled),
                binwidth = 1/4)

#문제 7.5.1(2)
ggplot(diamonds) +
  geom_point(aes(x = carat,
                 y = price))

?fct_rev

ggplot(diamonds, aes(x = price,
                     y = clarity)) +
  geom_boxplot()

ggplot(diamonds, aes(x = price,
                     y = carat)) +
  geom_boxplot()

ggplot(diamonds, aes(x = price,
                     y = color)) +
  geom_boxplot()

#가격을 예측하는데 가장 필요한 변수는 carat.

#문제 7.5.1(3)
install.packages("ggstance")
library(ggstance)
data(mpg)

ggplot(mpg, aes(x = class,
                y = hwy)) +
  geom_boxplot() +
  coord_flip()

ggplot(mpg, aes(y = class,
                x = hwy)) +
  geom_boxploth()

# x,y 쓰는 게 다르다


#boxplot 그래프를 세로로 변경해주는 건 똑같은데 coord_flip은 원래 세로 그래프였던 걸 가로로 하는 것이다 ggstance를 쓰면 그 자체를 그리는 걸 옆으로 돌려주는 그래프이다.

#문제 7.5.1(4)
install.packages("lvplot")
library(lvplot)

#boxplot이 용량 큰 데이터를 정확하게 안 나타내는데 lv를 사용함으로써 큰 데이터를 정확하게 나타낸다
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_lv()

#문제 7.5.1(5)
ggplot(diamonds, aes(x = price,
                     y = ..density..)) +
  geom_freqpoly(aes(color = cut), binwidth = 500)

#..density..은 밀도, 비율을 나타내는 것

ggplot(diamonds, aes(x = price,
                     y = stat(density))) +
  geom_freqpoly(aes(color = cut), binwidth = 500)

#최근에는 이렇게 쓴다.

ggplot(diamonds, aes(x = carat, 
                     y = price)) +
  geom_point() +
  geom_jitter()

ggplot(data = diamonds, aes(x = cut, y = price)) +
  geom_violin() +
  coord_flip()
# violin은 최빈값을 알 수 있다

#문제 7.5.1(6)
install.packages("ggbeeswarm")
library(ggbeeswarm)

ggplot(data = mpg) +
  geom_quasirandom(aes(x = reorder(class, hwy, FUN = median),
                       y = hwy))

# 문제 7.5.2(1)
diamonds %>% 
  count(color, cut) %>% 
  group_by(cut) %>% 
  mutate(prop = n / sum(n)) %>% 
  ggplot(aes(x = color,
             y = cut)) +
  geom_tile(aes(fill = prop))

diamonds %>% 
  count(color, cut) %>% 
  ggplot(aes(x = color,
             y = cut)) +
  geom_tile(aes(fill = n))

#7.5.2(2)
data(flights)

flights %>% 
  group_by(month, dest) %>% 
  summarise(delay = mean(arr_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x = dest,
             y = factor(month))) +
  geom_tile(aes(fill = delay))

flights %>%
  group_by(month, dest) %>%                     
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  group_by(dest) %>%                            
  filter(n() == 12) %>%                       
  ungroup() %>%
  mutate(dest = reorder(dest, dep_delay)) %>%
  ggplot(aes(x = factor(month), y = dest, fill = dep_delay)) +
  geom_tile() +
  labs(x = "Month", y = "Destination", fill = "Departure Delay")

# month와 dest가 너무 많기 때문에 group_by를 써서 나눌 수 있다.

# 문제 7.5.2(3)
diamonds %>%
  count(color, cut) %>%
  ggplot(aes(x = color, y = cut)) +
  geom_tile(aes(fill = n))

diamonds %>%
  count(color, cut) %>%
  ggplot(aes(y = color, x = cut)) +
  geom_tile(aes(fill = n))
# 큰 범주형을 변수로 사용하거나 y축에 사용하기 떄문이다.

#문제 7.5.3.1
ggplot(
  data = diamonds, aes(color = cut_number(carat, 5), x = price)
) +
  geom_freqpoly() +
  labs(x = "Price", y = "Count", color = "Carat")

ggplot(
  data = diamonds,
  mapping = aes(color = cut_width(carat, 1, boundary = 0), x = price)
) +
  geom_freqpoly() +
  labs(x = "Price", y = "Count", color = "Carat")

#문제 7.5.3.2
ggplot(diamonds, aes(x = cut_number(price, 10), y = carat)) +
  geom_boxplot() +
  coord_flip() 

#문제 7.5.3.3

summary(diamonds$carat)

install.packages("modelr")
library(modelr)
mod <- lm(log(price) ~ log(carat), data = diamonds)

diamonds2 <- diamonds %>% 
  add_residuals(mod) %>% 
  mutate(resid = exp(resid))

#exp 자연지수를 씌우는 것(큰 건 무한대로 만드는 것)
ggplot(diamonds2) +
  geom_point(aes(x = carat,
                 y = resid))
#3이상인 부분에서는 carat이 클수록 가격이 높다는 것을 말한다.
ggplot(diamonds2, aes(x = cut,
                      y = resid)) +
  geom_boxplot()
# 좋은 다이아몬드일 수록 더 많이 비싸다는 것을 알 수 있다

#문제 7.5.3.4
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11))

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  facet_wrap(~cut, ncol = 1)
# 차원을 늘리면 정보를 관계속에서 확인할 수 있기 때문에 유용하다.