#[R 기초 다지기: 10) 데이터 병합]

#Binding
#- 데이터를 이어붙이는 작업

#ex)
df1 = data.frame(aa = c(1, 2),
                 bb = c("a", "b"))
df1 = data.frame(aa = 1:2,
                 bb = c("a", "b"))
df2 = data.frame(aa = 1:2,
                 bb = c("c", "d"))
df1
df2

rbind(df1, df2)   #row 방향 이어붙이기
cbind(df1, df2)   #column 방향 이어붙이기

rbind(df2, df1)
cbind(df2, df1)

df1[, "cc"] = "kk"
df1

rbind(df1, df2)
# column 수가 맞지 않아서 붙여지지 않음

rbind(df1[, -3], df2)
rbind(df1[, -1], df2)
# 열 이름이 df2와 달라서 붙여지지 않음

df1_sub = df1[, -1]
df1_sub
colnames(df1_sub) = c("aa", "bb")
df1_sub

rbind(df1_sub, df2)
# 연결 하려는 대상의 column 개수, 이름이 같아야 함

cbind(df1, df2)
# cbind는 column 개수 상관X
cbind(df1, rbind(df2, df2))
# 나오는 이유는 벡터 리사이클링 때문
cbind(df1, rbind(df2,df2)[-1, ])


bike = read.csv("bike.csv")
head(bike, 2)

bike_agg_c = aggregate(data = bike,
                       casual ~ season,
                       FUN = "mean")

bike_agg_r = aggregate(data = bike,
                       registered ~ season,
                       FUN = "mean")

bike_agg_c
bike_agg_r
cbind(bike_agg_c, bike_agg_r)

#Join
#- 특정 변수를 기준으로 두 데이터를 엮는 것

#ex)
library("dplyr")
inner_join(x = bike_agg_c, y = bike_agg_r,
           by = c("season" = "season"))
left_join(x = bike_agg_c, y = bike_agg_r,
           by = c("season" = "season"))

bike_c = bike_agg_c[-1, ]
bike_r = bike_agg_r[-3, ]
bike_c
bike_r

inner_join(x = bike_c, y = bike_r,
           by = c("season" = "season"))
# 공통인 season 2, 4 만 출력

left_join(x = bike_c, y = bike_r,
          by = c("season" = "season"))
# season 3이 없으니까 결측값 처리

### QUIZ 1 ###

diam = read.csv("diamonds.csv")
head(diam, 2)
nrow(diam)

dia_E = diam[diam$color == "E", ]
dia_H = diam[diam$color == "H", ]
head(dia_E)
nrow(dia_E)

rbind(dia_E, dia_H)

### QUIZ 2 ###

bike = read.csv("bike.csv")
head(bike, 2)
nrow(bike)

library("lubridate")
bike[ , "hour"] = hour(bike$datetime)
bike_agg_c = aggregate(data = bike, casual ~ hour, FUN = "mean")
bike_agg_r = aggregate(data = bike, registered ~ hour, FUN = "mean")

bike_agg_c
bike_agg_r

library("dplyr")
inner_join(x = bike_agg_c, y = bike_agg_r,
           by = c("hour" = "hour"))