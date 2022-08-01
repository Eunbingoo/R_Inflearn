# [R 기초 다지기: 6) 데이터 입출력]

# 작업폴더
#- 작업폴더(working directory)를 기준으로 파일 입출력
#- Windows의 경우, Document(문서) 폴더가 기본 작업폴더
#- 현재 작업폴더 확인 = getwd() 함수 사용
#- 작업폴더 변경 = setwd() 함수 사용

setwd("..")  #상위 폴더로 이동

# 작업 파일 및 폴더 목록 확인
#- 작업 폴더를 기준으로 파일/폴더 목록 확인 가능
#- list.files() / dir() 함수로 파일 목록 확인
#- list.dirs()
#- recurisve 인자는 폴더의 하위 폴더까지 탐색하여 결과 출력
list.files(pattern = "csv")  # csv 포함 파일만 확인 가능

# 텍스트 파일 입력(load, read)
#- 메모장 프로그램으로 열 수 있는 파일 = txt
#- 특정 폴더에서 R로 불러오기 -> 대표적 확장자 csv, tsv, txt
#- read.csv() = 텍스트 파일 읽어올 때 사용

# ex)
df_aws = read.csv("AWS_sample.txt", sep = "#")  # 해당 파일은 #으로 구분되어 있음
head(df_aws) # 상단 6개 row 출력
head(df_aws, 2)  # 상단 2개 row 출력
tail(df_aws) # 하단 6개 row 출력

df_bike = read.csv("bike.csv")
head(df_bike)

# readr 패키지의 read_csv() 함수
install.packages("readr")
library(readr)
df_bike_2 = read_csv("bike.csv")
head(df_bike_2)  # 출력시, df보다 upgrade ver.인 tibble 출력

df_b = as.data.frame(df_bike_2)
head(df_b)
class(df_b)

# data.table 패키지의 fread() 함수
install.packages("data.table")
library(data.table)
df_bike_3 = fread("bike.csv")
head(df_bike_3)  # 출력시, data.table로 출력

df_b3 = as.data.frame(df_bike_3)
head(df_b3, 2)
fread("bike.csv", data.table = FALSE, nrows = 2) # 이렇게 설정시 data.frame으로 두줄만 출력

# readxl 패키지의 read_excel() 함수
install.packages("readxl")
read_excel(sheet = 3)  # 엑셀 파일의 해당 시트 데이터 읽어오기

# 파일 출력(save, write)
#- 특정 객체의 데이터를 R을 사용해 저장하는 행위
#- 파일 형식에 따라 다양한 함수를 사용하여 저장
#- 파일 저장 시, 파일 확장자는 사용자가 직접 지정 ex) .txt/ .csv
#- 인코딩 설정이 필요한 경우, 함수 사용이 제한적!
#- 텍스트 구분자가 쉼표가 아닌 경우, sep 인자에 구분자 할당
#- 보통 row.names = FALSE 로 지정

df_sample = data.frame(aa = 1:3,
                       bb = 4:6)
write.csv(df_sample, "write_csv_sample_01.csv")  # 출력 시, 해당 이름으로 작업 폴더에 저장!
write.csv(df_sample, "write_csv_sample_02.csv",
          row.names = FALSE)  # Why? row는 변수로 설정하는 경우가 적어서

# readr 패키지 = write_csv() 함수
# data.table 패키지 = fwrite() 함수
# readxl 패키지 = write_xlsx() 함수

# 인코딩
#- 인코딩 설정이 잘못되는 경우, 한글 표기가 깨지거나 글자가 제대로 조합되지 않음
#- 파일을 읽거나 쓸 때 지정할 인코딩을 fileEncoding, encoding 인자로 지정
#- Encoding() 함수로 자료 인코딩 변경 가능

# 운영체제별 인코딩
#- Mac OS / Linux => UTF-8
#- Windows => CP949 = Euc-kr

# 스크립트 파일 인코딩 문제 해결
#- 스크립트 파일이 깨져보일 시, 인코딩 문제일 수 있음!
#- File - Reopen with Encoding에서 해결 가능 <UTF-8 / CP949>
#- 한 파일에 두 개 이상의 인코딩이 혼재될 경우, 복구 불가능..

# 인코딩 지정 후 저장
write.csv(df, "파일명.csv", rownames = FALSE,
          fileEncoding = "euc-kr")

# 데이터 세트 문제 해결
read.csv("encoding파일.csv")
readLines("encoding파일.csv", encoding = "UTF-8") # 데이터를 한줄한줄 불러옴
fread("encoding파일.csv", encoding = "UTF-8")
df = fread("encoding파일.csv")
df = as.data.frame(df)
Encoding(df$cc) = "UTF-8"