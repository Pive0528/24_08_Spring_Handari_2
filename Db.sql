###
(INIT 시작)
# DB 세팅
DROP
DATABASE IF EXISTS `24_08_Spring`;
CREATE
DATABASE `24_08_Spring`;
USE
`24_08_Spring`;

ALTER TABLE article MODIFY `body` LONGTEXT;


#
게시글 테이블 생성
CREATE TABLE article
(
    id         INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate    DATETIME     NOT NULL,
    updateDate DATETIME     NOT NULL,
    title      VARCHAR(255) NOT NULL, -- 고정 길이 대신 가변 길이로 변경
    `body`     LONGTEXT     NOT NULL  -- TEXT에서 LONGTEXT로 변경하여 크기 제한 해소
);

#
회원 테이블 생성
CREATE TABLE `member`
(
    id           INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate      DATETIME  NOT NULL,
    updateDate   DATETIME  NOT NULL,
    loginId      CHAR(30)  NOT NULL,
    loginPw      CHAR(100) NOT NULL,
    `authLevel`  SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반,7=관리자)',
    `name`       CHAR(20)  NOT NULL,
    nickname     CHAR(50)  NOT NULL,
    cellphoneNum CHAR(20)  NOT NULL,
    email        CHAR(50)  NOT NULL,
    delStatus    TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
    delDate      DATETIME COMMENT '탈퇴 날짜'
);

