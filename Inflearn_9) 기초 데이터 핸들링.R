#[R 기초 다지기: 9) 기초 데이터 핸들링]

#1차원 벡터
#- 대괄호 내부에 인덱스 번호/논리값/연산자 기반의 조건을 부여하여 필터링
#- 연산자는 비교연산자를 사용하며, 다대다 매칭시 %in% 연산자를 사용하기도 함

#ex)
aa = c(2, 4, 6, 8)
aa

aa[c(2, 4)]
aa[c(1, 3)]
aa[1:3]
aa[seq(1, 4, 2)]

aa[aa == 4]
aa[aa != 4]
aa[c(TRUE, FALSE, TRUE, FALSE)]
aa[aa > 7]

#메트릭스
#- 구조가 2차원인 경우도 1차원 벡터처럼 필터링 가능

#ex)
mat = matrix(LETTERS[1:4], nrow = 2)
mat[c(1, 3)]
mat[c(TRUE, FALSE, TRUE, FALSE)]
mat[mat %in% c("A", "C")]

#데이터 프레임
#- 일반적으로 행(row) 기준으로 필터링 실시
#- 대괄호 내부에 필터링 조건 입력
#- 두 개 이상의 조건을 부여할 수 있으며, & 또는 | 기호 사용
#- 함수 사용시, subset() 또는 filter() 함수 사용
#**행 기준 필터링이므로, [조건, ] => 콤마 앞에 조건을 써줌

#ex)
# df[ row , column ] - 2차원 객체
df = data.frame(aa = 1:3,
                bb = c("a", "b", "c"))
df
df[c(1, 3), ]
df[c(TRUE, FALSE, TRUE), ]
df[df$aa != 2, ]

# 1. A조건 또는 B조건을 만족하는 경우
# df[ (A) | (B), ]

# 2. A조건과 B조건을 동시에 만족하는 경우
# df[ (A) & (B) , ]

df[(df$aa == 3) | (df$bb == "b"), ]
df[(df$aa == 1) & (df$bb == "a"), ]

subset(df, aa == 3)
install.packages("dplyr")
library(dplyr)
dplyr::filter(df, aa == 3)

#데이터 프레임의 신규 변수 생성
#- 대괄호 및 $ 기호를 사용하여 신규 변수 생성
#- 함수 사용 시, dplyr 의 mutate() 함수 사용
#- 일반적으로 기존 변수를 특정 규칙을 기반으로 신규 변수 생성

#ex)
df = data.frame(aa = 1:3,
                bb = 3:5) 
df
df[, "new_col"] = df$aa * df$bb
df[, "new_col"] = df[, "aa"] * df[, "bb"]
df[, "new_col"] = df[, 1] * df[, 2]
df

df[, "var2"] = 100
df

df[, "new_col"] = 999  #기존 new_col 리셋
df

df[, 5] = 555  #변수명이 숫자로 시작하는 것 방지 => 자동으로 v5 셋팅
df

colnames(df)[5] = "var5"
df

#시간 데이터 핸들링

#ex)
as.POSIXct("2077-12-31")  #문자열을 시간 데이터 형식으로 변환
as.POSIXct("2077-12-31 23:59:59")
as.Date("2077-12-31")  #문자열을 날짜 데이터 형식으로 변환

vec_date = as.Date("2077-12-31")
class(vec_date)   #형태 Date
class("2077-12-31")   #형태 character

as.Date(50000)  #origin 기입 필수
as.Date(50000, origin = "1900-01-01")
# 1900-01-01 부터 50000일 지난 일자 추출

df_date = data.frame(obs = 1:4,
                     passed = 4:7)
df_date
df_date[, "passed_date"] = as.Date(df_date$passed,
                                   origin = "2030-01-01")
df_date

months("2030-01-01")  #시간 데이터로 바꿔준 다음 추출해야 함
months(as.POSIXct("2030-01-01"))  #시간 데이터에서 월 정보 추출
months(as.POSIXct("2030-01-01"),
       abbreviate = TRUE)
# abbreviate - 약자 추출

as.numeric(months(as.POSIXct("2030-01-01"),
                  abbreviate = TRUE))

weekdays("2030-01-01")  #일 정보 추출하려면 시간 데이터로 변환 후 추출 가능
weekdays(as.POSIXct("2030-01-01"))  #시간 데이터에서 일 정보 추출
class(weekdays(as.POSIXct("2030-01-01")))

df_date
class(df_date$passed_date)
df_date[, "wday"] = weekdays(df_date$passed_date)
df_date

#시간 데이터 현들링 - lubridate 패키지 함수
# install.packages("lubridate")
library(lubridate)
ymd(20300101)  #년/월/일 입력 데이터를 시간 데이터로 변환
ymd("20300101")
ymd("2030/1/1")

ymd_h("20300101 13") #년/월/일/시 데이터 -> 시간 데이터로 변환
ymd_h("2030/01/01 13")
strptime("2030-01-01 13", format = "%Y-%m-%d %H")
strptime("2030년 1월 1일", format = "%Y년 %m월 %d일")
ymd("2030년 1월 1일")

