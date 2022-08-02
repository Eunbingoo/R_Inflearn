#[R 기초 다지기: 7) 산술 함수와 문자열 함수]

# 산술 함수 개요
#- 대부분의 함수는 특별한 인자가 없으며, 결측값 제외를 위해 na.rm 인자를 활용하기도 함

# ex)
aa = c(1, 2, NA, 5)
mean(aa)  # NA값 때문에 평균값 계산X
mean(aa, na.rm = TRUE)  # 결측값을 지운 뒤 계산!

# 산술 함수 예시
# sum(), mean(), max(), min(), median(), cumsum() 누적합
# abs() 절대값, log() 로그연산, exp() 오일러 수(e)를 밑으로 하는 지수 연산
# sqrt() 제곱근, sin() 삼각함수의 sin 함수, factorial() 계승, 차례곱, !
# quantile() 분위수, round() 반올림, floor() 내림, ceiling() 올림
# sd() 표준 편차, var() 분산

nums = c(2, 5, 7, 9, 20)
cumsum(nums)  # 누적합 계산

nums2 = c(-2, 4, 6)
abs(nums2)  # 절대값 추출
log(nums2)  # 로그로 연산
log(nums2, base = 2)   # 2를 밑으로 하는 로그로 연산

sqrt(4) #제곱근 추출
sqrt(100)

quantile(df$pregnancies)  # 분위수 추출, 0%, 25%, 50% ...
quantile(df$pregnancies, probs = 0.99) # probs 인자 = 99 백분위수 출력

df[ , "BMI_round"] = round(df$BMI)  # 새로운 변수 생성하여 열 추가

bike = read.csv("bike.csv")
head(bike, 2)
mean(bike$temp)
mean(bike[ , "temp"])

aws = read.csv("AWS_txt", sep = "#")
head(aws, 2)
min(aws$Wind)
median(aws$TA)  # 중앙값 추출

# 문자열 함수
# nchar() 문자열 개수 확인, print() 결과 출력, sprintf() 특정 형식을 지정하여 출력
# grep() 특정 패턴 문자열 위치 확인 및 값 필터링
# grepl() 특정 패턴 만족 여부 TRUE/FALSE
# gsub() 특정 패턴을 원하는 글자로 치환

# ex)
df = iris
head(df, 2)
colnames(df)  # 변수 항목 확인
unique(df$Species) # 중복 인자 제거 후 확인
# *문자형 벡터가 필요할 때, as.character() 함수 사용
7 : 11
sprintf(fmt = "%02d", 7:11)  # 두 자리 정수 포맷으로 출력
df_text = data.frame(obs = 1:3,
                     text = c("aaa", "abc", "bbb"))
grep(pattern = "c", df_text$text) # c가 들어있는 원소 출력
df_text[grep(pattern = "c", df_text$text), ] # 해당 원소가 포함된 row 출력
grepl(pattern = "c", df_text$text) # c 포함 유무 확인
sum(grepl(pattern = "c", df_text$text)) # c가 포함된 원소의 개수 출력

gsub(pattern = "abc",
     replacement = "@",
     x = "abc_kk")  # "@_kk" 추출
# 만약 없애고 싶을 경우, replacement = "" 로 설정

# paste() 문자열에 특정 문자를 끼워 붙이는 함수
# paste0() 문자열을 간격 없이 붙이는 함수
# substr() 문자열 일부 뗴오기 -> left, right 같은 함수
# strsplit() 특정 문자열을 기준으로 쪼개기

# ex)
paste("aa", "bb")  # 기본 sep = 띄어쓰기
paste("aa", "bb", sep = "-")
paste(c("aa", "bb"), collapse = "-") # c함수로 가져올 땐 collapse 인자 사용
paste(df$Length[1:3], df$Width[1:3],
      sep = "@@")
paste0("sample_", 1:3, ".csv")
paste0("sample_",
       sprintf(fmt = "%02d", 8:12),
       ".csv")
file.names = paste0("sample_",
                    sprintf(fmt = "%02d", 8:12),
                    ".csv")
substr(x = file_names,
       start = 1, stop = 6)
substr(x = file_names,
       start = 8, stop = 9)
as.numeric() # 사용하여 숫자화 가능

strsplit(file_names, split = "_")  # 특정 문자 구분으로 나누어 출력