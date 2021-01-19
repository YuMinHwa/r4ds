library(tidyverse)
install.packages(c("nycflights13","Lahman", "gapminder"))

data(mpg)
mpg

#산점도 그리기(기본형)
ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = displ,
                y = hwy,
                color = class)) +
  geom_point()

# 외에도 size 크기, alpha 음영, shape 모양, color 색깔이 있음

#화면분할
ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point() +
  facet_wrap(~class)

ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point() +
  facet_wrap(~class,
             ncol = 2) # 두 개의 열으로 보여라

ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point() +
  facet_wrap(~class,
             nrow = 2) # 두 개의 행으로 보여라

ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl) # 내가 보고 싶은 변수를 기준으로 화면분할하기

#추세선 그리기
ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point() +
  geom_smooth()

#회귀선으로 바꾸기
ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point() +
  geom_smooth(method = "lm")

#점을 class별로 나누고 회귀선 그리기
ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point(aes(color = class))+
  geom_smooth(method = "lm")

#diamonds
data(diamonds)
diamonds

#갯수 세는 거 
ggplot(diamonds, aes(x = cut)) +
  geom_bar()

#백분율로 알아보는 법
ggplot(diamonds, aes(x = cut, 
                     y = stat(prop),
                     group = 1)) +
  geom_bar()

ggplot(diamonds, aes(x = cut, 
                     y = stat(prop))) +
  geom_bar()

#백분율로 그래프를 그려서 볼 수 있다 (전체관점에서 보기 힘듬(단점))
ggplot(diamonds, aes(x = cut)) +
  geom_bar(aes(fill = clarity),
           position = "fill")

#상대적인 것과 절대적인 것 두 개 다 볼 수 있음
ggplot(diamonds, aes(x = cut)) +
  geom_bar(aes(fill = clarity),
           position = "dodge")

#지도 그리는 방법
install.packages("maps")

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") 

#가로세로 비율 지도에 맞게 설정된다
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()


#자율뮨제

#1.2.4
#1. ggplot(data = mpg)를 실행하라 무엇이 나타나는가?
ggplot(data = mpg) #흰 바탕
#2.mpg는 행이 몇 개인가 열은 몇 개인가?
#11개의 행 234개의 열
#3. drv 변수는 무엇을 나타내는가?
#구동방식
#4. hwy 대 cyl의 산점도를 만들어라.
ggplot(mpg, aes(x = hwy,
                y = cyl)) +
  geom_point()
#5. class 대 drv 산점도를 만들면 어떻게 되는가 이 플롯이 유용하지 않은 이유는?
ggplot(mpg, aes(x = class,
                y = drv)) + 
  geom_point()
#두 변수 사이 상관관계가 없다.

#1.3.1 다음의 코드는 무엇이 문제인가 점들이 왜 파란색이 아닌가?(답)
#1.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ,
                           y = hwy),
                           color = "blue")
#2.
# 범주형 변수:class, manufacturer, model, trans, drv,fl
# 연속형 변수: displ, year, cyl, cty, hwy 
#3.
ggplot(mpg, aes(x = displ,
                y = hwy,
                color = cty)) +
  geom_point()

ggplot(mpg, aes(x = displ,
                y = hwy,
                size = cty)) +
  geom_point()

ggplot(mpg, aes(x = displ,
                y = hwy,
                shape = cty)) +
  geom_point()
#shape은 오류가 뜬다
#4.
ggplot(mpg, aes(x = displ,
                y = hwy,
                color = cty,
                size = cty)) +
  geom_point()
#5.
ggplot(mpg, aes(x = displ,
                y = hwy,
                color = cty,
                stroke = 0.3)) +
         geom_point()
# 점의 크기를 조절해준다.
#6.
ggplot(mpg, aes(x = displ,
                y = hwy,
                color = displ < 5)) +
  geom_point()
# TRUE와FALSE로 나온다.

#1.5.1
#1.
ggplot(mpg, aes(x = displ,
                y = hwy)) +
  geom_point() +
  facet_wrap(~cty)

#2.
#조건에 해당하는 것이 없기 때문이다.
#3. 
#.의 역학은 열이나 행으로 면분할을 하고 싶지 않을 때 변수 이름 대신 .을 이용한다.
#4.
#장점: 설정한 변수를 한눈에 보기 쉽다
#단점: 데이터가 클수록 난잡해진다, 구별하기 쉽지 않다.
#5.
#nrow는 면분할을 할 때 열을 기준으로 보이는 것이고 ncol은 행을 기준으로 보여지는 것이다. facet_grid()에 nrow,ncol 인수가 없는 이유는 내가 보고 싶은 변수를 기준으로 화면분할하기 때문이다. 
#6. gird가 두 변수를 이용해 면분할로 비교하기 때문에 고유수준이 더 많은 변수를 열로 둔다.

#1.6.1
#1. 
#선그래프 geom_line(), geom_boxplot(),geom_area()
#2.
#추세선이 여러 개 나올 것 같다
ggplot(mpg, aes(x = displ,
                y = hwy,
                color = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)
#3.
#범례(속성)를 사라지게 해준다.
#4.
#se는 표준오차를 출력하게 하지 않게 해주는 역할을 한다.
#5.
ggplot(mpg, mapping = aes(x = displ,
                          y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#1번은 공통적으로 필요한 부분을 ggplot에 다 넣었고 2번은 공통적인 부분에 넣지 않았기 때문에 하나하나 설정을 해줘야한다.

#1.7.1
#1.
#연관된 지옴은 geom_bar, geom_point이다. (다음은 모르겠어요... [스탯함수 대신 이 지옴 함수를 사용하여 어떻게 이전 츨롯을 다시 생성하겠는가?])
#2.
#geom_col의 역할은 x, y 두 개를 모두 설정하기 때문에 요약표를 만들 때 사용된다. geom_bar는 변수를 x 한 개만 설정해 빈도 수로 y가 자동 축적된다.
#3.
?stat_bin
#mapping, data, position, ..., na.rm, show.legend, inherit.aes, binwidth, bins, bins, geom, stat, center, boundary, breaks, closed, pad
#4.
#y 변수를 계산한다.
#5.
#group=1을 하지 않으면 각 변수의 백분율이 되기 때문에 다 100이 된다. group=1을 하면 x 전체에 대한 백분율이기 때문에 group=1을 쓴다.