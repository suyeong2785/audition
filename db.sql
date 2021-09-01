# DB 세팅
DROP DATABASE IF EXISTS `audition`;
CREATE DATABASE `audition`;
USE `audition`;

# article 테이블 세팅
CREATE TABLE article (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    title CHAR(200) NOT NULL,
    `body` LONGTEXT NOT NULL
);

# article 테이블에 테스트 데이터 삽입
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2',
displayStatus = 1;

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3',
displayStatus = 1;

# member 테이블 세팅
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	authStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    loginId CHAR(20) NOT NULL UNIQUE,
    loginPw CHAR(100) NOT NULL,
    `name` CHAR(20) NOT NULL,
    `nickname` CHAR(20) NOT NULL,
    `email` CHAR(100) NOT NULL,
    `phoneNo` CHAR(20) NOT NULL
);

# member 테이블에 테스트 데이터 삽입
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = SHA2('admin', 256),
`name` = '관리자',
`nickname` = '관리자',
`email` = '',
`phoneNo` = '';


# article 테이블 세팅
CREATE TABLE articleReply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    memberId INT(10) UNSIGNED NOT NULL,
    articleId INT(10) UNSIGNED NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `body` LONGTEXT NOT NULL
);

# articleReply 테이블에 테스트 데이터 삽입
INSERT INTO articleReply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
articleId = 1,
displayStatus = 1,
`body` = '내용1';

/* 게시물 댓글을 범용 댓글 테이블로 변경 */
RENAME TABLE `articleReply` TO `reply`;

ALTER TABLE `reply` ADD COLUMN `relTypeCode` CHAR(50) NOT NULL AFTER `memberId`,
CHANGE `articleId` `relId` INT(10) UNSIGNED NOT NULL;
ALTER TABLE `reply` ADD INDEX (`relId`, `relTypeCode`);
UPDATE reply
SET relTypeCode = 'article'
WHERE relTypeCode = '';

/* 파일 테이블 생성 */
CREATE TABLE `file` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	relTypeCode CHAR(50) NOT NULL,
	relId INT(10) UNSIGNED NOT NULL,
    originFileName VARCHAR(100) NOT NULL,
    fileExt CHAR(10) NOT NULL,
    typeCode CHAR(20) NOT NULL,
    type2Code CHAR(20) NOT NULL,
    fileSize INT(10) UNSIGNED NOT NULL,
    fileExtTypeCode CHAR(10) NOT NULL,
    fileExtType2Code CHAR(10) NOT NULL,
    fileNo TINYINT(2) UNSIGNED NOT NULL,
    `body` LONGBLOB
);

# 멤버 테이블 칼럼명 변경
ALTER TABLE `member` CHANGE `phoneNo` `cellphoneNo` CHAR(20) NOT NULL; 

# 게시물 테이블에 작성자 정보 추가
ALTER TABLE `article` ADD COLUMN `memberId` INT(10) UNSIGNED NOT NULL AFTER `delStatus`; 

UPDATE article
SET memberId = 1
WHERE memberId = 0;

# 파일 테이블에 유니크 인덱스 추가
ALTER TABLE `file` ADD UNIQUE INDEX (`relId`, `relTypeCode`, `typeCode`, `type2Code`, `fileNo`); 

# 파일 테이블의 기존 인덱스에 유니크가 걸려 있어서 relId가 0 인 동안 충돌이 발생할 수 있다. 그래서 일반 인덱스로 바꾼다.
ALTER TABLE `file` DROP INDEX `relId`, ADD INDEX (`relId` , `relTypeCode` , `typeCode` , `type2Code` , `fileNo`); 

# 게시물 테이블에 게시판 정보 추가
ALTER TABLE `article` ADD COLUMN `boardId` INT(10) UNSIGNED NOT NULL AFTER `delStatus`; 

UPDATE article
SET boardId = 1
WHERE boardId = 0;

# 게시판 테이블 추가
CREATE TABLE `board` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `code` CHAR(20) NOT NULL UNIQUE,
	`name` CHAR(20) NOT NULL UNIQUE
);

INSERT INTO `board`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'free',
`name` = '자유';

# 직업 테이블 추가
CREATE TABLE `job` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `code` CHAR(20) NOT NULL UNIQUE,
	`name` CHAR(20) NOT NULL UNIQUE
);

INSERT INTO `job`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'actor',
`name` = '배우';