date_01 = ymd("2030년 1월 1일")
date_01

year(date_01)  #년도 추출
month(date_01)  #월 추출
day(date_01)  #요일 추출

wday(date_01)  #요일 추출
wday(date_01, week_start = 1)  #월요일을 시작점으로 둠
wday(date_01, label = TRUE)  #월화수.. 형식으로 추출
wday(date_01, label = TRUE, week_start = 1)
#*데이터 핸들링 할 때 숫자가 더 편함

hour("2030-01-01 15") #시간 추출
hour(ymd_h("2030-01-01 15"))

#정렬/정렬 방법/정렬의 활용
#- 오름차순/내림차순

#ex)
order()  #오름차순/내림차순 정렬
arrange()  #오름차순/내림차순 정렬

df_date
df_date[order(df_date$passed), ]
df_date[order(df_date$passed, decreasing = TRUE), ]
df_date[order(df_date$wday), ]

df_date = df_date[order(df_date$passed, decreasing = TRUE), ]
df_date

df_date[order(df_date$wday, df_date$obs), ]

#요약 계산
#- 특정 변수를 기준으로 요약연산 가능
#- 함수를 사용하는 경우 FUN 인자에 연산 함수 할당
#- FUN 인자가 적용되는 대상 변수는 formula 부분의 물결표시 앞에 지정
#- 물결 뒤 변수는 그룹연산 기준 순서대로 지정, + 사용하여 연결

df = iris
df
head(df, 2)

aggregate(data = df, Sepal.Length ~ Species,
          FUN = "mean")
mean(df$Sepal.Length)

bike = read.csv("bike.csv")
head(bike, 2)

aggregate(data = bike, temp ~ season + weather,
          FUN = "mean")

#일괄 계산 apply() 함수
#- for() 반복문을 대체 할 수 있는 대표적인 함수
#- apply() 뿐만 아니라 lapply(), sapply() 등 존재
#- apply() 의 첫 번째 인자는 대문자 X
#- apply() 의 FUN 인자에 연산 대상이 되는 함수를 할당

#ex)
df = iris
head(df, 2)

apply(X = df, MARGIN = 2, FUN = "max")
# apply(X = df, MARGIN = 2, FUN = "mean")
# Species가 문자여서 평균 낼 수 없음
apply(X = df[, -5], MARGIN = 2, FUN = "mean")
# Species 열(5) 제외 하고 평균

apply(X = df[, -5], MARGIN = 1, FUN = "mean")
nrow(df)

df[, "mean"] = apply(X = df[, -5], 1, FUN = "mean")
head(df, 2)

#일괄 계산 ifelse() 함수
#- for() 반복문과 if() 함수를 동시에 사용하는 코드 대체
#- test에 입력된 조건의 결과가 TRUE일 경우, yes 인자에 할당된 값이 출력

#ex)
ifelse(test = 1:4 > 2,
       yes = "!!",
       no = "??")

for (n in 1:4) {
  if(n > 2){
    print("!!")
  } else {
    print("??")
  }
}

df = iris
head(df, 2)

df[, "is_setosa"] = ifelse(df$Species == "setosa",
                           1, 0)
df

table(df$Species, df$is_setosa)

bike = read.csv("bike.csv")
head(bike, 2)
ifelse(bike$humidity == 100,
       1, 0)
bike[, "snow"] = ifelse(bike$humidity == 100, 1, 0)

table(bike$datetime, bike$snow)

### QUIZ 1 ###

bike[, "date"] = as.Date(bike$datetime)
head(bike, 2)

bike_agg = aggregate(data = bike,
                     humidity ~ date,
                     FUN = "max")
head(bike_agg)

ifelse(bike_agg$humidity == 100, 1, 0)
sum(ifelse(bike_agg$humidity == 100, 1, 0))

### QUIZ 2 ###

bike[, "wday"] = wday(bike$datetime, label = TRUE)
bike[, "hour"] = hour(bike$datetime)
head(bike, 2)

bike_agg2 = aggregate(data = bike,
                      count ~ wday + hour,
                      FUN = "mean")
head(bike_agg2, 4)
bike_agg2[bike_agg2$count == max(bike_agg2$count), ]
bike_agg2[which.max(bike_agg2$count), ]  #max값이 어디있는지 찾는 조건

### QUIZ 3 ###

dia = read.csv("diabetes.csv")
head(dia, 2)

dia[(dia$BMI != 0) & (dia$Insulin != 0), ]
dia_BI = dia[(dia$BMI != 0) & (dia$Insulin != 0), ]
head(dia_BI, 2)

aggregate(data = dia_BI, dia_BI ~ BMI + Insulin, FUN = "mean")

# 정답

nrow(dia)

dia_sub = dia[(dia$BMI != 0) & (dia$Insulin != 0), ]
nrow(dia_sub)
apply(X = dia_sub, MARGIN = 2, FUN = "mean")
apply(dia_sub, 2, "mean")
# 모든 변수의 평균값