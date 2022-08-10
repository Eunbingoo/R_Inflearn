#[R 기초 다지기: 11) 그래프 시각화]

#기본 plot
#- R의 기본 그래프이며 투박한 산출물이 특징
#- plot() 함수를 사용하며 별도 설정을 위해서는 par() 함수 사용
#- 그래프 종류 지정을 위해 type 인자를 사용

#ex)
plot(1:10)

set.seed(123)
num = sample(1:10, size = 10)
num

plot(num)
plot(num, type = "l")
plot(num, type = "b")
plot(num, type = "b", col = "blue")

df = iris
plot(df$Sepal.Length, df$Sepal.Width)
hist(df$Sepal.Length)

#ggplot2 패키지
#- 쉽고 직관적인 문법
#- 통계적 관점에서 제작된 패키지
#- 그래프 중첩 및 각종 서식 지정 편리

install.packages("ggplot2")
library("ggplot2")

df = data.frame(xx = 1:10,
                yy = c(1:4, 5:3, 6:8))
df

ggplot(data = df, aes(x = xx, y = yy)) + geom_point()
ggplot(df, aes(xx, yy)) + geom_point()
ggplot() + geom_point(data = df, aes(x = xx, y = yy))
ggplot() + geom_point(data = df, aes(xx, yy))

ggplot() + geom_point(df, aes(xx, yy))
# error, 인자 순서 바뀜
ggplot() + geom_point(mapping = aes(xx, yy),
                      data = df)

# 기본 그래프
# ggplot(df, aes(xx, yy)) + geom_point()
# ggplot(df, aes(xx, yy)) + geom_col()
# ggplot(df, aes(xx, yy)) + geom_line()

### Quiz 1 ###

aws = read.csv("AWS_sample.txt", sep = "#")
head(aws, 2)

plot(aws[1:200, "TA"])
plot(aws[1:200, "TA"], type = "l")

df_sub = aws[1:200, ]
plot(df_sub$TA, type = "l")


### Quiz 2 ###

library("ggplot2")
ggplot(df_sub, aes(x = 1:200, y = TA)) + geom_line()

# 정답
ggplot(data = aws[1:200, ],
       aes(x = 1:200,
           y = TA)) +
  geom_line()
