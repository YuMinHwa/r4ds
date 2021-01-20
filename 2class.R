#그래프를 한눈에 보여주는 패키지 
install.packages("egg")

library(tidyverse)
library(nycflights13)

data("flights")
flights


flight_monthday <- flights %>% 
  filter(month == 1,
         day == 1)

flight_monthday12 <- flights %>% 
  filter(month == 12,
         day == 25)

flight_monthday4 <- flights %>% 
  filter(month == 4,
         day == 1)


gg_arr1 <- ggplot(flight_monthday, aes(x = dep_delay)) +
  geom_histogram()

gg_arr12 <- ggplot(flight_monthday12, aes(x = dep_delay)) +
  geom_histogram()

gg_arr4 <- ggplot(flight_monthday4, aes(x = dep_delay)) +
  geom_histogram()




#그래프를 한눈에 보여주는 패키지 
library(egg)

ggarrange(gg_arr1,
          gg_arr12,
          gg_arr4)

g_arr1 <- ggplot(flight_monthday, aes(x = arr_delay)) +
  geom_histogram()

g_arr12 <- ggplot(flight_monthday12, aes(x = arr_delay)) +
  geom_histogram()

g_arr4 <- ggplot(flight_monthday4, aes(x = arr_delay)) +
  geom_histogram()

ggarrange(g_arr1,
          g_arr12,
          g_arr4)

#이상치는 평균값에 영향을 많이 받으므로 중앙값을 많이 사용


#3달만 뽑기(두가지 방법(c로 묶기,|사용))
flig_months3 <- flights %>% 
  filter(month==1 | month==12 | month==4)

a1 <- flig_months3 %>% 
  filter(arr_delay<=120)

#3.2.4 e번 문제
flights %>% 
  filter(arr_delay>=120,
         dep_delay<=0)

#도착연착을 오름차순으로 정렬
flights %>% 
  arrange(arr_delay)

#도착연착을 내림차순으로 정렬
flights %>% 
  arrange(-arr_delay)

#여러가지로 할 경우
flights %>% 
  arrange(-arr_delay,-dep_delay)

#범주형으로 할 경우 abc로 정렬


##select
sel_ymd <- flights %>% 
  select(year, month, day)
sel_ymd <- flights %>% 
  select(year : day)

#필요없는 걸 뺄 경우는 -
sel_1 <- flights %>% 
  select(-distance : -time_hour)

#select는 rename 기능으로 쓸 수도 있음
flights %>% 
  select(time = dep_time)

##보고 싶은 변수를 앞에 쓰고 나머지는 깔아줄 때 사용(중요!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
flights %>% 
  select(dest, everything())

flights %>% 
  select(dest : dep_time, everything())


##변수 이름을 사용해 공통의 말을 뽑아낼 때 사용

#시작하는 이름 뽑아낼 때
flights %>% 
  select(dest, starts_with("delay"))
#끝나는 이름을 뽑아낼 때 
flights %>% 
  select(dest, ends_with("delay"))


flights %>% 
  select(starts_with("sched"), everything())


##mutate
#쓰고 싶은 변수만 추리기
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time)

flights_sml

flights_sml %>% 
  mutate(gain = arr_delay - dep_delay,
         speed = distance / air_time * 60)

#5.5.2 연습문제 2번
#arrtime = 활주로에서 떠서 내리는 시간
#dep_time = 택시웨이부터 시작
flights %>% 
  mutate(ar1 = arr_time - dep_time) %>% 
  select(air_time, ar1)

flights_sml %>% 
  mutate(ind = arr_delay > dep_delay) %>% 
  filter(ind)
#filter는 TRUE 값만 남긴다 그래서 밑에랑 코드가 같음

flights_sml %>% 
  filter(arr_delay > dep_delay)

#FALSE만 남길 때 !를 사용
flights_sml %>% 
  mutate(ind = arr_delay > dep_delay) %>% 
  filter(!ind)

flights_sml %>% 
  filter(!(arr_delay > dep_delay))



### 연습문제
## 3.2.4
# a. 2시간 이상 도착 지연
flights %>% 
  filter(arr_delay >= 120)
# b. 휴스턴으로 운항
flights %>% 
  filter(dest == "IAH" | dest == "HOU")
# c. 
airlines
a14 <- flights %>% 
  filter(carrier %in% c("AA","DL","UA"))
# d
a15 <- flights %>% 
  filter(month == c(7,8,9))
# e.
flights %>% 
  filter(arr_delay>=120,
         dep_delay<=0)
# f.
flights %>% 
  filter(dep_delay>=60,
         dep_delay - arr_delay > 30)
# g.
flights %>% 
  filter(dep_time <= 600|dep_time == 2400)

## 2번
# between()은 구간을 조회할 때 사용하는 함수이다.

## 3번
flights %>% 
  filter(is.na(dep_time))
table(is.na(flights$dep_time))
#결측지는 8255개
summary(flights)

## 4번
NA ^ 0
NA | TRUE
FALSE & NA
# NA를 하나의 값으로 취급하기 때문이다


### 3.3.1
## 1.
arrange(flights, !is.na(dep_time))

## 2.
arrange(flights, desc(dep_delay))
arrange(flights, dep_delay)

## 3.
flights %>% 
  arrange(air_time)

## 4.
flights %>% 
  select(distance, carrier) %>% 
  arrange(desc(distance))
# 긴 항공편은 HA
flights %>% 
  select(distance, carrier) %>% 
  arrange(distance)
# 짧은 항공편은 US


### 3.4.1
## 1.
flights %>% 
  select(dep_time, dep_delay, arr_time, arr_delay)

flights %>% 
  select(starts_with("dep_"), starts_with("arr_"))

flights %>% 
  select(ends_with("time"), ends_with("delay"))

## 2.
flights %>% 
  select(dep_time, dep_time, dep_time, dep_time)
# 중복하여도 한 번만 나온다

## 3.
# all_of() 모두 다 TRUE를 뱉어라
# any_of() 하나라도 있으면 TRUE를 뱉어라

## 4.
# TIME이 포함된 변수를 추출하는 기능


### 3.5.2
## 1.
flights_times <- mutate(flights,
                        dep_time_mins = (dep_time %/% 100 * 60 + dep_time %% 100) %% 1440,
                        sched_dep_time_mins = (sched_dep_time %/% 100 * 60 +
                                                 sched_dep_time %% 100) %% 1440)

## 2.
flights %>% 
  mutate(ar1 = arr_time - dep_time) %>% 
  select(air_time, ar1)

## 3.
dd1 <- flights %>% 
  mutate(b1 = dep_time - sched_dep_time)

## 4.

## 5.
# 1:3 + 1:10은 배수차이가 안 되기 때문에 값이 안 나온다. (1:3 + 1:12는 가능)

## 6.


### 3.6.7
## 1.

## 2.
flights %>%
  group_by(dest) %>%
  summarise(n = n())

## 3.
# 가장 중요한 열은 도착 지연 시간(dep_delay)이다. 왜냐하면 출발을 해야 도착하기 때문이다.

## 4.
cancelled_per_day <- flights %>%
  mutate(cancelled = (is.na(arr_delay) | is.na(dep_delay))) %>%
  group_by(year, month, day) %>%
  summarise(cancelled_num = sum(cancelled),
            flights_num = n())

ggplot(cancelled_per_day) +
  geom_point(aes(x = flights_num, y = cancelled_num)) 