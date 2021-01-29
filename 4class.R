library(tidyverse)

iris

str(iris)
#데이터 프레임 변수 안에 적용
as.character()
as.numeric()

#변수를 숫자열에서 문자열로 바꾸는 방법
iris %>% 
  mutate(Sepal.Length = as.character(Sepal.Length)) %>% 
  str

as_tibble(iris)
#있는 데이터셋을 tibble로 바꿔준다
#tibble()은 그냥 만드는 것


data.frame(x = 1:5,
           y = 1,
           z = x^2 + y)

# 바로 변수를 만들 수 있다
tibble(x = 1:5,
       y = 1,
       z = x^2 + y) 

# 데이터 살리는 방법
data.frame(x = 1:5,
           y = 1)

df$z = df$x^2 + df$y

# 티블은 공백과 스마일이 되지만 데이터 프레임은 안 됨
tb <- tibble(
  `:)` = "smaile",
  ` ` = "space",
  `2000` = "number"
)

tb
# x표시가 나옴
data.frame(
  `:)` = "smaile",
  ` ` = "space",
  `2000` = "number"
)

tribble(
  ~x, ~y, ~z,
  "a", 2, 3.6,
  "b", 1, 8.5
)

# 이렇게 하면 티블로 바뀐다
iris %>% 
  mutate(seq = 1:nrow(iris)) %>% 
  as_tibble()

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE))
  
library(nycflights13)

flights %>% 
  print(n = 15, width = Inf)

# 연습 10.1
as.tibble(mtcars)

# 연습 10.2
df <- data.frame(abc = 1, xyz = "a")

df$x

df2 <- data.frame(abc = 1, xyz = "a", xxx = "b")
# x가 두개 이상이면 못 찾음 축약적으로 찾을 수 있는 기능
df2$x

df2$xy

# 값만 나온다
# 변수의 값만 나온다
flights %>% 
  .$year

flights %>% 
  .[["year"]]

#변수의 이름도 같이 나온다

flights %>% 
  .[["year"]]

flights %>% 
  select(year)

#연습 10.3
# mpg 변수 값만 뽑아낼 수 있다.
mtcats <- as_tibble(mtcars)
mtcars

var <- "mpg"
mtcars[var]

vars <- c("mpg", "cyl")
# 두 변수도 가능
mtcars[vars]

mtcars[1:5, vars]

# 연습 10.4
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
#'r'norm은 랜덤이라는 뜻

# 이렇게 두 개 같은 거
annoying[1]
annoying %>% 
  select(`1`)

# 이렇게 두 개 같은 거
annoying$`1`
annoying[[1]]

# 산점도 그리기
ggplot(annoying, aes(x = `1`, y = `2`)) +
  geom_point()

# 새로운 변수 만들 때
annoying2<- annoying %>% 
  mutate(`3` = `2` / `1`)

# 이름을 바꿀 때
annoying3 <- rename(annoying2, one = `1`, two = `2`, three = `3`)

# 연습 10.5
?enframe
enframe(1:3)
enframe(c(a = 5, b = 7))

deframe(tibble(a = 1:3))
deframe(tibble(a = as.list(1:3)))

read_csv("a,b,c
         1,2,3
         4,5,6")

read_csv("The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3", skip = 2)
# skip은 두 줄 생략

read_csv("# A comment I want to skip
  x,y,z
  1,2,3", comment = "#")
# 코멘트를 없애고 싶을 때

# 잘 안 들어감
read_csv("1,2,3,\n4,5,6")

# \n은 새 행을 추가할 때 쓰는 거
read_csv("1,2,3\n4,5,6",
         col_names = FALSE)

read_csv("1,2,3\n4,5,6",
         col_names = c("x", "y", "z"))

# 결측 처리
read_csv("a,b,c\n1,2.", na = ".")
# .으로 된 건 결측 처리를 해라

# 연습 11.2.1
read_delim("a,b,c\n1,2.", delim = "|",
           na = ".")

# 연습 11.2.5
read_csv("a,b\n1,2,3\n4,5,6")
#백슬레쉬 하나 더 있음
read_csv("a,b\n\"1")
read_csv("a,b\n1,2\na,b")
read_csv("a;b\n1;3")
read_csv2("a;b\n1;3")
read_delim("a;b\n1;3", delim = ";")

# 연습 11.3
# parse = as
str(as.logical(c("TRUE", "FALSE", "NA")))
str(parse_logical(c("TRUE", "FALSE", "NA")))
str(as.integer(c("1","2","3")))
str(parse_logical(c("1","2","3")))

as.Date(c("2010-01-01", "1979-10-14"), format = "%Y-%m-%d")

str(parse_date(c("2010-01-01", "1979-10-14")))

tb2 <- tibble(logi = c("TRUE", "FALSE", "NA"),
              inte = c("1","2","3"),
              datk = c("2010-01-01", "1979-10-14", "2021-01-29"))

# 숫자열이나 달으로 바꿀 때
tb2 %>% 
  mutate(logi = parse_logical(logi),
         inte = parse_integer(inte),
         datk = parse_date(datk))

tb2 %>% 
  mutate(logi = as.logical(logi),
         inte = as.integer(inte),
         datk = as.Date(datk))


# 연습 11.3.1
#date_names, date_format, time_format, tz, decimal_mark, grouping_mark, encoding

# 연습 11.3.2
locale(decimal_mark = ".", grouping_mark = ".")
locale(decimal_mark = ",")
locale(grouping_mark = ".")

locale()
parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))

parse_date("14 oct. 1979", "%d %b %Y", locale = locale("fr"))

locale_custom <- locale(date_format = "Day %d Mon %M Year %y",
                        time_format = "Sec %S Min %M Hour %H")

date_custom <- c("Day 01 Mon 02 Year 03", "Day 03 Mon 01 Year 01")

parse_date(date_custom)

parse_date(date_custom, locale = locale_custom)

time_custom <- c("Sec 01 Min 02 Hour 03", "Sec 03 Min 02 Hour 01")

parse_time(time_custom)

parse_time(time_custom, locale = locale_custom)

# 연습 11.3.4
parse_date("02/01/2006")
au_locale <- locale(date_format = "%d/%m/%Y")
parse_date("02/01/2006", locale = au_locale)

# 연습 11.3.5
#read_csv는 쉼표를 사용하고 read_csv2()는 ;를 사용한다.

#연습 11.3.7
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14"
t1 <- "1705"
t2 <- "11:15:10.12 PM"

parse_date(d1, "%B %d, %Y")
parse_date(d2, "%Y-%b-%d")
parse_date(d3, "%d-%b-%Y")
parse_date(d4, "%B %d (%Y)")
parse_date(d5, "%m/%d/%y")
parse_time(t1, "%H%M")
parse_time(t2, "%H:%M:%OS %p")
