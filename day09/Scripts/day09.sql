SELECT * FROM PLAYER;
/*
TCL(Transaction Control Language) : 트랜잭션 제어어

트랜잭션
   - 하나의 작업 단위
   - 여러 개의 SQL문의 묶음

1. COMMIT;
   - 모든 작업(트랜잭션)을 확정하는 명령어

2. ROLLBACK;
   - 이전 커밋 시점으로 되돌아가는 명령어
   ※ ROLLBACK; 을 여러 번 한다고 해서, 계속 이전으로 가는 것은 아니다.

▶ TCL은 DML에만 영향을 끼친다.
- TRUNCATE :    DDL(롤백 불가능)
- DELETE :    DML(롤백 가능)
-> 되도록이면 DELETE 를 사용해서 데이터를 삭제하도록 하자!

롤백 테스트!

PLAYER 테이블에서 TEAM_ID 가 'K01'인 선수 이름을 내 이름으로 바꾸기!
단, 메뉴얼 커밋이어야 한다.
 */
UPDATE PLAYER
SET PLAYER_NAME = '류호근'
WHERE TEAM_ID = 'K01';

SELECT * FROM PLAYER
WHERE TEAM_ID = 'K01';

SELECT COUNT(PLAYER_ID)
FROM PLAYER
WHERE HEIGHT IS NULL;

SELECT HEIGHT
FROM PLAYER;

--================================================================
/* 
 *GROUP BY, HAVING 절
 * 위치는 WHERE절 다음, ORDER BY 이전에 작성한다.
 * HAVING절은 GROUP BY 다음에 사용할 수 있으며, SELECT 의 WHERE 절 처럼 GROUP BY의 HAVING도 조건을 걸어준다.
 * WHERE절은 테이블 전체에 조건을 걸어 데이터를 가져오며,  그 데이터들을 GROUP BY로 묶어준다.
 * HAVING 절은 묶은 데이터에 조건이 필요하다면 HAVING절에 작성한다.
 * 
 * SQL 실핸순서(SELECT)
 * FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER BY
 * GROUP BY : ~별 (예 : 포지션 별 평균키)
 * 문법
 * GROUP BY 컬럼명
 * HAVING 조건식
 *  
 */
SELECT DISTINCT "POSITION"
FROM PLAYER;

SELECT *
FROM PLAYER
GROUP BY "POSITION";
--오류발생! 포지션의 종류는 NULL까지 5가지
--5개의 행으로 모든 정보를 본다는 것은 말이 되지 않기에, 에러가 난다.

SELECT AVG(HEIGHT)
FROM PLAYER
GROUP BY "POSITION";

--포지션별 평균키
SELECT "POSITION", AVG(HEIGHT)
FROM PLAYER
GROUP BY "POSITION"

--HAVING에서는 집계함수 사용 가능
SELECT "POSITION", AVG(HEIGHT)
FROM PLAYER
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180;

--정렬추가
SELECT "POSITION", AVG(HEIGHT) 평균키
FROM PLAYER
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180
ORDER BY 평균키 ASC; 

--WHERE 추가
--키가 180이상인 축구 선수들의 표지션별 평균키가 180을 초과하는 포지션을 구하고 평균키 오름차순으로 조회하라 
SELECT "POSITION", AVG(HEIGHT) 평균키
FROM PLAYER
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180
ORDER BY 평균키 ASC; 

-- 실 습
-- PLAYER테이블에서 몸무게가 80이상인 선수들의 평균키가 180 초과인 포지션 검색
SELECT "POSITION", AVG(HEIGHT)
FROM PLAYER
WHERE WEIGHT >= 80
GROUP BY "POSITION"
HAVING AVG(HEIGHT) > 180;

--EMPLOYEES테이블에서JOB_ID별 평균 SALARY가 10000미만인 JOB_ID 검색
--JOB_ID는 알파벳순으로 정렬(오름차순)

SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING AVG(SALARY)<10000
ORDER BY JOB_ID;

/*
 * PLAYER 테이블 실습
 */

/*
 * PLAYER_ID 가  2007로 시작하는 선수들 중
 * POSITION 별 평균키를 조회
 */


SELECT "POSITION", AVG(HEIGHT)
FROM PLAYER
WHERE PLAYER_ID LIKE '2007%'
GROUP BY "POSITION"

/*
 * 선수들 중 포지션이DF인 선수들의 평균 키를 TEAM_ID 별로 조회하고 평균 키 오름차순으로 정렬하기
 */
SELECT TEAM_ID, AVG(HEIGHT) 평균키
FROM PLAYER
WHERE "POSITION" = 'DF'
GROUP BY TEAM_ID
ORDER BY 평균키;

/*
 * 포지션이 MF 인 선수들의 입단연도별 평균 몸무게, 평균 키를 구하는데,
 * 컬럼명은 입단연도, 평균, 몸무게, 평균 키로 표시한다.
 * 단,평균 몸무게는 70 이상, 평균키는 160이상인 입단연도만 조회한다.
 * 입단연도를 오름차순으로 정렬한다.
 */

SELECT *
FROM PLAYER;

SELECT JOIN_YYYY 입단연도, AVG(WEIGHT) 평균몸무게, AVG(HEIGHT) 평균키 -- "알리아스내부에 SPACE가 있으면 ""로 묶어줘야 에러가 안남"
FROM PLAYER
WHERE "POSITION" = 'MF'
GROUP BY JOIN_YYYY
HAVING AVG(WEIGHT) >= 70 AND AVG(HEIGHT)>=160
ORDER BY 입단연도;

/*
 * EMPLOYEES
 * COMMOTION_PCT 별 평균급여를 조회한다.
 * COMMITION_PCT를 오름차순으로 정렬하며
 * HAVING절을 사용하여 NULL은 제외하자.
 */

SELECT COMMISSION_PCT, AVG(SALARY)
FROM EMPLOYEES
GROUP BY COMMISSION_PCT
HAVING COMMISSION_PCT IS NOT NULL
ORDER BY COMMISSION_PCT;

















