#[R 기초 다지기: 8) 제어문_반복문과 조건문]

# 반복문
#- 코드의 중복이 많을 경우 특정 값만 바꿔서 실행하고자 할 때 사용
#- for() 함수 사용, 반복문에 사용되는 코드는 중괄호{} 사이에 선언
#- for( # 객체 in # 1차원 벡터 ){ # 실행코드 }

# ex)
for(n in c(1, 3, 5)){
  print(n)
}
##for() 사용시 print()를 사용해야 출력이 됨
for(n in c(1, 3, 5)){
  print(paste0("n: ", n))
}

for(obs in 8:12){
  print(paste0("sample_",
               sprintf(fmt = "%02d", obs),
               ".csv"))
}

df = data.frame(aa = 1:3,
                bb = 11:13)
for(row in 1:nrow(df)){
  df[row, "cc"] = df[row, "aa"] + df[row, "bb"]
}
df

Sys.sleep(2)  # 2초간 멈춤

# 조건문
#- 지정한 조건을 기반으로 두 가지 이상 코드 실행 및 산술값 계산
#- if() 사용하여 함수 내에 TRUE/FALSE로 반환되는 조건 기입
#- if() 직후 중괄호{}에 TRUE일 경우 실행되는 코드 작성
#- else 구문은 필수 X
if(#조건){
  #TRUE일 경우 실행할 코드
} else{
  #FALSE일 경우 실행할 코드
}
