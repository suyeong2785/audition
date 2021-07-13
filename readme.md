# 할일 리스트

## 할일 리스트

- [o] 회원가입
- [o] 로그인
- [ ] 로그아웃


# my.cnf mysqld 설정

```
[mysqld]
lower_case_table_names = 2 # 테이블 명에 소문자 허용
max_allowed_packet = 50M # # file 테이블에 실제 파일을 저장하려면
```

# my.cnf mysqld 설정
파일업로드시 nginx 에러
(Failed to load resource: the server responded with a status of 413 (Request Entity Too Large))
대처 방법

->
1. putty로 audition@access.bangsuyeong.shop 접속한다.
2. vim /etc/nginx/nginx.conf 입력한다.(root에서만 수정가능)
3. http {
  # Set client upload size - 50Mbyte
  client_max_body_size 50M;
  ...
  ..
  .
}
위 두줄을 맨 위에 추가한다.
(50Mbyte가 아니라 원하는 Mbyte로 수정해서입력)