CREATE TABLE faq_responses
(
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    question   TEXT NOT NULL,
    answer     TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


##
게시글 테스트 데이터 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목4',
`body` = '내용4';


##
회원 테스트 데이터 생성
## (관리자)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
nickname = '관리자',
cellphoneNum = '01012341234',
email = 'abc@gmail.com';

##
(일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1_이름',
nickname = '회원1_닉네임',
cellphoneNum = '01043214321',
email = 'abcd@gmail.com';

##
(일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2_이름',
nickname = '회원2_닉네임',
cellphoneNum = '01056785678',
email = 'abcde@gmail.com';

ALTER TABLE article
    ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

UPDATE article
SET memberId = 2
WHERE id IN (1, 2);

UPDATE article
SET memberId = 3
WHERE id IN (3, 4);


#
게시판(board) 테이블 생성
CREATE TABLE board
(
    id         INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate    DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code`     CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) QnA(질의응답) ...',
    `name`     CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
    delStatus  TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
    delDate    DATETIME COMMENT '삭제 날짜'
);

##
게시판(board) 테스트 데이터 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = '공지사항',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = '자유게시판',
`name` = '자유게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = '축제후기',
`name` = '축제후기';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = '분실물신고',
`name` = '분실물신고';


ALTER TABLE article
    ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER `memberId`;

UPDATE article
SET boardId = 1
WHERE id IN (1, 2);

UPDATE article
SET boardId = 2
WHERE id = 3;

UPDATE article
SET boardId = 3
WHERE id = 4;

UPDATE article
SET boardId = 4
WHERE id = 5;

ALTER TABLE article
    ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `body`;



#
reactionPoint 테이블 생성
CREATE TABLE reactionPoint
(
    id          INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate     DATETIME NOT NULL,
    updateDate  DATETIME NOT NULL,
    memberId    INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId       INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `point`     INT(10) NOT NULL
);

#
reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = -1;

#
1번 회원이 2번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

#
2번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`point` = -1;

#
2번 회원이 2번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`point` = -1;

#
3번 회원이 1번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

#
article 테이블에 reactionPoint(좋아요) 관련 컬럼 추가
ALTER TABLE article
    ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE article
    ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

#
update join -> 기존 게시글의 good bad RP 값을 RP 테이블에서 추출해서 article table에 채운다
UPDATE article AS A
    INNER JOIN (
    SELECT RP.relTypeCode, Rp.relId,
    SUM (IF(RP.point > 0,RP.point,0)) AS goodReactionPoint,
    SUM (IF(RP.point < 0,RP.point * -1,0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode,Rp.relId
    ) AS RP_SUM
ON A.id = RP_SUM.relId
    SET A.goodReactionPoint = RP_SUM.goodReactionPoint, A.badReactionPoint = RP_SUM.badReactionPoint;

#
reply 테이블 생성
CREATE TABLE reply
(
    id          INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate     DATETIME NOT NULL,
    updateDate  DATETIME NOT NULL,
    memberId    INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId       INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body`      TEXT     NOT NULL
);

#
2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 1';

#
2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 2';

#
3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 3';

#
3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 4';

#
update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE reply AS R
    INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM (IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM (IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
    ) AS RP_SUM
ON R.id = RP_SUM.relId
    SET R.goodReactionPoint = RP_SUM.goodReactionPoint, R.badReactionPoint = RP_SUM.badReactionPoint;

###
(INIT 끝)
##########################################
SELECT *
FROM article
ORDER BY id DESC;

SELECT *
FROM board;

SELECT *
FROM `member`;

SELECT *
FROM `reactionPoint`;

SELECT *
FROM `reply`;

###############################################################################

SELECT IFNULL(SUM(RP.point), 0)
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
  AND RP.relId = 3
  AND RP.memberId = 2 ## 게시글 테스트 데이터 대량 생성
INSERT
INTO article
(regDate, updateDate, memberId, boardId, title, `body`)
SELECT NOW(),
       NOW(),
       FLOOR(RAND() * 2) + 2,
       FLOOR(RAND() * 3) + 1,
       CONCAT('제목__', RAND()),
       CONCAT('내용__', RAND())
FROM article;


SELECT FLOOR(RAND() * 2) + 2

SELECT FLOOR(RAND() * 3) + 1
    INSERT
INTO article
SET regDate = NOW(), updateDate = NOW(), title = CONCAT('제목__', RAND()), `body` = CONCAT('내용__', RAND());

SHOW
FULL
COLUMNS FROM `member`;
DESC `member`;

SELECT *
FROM article
WHERE boardId = 1
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 2
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 3
ORDER BY id DESC;

'111'

SELECT COUNT(*) AS cnt
FROM article
WHERE boardId = 1
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 1
  AND title LIKE '%123%'
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 1
  AND `body` LIKE '%123%'
ORDER BY id DESC;

SELECT *
FROM article
WHERE boardId = 1 AND title LIKE '%123%'
   OR `body` LIKE '%123%'
ORDER BY id DESC;

SELECT COUNT(*)
FROM article AS A
WHERE A.boardId = 1
ORDER BY A.id DESC;

boardId
=1&searchKeywordTypeCode=nickname&searchKeyword=1

SELECT COUNT(*)
FROM article AS A
WHERE A.boardId = 1
  AND A.memberId = 3
ORDER BY A.id DESC;

SELECT hitCount
FROM article
WHERE id = 3

SELECT *
FROM `reactionPoint`;

SELECT A.*, M.nickname AS extra__writer
FROM article AS A
         INNER JOIN `member` AS M
                    ON A.memberId = M.id
WHERE A.id = 1 # LEFT JOIN
SELECT A.*, M.nickname AS extra__writer, RP.point
FROM article AS A
         INNER JOIN `member` AS M
                    ON A.memberId = M.id
         LEFT JOIN reactionPoint AS RP
                   ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

#
서브쿼리
SELECT A.*,
       IFNULL(SUM(RP.point), 0)                      AS extra__sumReactionPoint,
       IFNULL(SUM(IF(RP.point > 0, RP.point, 0)), 0) AS extra__goodReactionPoint,
       IFNULL(SUM(IF(RP.point < 0, RP.point, 0)), 0) AS extra__badReactionPoint
FROM (SELECT A.*, M.nickname AS extra__writer
      FROM article AS A
               INNER JOIN `member` AS M
                          ON A.memberId = M.id) AS A
         LEFT JOIN reactionPoint AS RP
                   ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

# JOIN
    SELECT
A
.*, M.nickname AS extra__writer,
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0,RP.point,0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0,RP.point,0)),0) AS extra__badReactionPoint
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

SELECT IFNULL(SUM(RP.point), 0)
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
  AND RP.relId = 3
  AND RP.memberId = 1;

/*


-- Remove the existing 4 test articles
DELETE FROM article;

-- Generate 80 articles with random titles and bodies
INSERT INTO article (regDate, updateDate, memberId, boardId, title, `body`, hitCount)
SELECT 
    NOW(), 
    NOW(), 
    FLOOR(RAND() * 2) + 2,  -- Random memberId (2 or 3)
    FLOOR(RAND() * 3) + 1,  -- Random boardId (1 to 3)
    CONCAT('제목_', FLOOR(RAND() * 100)),  -- Random title
    CONCAT('내용_', FLOOR(RAND() * 100)),  -- Random body
    0  -- Initial hitCount

FROM
    (SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION
    SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION
    SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION
    SELECT 31 UNION SELECT 32 UNION SELECT 33 UNION SELECT 34 UNION SELECT 35 UNION SELECT 36 UNION SELECT 37 UNION SELECT 38 UNION SELECT 39 UNION SELECT 40 UNION
    SELECT 41 UNION SELECT 42 UNION SELECT 43 UNION SELECT 44 UNION SELECT 45 UNION SELECT 46 UNION SELECT 47 UNION SELECT 48 UNION SELECT 49 UNION SELECT 50 UNION
    SELECT 51 UNION SELECT 52 UNION SELECT 53 UNION SELECT 54 UNION SELECT 55 UNION SELECT 56 UNION SELECT 57 UNION SELECT 58 UNION SELECT 59 UNION SELECT 60 UNION
    SELECT 61 UNION SELECT 62 UNION SELECT 63 UNION SELECT 64 UNION SELECT 65 UNION SELECT 66 UNION SELECT 67 UNION SELECT 68 UNION SELECT 69 UNION SELECT 70 UNION
    SELECT 71 UNION SELECT 72 UNION SELECT 73 UNION SELECT 74 UNION SELECT 75 UNION SELECT 76 UNION SELECT 77 UNION SELECT 78 UNION SELECT 79 UNION SELECT 80) AS Numbers;
