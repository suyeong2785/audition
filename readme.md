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

※ 개발진행상황 ※

- 2021년
  - 6월
    - 22일
      - 조PD님,이상호이사님,오채영님과 미팅
      - 채영님과 공동위키 제작 및 전반적인 오디션트리 구조설명
      - 비대면 협업계획논의(위키)
      
    - 23일
      - 스프링부트로 오디션트리 새로시작
      - 프로젝트 audition 생성 및 깃허브관리
        - [https://github.com/suyeong2785/audition.git](https://github.com/suyeong2785/audition.git)
      - audition tree [to2.kr/buD](https://to2.kr/buD) 1~7강 완료
      
    - 24일 
      - 오디션트리 8~16강완료
      
    - 25일 
      - 오디션트리 17~22강완료
      
    - 25일 
      - 개인사정 공부x
    
    - 26일 
      - 오디션트리 23강공부
      - 유용한 링크
        - [[HTML] input type='file' 속성 알아보기 ( 파일 입력 )](https://hianna.tistory.com/346)
        - [Spring WebFlux는 무엇인가? 사용법은 어떻게 되나?](https://oingdaddy.tistory.com/119)
        - [Project Reactor 4장: Flux ,Mono](https://brunch.co.kr/@springboot/154)
        - [Spring Webflux 4 (웹플럭스 적용기, Mono와 Flux)](https://lts0606.tistory.com/304)
        - [[Java]자바 스트림Stream(map,filter,sorted / collect,foreach)](https://dpdpwl.tistory.com/81)
        - [Video Stream over HTTP using Spring Boot](https://saravanastar.medium.com/video-streaming-over-http-using-spring-boot-51e9830a3b8)
        - [Class Assert](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/util/Assert.html)
        - [SpringMVC - 핸들러 메소드 - 8 (파일 다운로드 기능 구현, 리턴타입 : ResponseEntity)](https://galid1.tistory.com/565)
       
        
      - 이해하는데 시간이 좀걸림
    
    - 28일
      - 오디션트리 23~26강완료
        - [Guava Cache](https://ijbgo.tistory.com/10)
        
    - 29일
      - 오디션트리 27~34강완료
        - [[Java] HashMap, LinkedHashMap 차이점 및 사용법](https://fruitdev.tistory.com/141)
        - [javascript replaceAll 기능 사용하기](https://louet.tistory.com/151)
        - [＆nbsp; ＆amp; ＆lt; ＆gt; ＆quot;의 의미?](https://ly.lv/65)
        
    - 30일
      - 오디션트리 34 ~ 40강완료
      - 자바웹서비스 배포 페이지(1~11)
        - [Ubuntu 9의 Tomcat 18.04, 설치 및 기본 구성](https://ubunlog.com/ko/tomcat-9-instalacion-ubuntu-18-04/)
       
  - 7월
  
    - 1일
      - 자바웹서비스 배포 페이지(12~22)
      
    - 2일
      - 채영씨와 처음부터 사이트 제작진행
        - db 설계
        - 회원가입페이지 진행
    - 3일
      - 회원가입 jsp 문서에 아이디중복체크 기능구현
      - 카카오 주소 api 사용해서 주소값 받아오능 기능구현
        - [iframe과 통신하기](https://www.zerocho.com/category/HTML&DOM/post/59e73a7669a8ed0019079d44)
        - [3. spring 다음 주소API를 활용하여 우편번호 및 주소 찾기](https://kingchobocoding.tistory.com/9)
        - [[프로젝트] id, email 중복확인 / 회원가입](https://ninearies.tistory.com/90)
    - 4일
      - 프로필 사진 파일 업로드기능 구현
      - 회원가입시 이메일 발송구현
      - 회원가입 페이지 css 추가
      - head.jsp 파일에 titlebar 검색창 웹/앱 구현
    - 5일
      - 슬라이드 메뉴구현
        - [css 모바일 버거 메뉴 버튼 만들기](https://muzi-muzi.tistory.com/7)
        - [[Jquery] 제이쿼리를 이용해 슬라이드 메뉴 만들기](https://brilliantcoding.tistory.com/entry/Jquery-%EC%A0%9C%EC%9D%B4%EC%BF%BC%EB%A6%AC%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%B4-%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C-%EB%A9%94%EB%89%B4-%EB%A7%8C%EB%93%A4%EA%B8%B0)
      - 로딩화면 구현
      - 모바일에서는 사이드바 fixed 해제 및 sticky 적용 
      
    - 6일 
      - 기존 강사님이 해놓으셨던 오디션트리 가져옴(대표님이 요구한 기능까지 만들기에는 시간이 오래걸릴듯함)
     
    - 7일
      - adm에서 마이페이지로 배역지원자들 확인하는 기능추가
      
    - 8일
      - 지원자클릭시 지원자가 첨부한 동영상을 모달로띄우고 닫기 기능구현
      - 삭제버튼 기능구현(지원자 문자 발송에서 웹단으로 결정)
        - [[Spring Boot] 문자인증 구현 coolSMS](https://1-7171771.tistory.com/84)
    - 9일 
      - [자바 리플렉션(Java Reflection)](https://kaspyx.tistory.com/tag/getDeclaredMethod)
      - 강원도 정선 감
      
    - 11~ 12일
      - 강원도 정선
      - 이것저것 일도 돕고하느라 버그 수정만함
      
    - 13일
      - '삭제버튼' '1차불합격'으로 변경 1차합격버튼구현 및 db데이터 업데이트 및 사용자의 마이페이지에서 합격/불합격여부 확인기능 구현
        - [자바 리플렉션(Java Reflection)](https://kaspyx.tistory.com/tag/getDeclaredMethod)
      - 로그인정보를 어떻게 옮겨줄방법을 강구하다가 찾음(적용x)
        - [Spring Security 구현 정리](https://1-7171771.tistory.com/80?category=885255)
      - member테이블에 권한칼럼을 추가해서 관리자/캐스팅디렉터 분리
      - 동영상 재생시간이 1분 30초 이상이 넘어간다면 초기화 후,알림창띄움
         - [HTML 오디오 / 비디오 DOM의 loadedmetadata 이벤트](http://www.w3big.com/ko/tags/av-event-loadedmetadata.html)
         - [Find if 'cancel' was clicked on file input](https://stackoverflow.com/questions/22898854/find-if-cancel-was-clicked-on-file-input)
         - [input[type=file] 업로드 개수 체크 방법](https://amagrammer91.tistory.com/34)
         - [자바스크립트 File 객체](https://taeny.dev/javascript/file-object/)
         - [JavaScript 날짜 형식 지정](https://www.delftstack.com/ko/howto/javascript/javascript-format-date/)
         - [[Javascript] 자바스크립트에서 EL표현법 사용하기](https://yuien.tistory.com/entry/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%97%90%EC%84%9C-EL%ED%91%9C%ED%98%84%EC%8B%9D-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0) 
         - [[Jquery] setTimeout() 사용법](https://heeestorys.tistory.com/745) 
    
    - 14일
      - 관리자 마이페이지에서 지원자영상 반응형적용
      - 서버 파일업로드용량 늘려줌
        - [Nginx 413 Request Entity Too Large 에러 해결하기, 파일 업로드 사이즈](https://webisfree.com/2018-03-29/nginx-413-request-entity-too-large-%EC%97%90%EB%9F%AC-%ED%95%B4%EA%B2%B0%ED%95%98%EA%B8%B0-%ED%8C%8C%EC%9D%BC-%EC%97%85%EB%A1%9C%EB%93%9C-%EC%82%AC%EC%9D%B4%EC%A6%88)
      
    - 15일
      - 대표님이 요청한 동영상 워터마크 방법을 요구함
        -  대표적인 동영상 편집기인 ffmpeg 를 리눅스 서버에 깔고, wrapper을 dependency에 추가해서 자바로 동영상 편집을 해서 저장할수있음.
           - [[ Server ][ Linux ] centos7 FFMpeg 설치방법](https://funyphp.com/archive/linux/6)
        - 하지만 서버에서 처리하다보면 서버에 무리가 갈수있다고함 그래서 이 워터마크 동영상 편집을 할 서버를 따로 하나 놓고 쓰는게 좋다고한다.
           - [[Spring] FFmpeg를 이용한 썸네일 이미지 추출](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=ksw6169&logNo=221546693446)
           - [FFMPEG Wrapper Library 사용법 예제](https://jodu.tistory.com/30)
           - [ffmpeg-cli-wrapper](https://github.com/bramp/ffmpeg-cli-wrapper)
           - [FFmpeg Wrapper 0.6.1 API 사용법](https://bramp.github.io/ffmpeg-cli-wrapper/)
           - [ffmpeg-cli-wrapper(확장판)](http://www.lib4dev.in/info/moliyar/video-composer-java/204647076)
        
        - 주로 외국의 API가 검색됨(아래방식은 일반적인 api방식이아닌 webhook방식이다)
          - [Add watermarks to a video(site : veed.io)](https://documentation.veed.io/reference#status-codes)
          - [웹훅(Webhook)이란?](https://jm4488.tistory.com/57)
          - [[Web]http통신을 이용한 양방향 통신기법, long polling](https://kamang-it.tistory.com/entry/Webhttp%ED%86%B5%EC%8B%A0%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-%EC%96%91%EB%B0%A9%ED%96%A5-%ED%86%B5%EC%8B%A0%EA%B8%B0%EB%B2%95-long-polling)
          
    - 17일
        -  지원자의 파일첨부시점을 로그인시점이랑 비교하는 기능추가, 본인의 게시물일 경우에만 합격/불합격 버튼 보여줌, 이후의 워터마크를 구현하기위한 FFmpegService추가(나중에 워터마크 구현할때 참고하기위한자료)
           
    - 18일
      - 마이페이지 지원자 공유기능 추가,Share controller,service,dao,dto등 추가 DB에 share 테이블 추가
      
    - 20일
      - 지원자 공유제안 섹션만듬,공유된 지원자목록 보여줌, 캐스팅디렉터 검색결과에 이미 공유신청한 캐스팅디렉터는 걸러냄
      
    - 21일
      - 지원자 추천시 발생하는 오류 수정
      - 회원가입페이지에 프로필 사진 추가 및 공유된 지원자섹션 수정
      
    - 22일
      - 회원가입시 프로필사진 업로드구현
      - 회원정보수정페이지에서 프로필사진변경기능 추가
      
    - 23일
      - 프로필사진 head에 띄어줌
      - 회원정보수정페이지에서 프로필사진변경기능 추가
      - 사용자 mypage안에 유튜브 api사용,회원정보수정페이지에서 유튜브 url input창 만들고,정규식으로 유튜브 이외의 url걸러냄
      
    - 25일
      - 프로필사진 삭제구현,유튜브 url 저장해서 showmypage에서 url에서 videoid값만 뽑아내는 기능 추가,모바일에서 onclick이 안되는 오류 수정
      - 캐스팅디렉터 검색할때 결과값이 없으면 초기화하는 기능 오류 수정
      
    - 26일
      - 회원정보수정페이지에서 경력입력 기능추가
    
    - 27일
      - 경력이력->활동경력변경, db에 활동경력의 다중값을 구분자(,)를 통해서 저장후, 다시 화면에 뿌려주는 기능추가
      - recommendation 테이블 db.sql추가, career정보 얻어올때 발생한 오류수정, 캐스팅디렉터 검색후 검색목록 삭제기능추가, 마이페이지에 경력사항 보여줌
      
    - 31일
      - head.jsp의 프로필css수정,회원수정페이지 isni검색기능추가(controller,service,dao등등),admin header버튼수정
      
  - 8월
  
    - 1일
      - ISNI에서 관련된 작품들 가져와서 경력사항에 뿌려줌
      
    - 2일
      - 배우추가 페이지추가 및 기능구현 및 배우검색 페이지 작업중
      
    - 3일
      - 배우정보 모달창띄우기 및 유튜브영상 로드해서 보여주기,배우id에 맞는 file정보와 경력사항가져오기
      - 경력사항과 프로필사진화면에 보여줌
      
    - 4일
      - 배우검색결과 이름,나이,성별에 따른 정렬기능추가
      - 배우검색결과 이름,나이,성별에 따른 정렬기능추가(오류수정)
      - 배우검색 반응형 페이지네이션 작업 및 기존 ajax로 받아오던방식을 수정하고 form방식으로 교체
   
    - 5일
      - 배우검색 모달창 반응형 수정
      - 로딩시 화면 눌리지않도록 수정,배우검색 프로필대체 이미지 위치수정
    
    - 8일
      - 메인페이지 silder 구현을위해 swiper js도입 및 메인페이지 레이아웃 수정
      - 모바일탑바부분 css수정 및 메인페이지 css수정
      - Castring Call 페이지 작업중
    
    - 9일 
      - 작품리스트 페이지 css수정
      - 공고 리스트페이지 css수정
      
    - 10일
      - 공고리스트 상단 float로 auditions와 정렬버튼 양쪽끝 배치
      
    - 11일
      - 공고리스트 float제거 justify-between사용
      
    - 12일
      - 작품리스트페이지에서 작품이미지 보여주고 작성자 이미지도 보여줌, 작품상세페이지에서 이미지보여줌,만약 이미지없으면 css로 장르를 띄워줌.
      - 모집배역 컨트롤러단에서 리스트로 만들어서 작품상세페이지로 데이터보내기,작품리스트에서 작품등록자 프로필이없는경우 다른이미지보여줌