# recruitment 테이블 세팅
CREATE TABLE recruitment (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    memberId INT(10) UNSIGNED NOT NULL,
    jobId INT(10) UNSIGNED NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `title` CHAR(100) NOT NULL,
    `body` TEXT NOT NULL,
    addi TEXT
);

# applyment 테이블 세팅
CREATE TABLE applyment (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME,
    updateDate DATETIME,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(20) NOT NULL,
    relId INT(10) UNSIGNED NOT NULL,
    delDate DATETIME,
	delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
	displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    `body` TEXT NOT NULL
);

# 부가정보테이블 
# 댓글 테이블 추가
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(30) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`); 

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# member 테이블에 테스트 데이터 삽입
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user1',
loginPw = SHA2('user1', 256),
`name` = '캐스팅디렉터',
`nickname` = '캐스팅디렉터',
`email` = '',
`cellphoneNo` = '';

INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user2',
loginPw = SHA2('user2', 256),
`name` = '김성훈',
`nickname` = '하정우',
`email` = '',
`cellphoneNo` = '';

# 신청테이블에 숨김여부 칼럼을 추가한다.
ALTER TABLE `applyment` ADD COLUMN `hideStatus` TINYINT(1) UNSIGNED DEFAULT 0 NOT NULL AFTER `delStatus`; 

# 작품 테이블 만들기
CREATE TABLE artwork (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `name` CHAR(50) NOT NULL,
    `productionName` CHAR(50) NOT NULL,
    `directorName` CHAR(50) NOT NULL,
    etc TEXT
);

INSERT INTO artwork
SET regDate = NOW(),
updateDate = NOW(),
`name` = '균',
`directorName` = '조용선',
productionName = '마스터원엔터테인먼트';

# 배역 테이블 만들기
CREATE TABLE actingRole (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    artworkId INT(10) UNSIGNED NOT NULL,
    realName CHAR(50) NOT NULL,
    `name` CHAR(50) NOT NULL,
    pay CHAR(50) NOT NULL,
    age CHAR(50) NOT NULL,
    job CHAR(100) NOT NULL,
    scriptStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    gender CHAR(5) NOT NULL,
    scenesCount TINYINT(2) UNSIGNED NOT NULL DEFAULT 0,
    shootingsCount TINYINT(2) UNSIGNED NOT NULL DEFAULT 0,
    `character` TEXT,
    etc TEXT
);

INSERT INTO actingRole
SET regDate = NOW(),
updateDate = NOW(),
artworkId = 1,
realName = '',
`name` = '조대표',
`job` = '오투 CEO',
pay = '',
age = '',
scriptStatus = 1,
gender = '',
scenesCount = '14',
shootingsCount = '8',
`character` = '오투 한국지사 CEO. 영국국적을 가지고 있고 가습기 살균제 사건을 막기 위해 우식을 TFI 부서 로 복직시킨다. 자신의 이익만을 생각한다.',
etc = '';

ALTER TABLE `recruitment` ADD COLUMN `completeStatus` TINYINT(1) UNSIGNED DEFAULT 0 NOT NULL AFTER `addi`, ADD COLUMN `completeDate` DATETIME AFTER `completeStatus`;

ALTER TABLE `recruitment` ADD COLUMN `roleTypeCode` CHAR(50) NOT NULL AFTER `completeDate`, ADD COLUMN `roleId` INT(10) UNSIGNED NOT NULL AFTER `roleTypeCode`; 

DELETE FROM actingRole
WHERE id = 1;

ALTER TABLE `actingRole` ADD COLUMN `auditionStatus` TINYINT(1) UNSIGNED DEFAULT 0 NOT NULL AFTER `scriptStatus`;

ALTER TABLE `actingRole` CHANGE `scenesCount` `scenesCount` CHAR(10) NOT NULL;
ALTER TABLE `actingRole` CHANGE `shootingsCount` `shootingsCount` CHAR(10) NOT NULL; 

ALTER TABLE `actingRole` CHANGE `realName` `realName` CHAR(50) DEFAULT '' NOT NULL;
ALTER TABLE `actingRole` CHANGE `pay` `pay` CHAR(50) DEFAULT '' NOT NULL;
ALTER TABLE `actingRole` CHANGE `age` `age` CHAR(50) DEFAULT '' NOT NULL;
ALTER TABLE `actingRole` CHANGE `job` `job` CHAR(100) DEFAULT '' NOT NULL;
ALTER TABLE `actingRole` CHANGE `gender` `gender` CHAR(5) DEFAULT '' NOT NULL;
ALTER TABLE `actingRole` CHANGE `scenesCount` `scenesCount` CHAR(10) DEFAULT '' NOT NULL;
ALTER TABLE `actingRole` CHANGE `shootingsCount` `shootingsCount` CHAR(10) DEFAULT '' NOT NULL;

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;

# file에 fileDir 추가
ALTER TABLE `file` ADD COLUMN `fileDir` CHAR(20) NOT NULL AFTER `body`; 

# applyment에 오디션결과를 보여주는 result컬럼 추가 (오디션결과 (0)답변없음,(1)합격 (2)불합격)
ALTER TABLE `applyment` ADD COLUMN `result` TINYINT NOT NULL DEFAULT 0 AFTER `relId`;

# member에 나이를 age,gender칼럼 추가 (지원자의 나이와,성별이 필요하기 때문)
ALTER TABLE `member` ADD COLUMN `age` TINYINT UNSIGNED NOT NULL AFTER `name`;
ALTER TABLE `member` ADD COLUMN `gender` CHAR(6) NOT NULL AFTER `age`;

UPDATE `member`
SET age = 25
WHERE age = 0;

UPDATE `member`
SET gender = '남자'
WHERE gender = '';

# actingRole 테스트 데이터를 추가
INSERT INTO actingRole
SET regDate = NOW(),
updateDate = NOW(),
artworkId = 1,
realName = '홍길동',
`name` = '홍길순',
pay = 300,
age = 29,
job = '사기꾼',
scriptStatus = 1,
auditionStatus = 1,
gender = '남자',
scenesCount = 16,
shootingsCount = 20,
`character` = '이러쿵저러쿵',
etc = '';

# actingRole 테스트 데이터를 추가
INSERT INTO actingRole
SET regDate = NOW(),
updateDate = NOW(),
artworkId = 1,
realName = '방수영',
`name` = '방세진',
pay = 200,
age = 27,
job = '협잡꾼',
scriptStatus = 1,
auditionStatus = 1,
gender = '남자',
scenesCount = 16,
shootingsCount = 20,
`character` = '어쩌구저쩌구',
etc = '';

# recruitment 테스트 데이터를 추가
INSERT INTO recruitment
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
jobId = 1,
displayStatus = 1,
title = '',
`body` = '',
roleTypeCode = 'actingRole',
roleId = 2;

INSERT INTO recruitment
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
jobId = 1,
displayStatus = 1,
title = '',
`body` = '',
roleTypeCode = 'actingRole',
roleId = 3;

# 캐스팅 디렉터들간의 공유기능을 테스트하기위한 데이터를 추가
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user3',
loginPw = SHA2('user3', 256),
`name` = '캐스팅디렉터2',
`nickname` = '캐스팅디렉터2',
age = 25,
gender = '남자',
`email` = '',
`cellphoneNo` = '';

# 권한에 따른 페이지를 페이지를 보여주기위한 member 테이블에 권한 칼럼 추가 (0):관리자 (1):캐스팅디렉터 (2):유저(배우지망생)
ALTER TABLE `member` ADD COLUMN authority TINYINT UNSIGNED NOT NULL AFTER authStatus;

UPDATE `member`
SET authority = 1
WHERE `name` LIKE '캐스팅디렉터%';

UPDATE `member`
SET authority = 2
WHERE `name` NOT LIKE '캐스팅디렉터%'
AND `name` NOT LIKE '관리자';

# 캐스팅디렉터들이 지원자를 추천할때 추천횟수 기록
ALTER TABLE `member` ADD COLUMN recommendation INT UNSIGNED NOT NULL DEFAULT 0 AFTER cellphoneNo;

# 캐스팅 디렉터들이 서로 공유할때 공유한 멤버들 기록
CREATE TABLE `share`(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
answer TINYINT NOT NULL DEFAULT 0 COMMENT "(1) 수락 (2)거절",
relTypeCode CHAR(10) NOT NULL,
actorId INT UNSIGNED NOT NULL,
targetId INT UNSIGNED NOT NULL
);

# share 테이블에 delDate,delStatus 추가
ALTER TABLE `share` 
ADD COLUMN delDate DATETIME AFTER updateDate,
ADD COLUMN delStatus TINYINT NOT NULL DEFAULT 0 AFTER delDate;

# share 테이블에 컬럼이름 바꿈(actorId가 혼란을 야기할수있기 때문)
ALTER TABLE `share`
CHANGE COLUMN actorId requesterId INT UNSIGNED NOT NULL,
CHANGE COLUMN targetId requesteeId INT UNSIGNED NOT NULL;

# 자기소개 영상 youtube URL을 member정보에 추가
ALTER TABLE `member`
ADD COLUMN `youTubeUrl` VARCHAR(100) NOT NULL AFTER cellphoneNo;

#경력db 생성
CREATE TABLE career(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
jobId INT UNSIGNED NOT NULL,
`date` TEXT NOT NULL,
memberId INT UNSIGNED NOT NULL,
artwork TEXT NOT NULL
);

ALTER TABLE `career`
ADD COLUMN delDate DATETIME NULL AFTER updateDate,
ADD COLUMN delStatus TINYINT DEFAULT 0 NOT NULL AFTER delDate;

#member 테이블에 jobId 생성
ALTER TABLE `member`
ADD COLUMN jobId TINYINT NOT NULL DEFAULT 0 AFTER authority;

UPDATE `member` SET `jobId` = '1' WHERE `id` = '3'; 

INSERT INTO `job`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'castingDirector',
`name` = '캐스팅디렉터';

UPDATE `member` SET `jobId` = '2' WHERE `id` = '2'; 
UPDATE `member` SET `jobId` = '2' WHERE `id` = '4'; 

#추천기능추가 이전에 만들어놨는데 사라짐.....
CREATE TABLE `recommendation`(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
relTypeCode CHAR(10) NOT NULL,
relId INT UNSIGNED NOT NULL,
recommenderId INT UNSIGNED NOT NULL,
recommendeeId INT UNSIGNED NOT NULL,
recommendationStatus TINYINT NOT NULL
);

#member 테이블에 ISNI Number 컬럼추가(이후의 ISNI와의 연동을 위한 사전작업)
ALTER TABLE `member` ADD COLUMN `ISNI_number` CHAR(16) NOT NULL; 


#admin으로 배우정보 추가 검색할수있도록 관리할 actor 테이블을 추가
CREATE TABLE `actor`(
id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
`name` VARCHAR(10) NOT NULL,
nickname VARCHAR(10) NOT NULL,
gender CHAR(2) NOT NULL,
age TINYINT UNSIGNED DEFAULT 0 NOT NULL,
height TINYINT UNSIGNED DEFAULT 0 NOT NULL,
weight TINYINT UNSIGNED DEFAULT 0 NOT NULL,
careerId INT UNSIGNED NOT NULL,
email VARCHAR(30) NOT NULL,
phone CHAR(11) NOT NULL
);

#member테이블에 경력 db연결 
ALTER TABLE `member` ADD COLUMN careerId INT UNSIGNED NOT NULL AFTER loginId;

#career테이블에 member db연결 
ALTER TABLE `career` DROP COLUMN memberId;

#career테이블에 모달창으로 보여줄 데이터들 추가 및수정 
ALTER TABLE `actor` ADD COLUMN youTubeUrl VARCHAR(100) NOT NULL ; 

ALTER TABLE actor ADD COLUMN delDate DATETIME AFTER `updateDate`,
ADD COLUMN delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 AFTER `delDate`,
ADD COLUMN displayStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 AFTER `delStatus`;

ALTER TABLE `actor` MODIFY COLUMN careerId INT UNSIGNED NOT NULL DEFAULT 0 AFTER email;

ALTER TABLE `actor` MODIFY COLUMN email VARCHAR(30) NULL AFTER careerId;

ALTER TABLE `actor` MODIFY COLUMN phone CHAR(11) NULL AFTER youTubeUrl;

ALTER TABLE `actor` MODIFY COLUMN youTubeUrl VARCHAR(100) NULL;

ALTER TABLE `actor` MODIFY COLUMN nickname VARCHAR(10) NULL;

ALTER TABLE `actor` MODIFY COLUMN delStatus VARCHAR(10) NULL;

#배우db에 테스트 데이터추가
INSERT INTO `actor`
SET regDate = NOW(),
updateDate = NOW(),
`name` = '유한나',
`gender` = 'W',
`age` = FLOOR(RAND()*100),
height = FLOOR(RAND()*100),
weight = FLOOR(RAND()*100),
email = 'qkdtpwls@gamil.com'; 

INSERT INTO `board`
SET regDate = NOW(),
updateDAte = NOW(),
`code` = 'actor',
`name` = '배우';

#actingRole을 조PD님이 주신 ppt자료에 맞춰서 변경
ALTER TABLE `artwork` ADD COLUMN `genre` VARCHAR(10) NOT NULL AFTER NAME;
ALTER TABLE `artwork` ADD COLUMN `investor` VARCHAR(15) NOT NULL AFTER NAME;
ALTER TABLE `artwork` MODIFY COLUMN `investor` TEXT NOT NULL AFTER genre;
ALTER TABLE `artwork` ADD COLUMN `leadActor` TEXT NOT NULL AFTER directorName;
ALTER TABLE `artwork` ADD COLUMN `startDate` DATETIME NULL AFTER updateDate;
ALTER TABLE `artwork` ADD COLUMN `endDate` DATETIME NULL AFTER startDate;
ALTER TABLE `artwork` ADD COLUMN `actingRole` TEXT NULL AFTER `leadActor`;
ALTER TABLE `artwork` ADD COLUMN `actingRoleGender` TEXT NULL AFTER `actingRole`;
ALTER TABLE `artwork` ADD COLUMN `actingRoleAge` TEXT NULL AFTER `actingRoleGender`;
ALTER TABLE `artwork` ADD COLUMN `memberId` INT NOT NULL AFTER `endDate`;

UPDATE `artwork`
SET memberId = 1
WHERE memberId = 0;

/*
text는 디폴트 값 설정이안됨..
ALTER TABLE `artwork` MODIFY COLUMN `investor` TEXT NOT NULL DEFAULT '개별안내' AFTER genre;
ALTER TABLE `artwork` MODIFY COLUMN `leadActor` TEXT NOT NULL DEFAULT '개별안내' AFTER directorName;
ALTER TABLE `artwork` MODIFY COLUMN `directorName` TEXT NOT NULL DEFAULT '개별안내' AFTER productionName;
*/

#actingRole을 조PD님이 주신 ppt자료에 맞춰서 변경
ALTER TABLE `actingRole` ADD COLUMN feature TEXT NOT NULL AFTER job;
ALTER TABLE `actingRole` ADD COLUMN region VARCHAR(9) NOT NULL AFTER feature;
ALTER TABLE `actingRole` ADD COLUMN `schedule` VARCHAR(20) NOT NULL AFTER region;
ALTER TABLE `actingRole` ADD COLUMN `shotAngle` CHAR(2) NOT NULL AFTER `schedule`;
ALTER TABLE `actingRole` DROP COLUMN scenesCount;
ALTER TABLE `actingRole` DROP COLUMN realName;
ALTER TABLE `actingRole` DROP COLUMN auditionStatus;
ALTER TABLE `actingRole` DROP COLUMN `character`;
ALTER TABLE `actingRole` DROP COLUMN `etc`;
ALTER TABLE `actingRole` ADD COLUMN thumbnailStatus TINYINT DEFAULT 0 NOT NULL AFTER artworkId;
ALTER TABLE `actingRole` ADD COLUMN startDate DATETIME AFTER updateDate;
ALTER TABLE `actingRole` ADD COLUMN endDate DATETIME AFTER startDate;
ALTER TABLE `actingRole` MODIFY COLUMN gender CHAR(2) NOT NULL AFTER age;

# actingRole에 videoStatus 추가
ALTER TABLE `actingRole` ADD COLUMN videoStatus TINYINT NOT NULL DEFAULT 0 AFTER scriptStatus ;

# actingRole에 videoStatus 삭제(동영상업로드대신 유튜브 url대체위함)
ALTER TABLE `actingRole` DROP COLUMN videoStatus;

# actingRole에 guideVideoUrl 추가(동영상업로드대신 유튜브 url대체위함)
ALTER TABLE `actingRole` ADD COLUMN guideVideoUrl VARCHAR(100) NOT NULL AFTER shotAngle ;

# actingRole에 guideVideoUrl 추가(동영상업로드대신 유튜브 url대체위함)
ALTER TABLE `applyment` DROP COLUMN `body`;

# share에 relId 추가
ALTER TABLE `share` ADD COLUMN `relId` VARCHAR(100) NOT NULL AFTER relTypeCode;

/*
select * from `file`;
SELECT * FROM `actingRole`;
SELECT * FROM `recruitment`;
SELECT * FROM `applyment`;
select * from `member`;
select * from `attr`;
select * from `artwork`;
select * from  reply;
select * from `career`;
select * from  share;
select * from  recommendation;
select * from  actor;
*/

DESC `actingRole`;
DESC `artwork`;
DESC `share`;