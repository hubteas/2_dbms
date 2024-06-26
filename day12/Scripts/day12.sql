SELECT * FROM PLAYER;

-- PLAYER 테이블에서 NICKNAME이 NULL인 선수를 '없음'으로 변경하여 조회하기
SELECT PLAYER_NAME, NICKNAME, NVL(NICKNAME, '없음')
FROM PLAYER
WHERE NICKNAME IS NULL;
-- PLAYER 테이블에서POSITION이 NULL인 선수를 '미정'으로 변경 후 검색
SELECT PLAYER_NAME, "POSITION", NVL("POSITION", '미정')
FROM PLAYER
WHERE "POSITION" IS NULL;
-- PLAYER 테이블에서 NATION이 등록되어 있으면 '등록'아니면 '미등록'으로 검색
SELECT PLAYER_NAME, NATION, NVL2(NATION, '등록', '미등록')
FROM PLAYER;

SELECT HEIGHT, NVL(HEIGHT, 170)
FROM PLAYER;


-- PLAYER 테이블에서 키가 NULL인 선수들의 키를 170으로 변경하여 평균 조회
SELECT AVG(NVL(HEIGHT, 170))
FROM PLAYER;
-- AVG함수를 쓰지 않고 PLAYER 테이블에서 선수들의 평균 키 구하기
-- 단, NULL 은 미포함.
SELECT SUM(HEIGHT)/COUNT(HEIGHT)
FROM PLAYER;


/*
 * DEPT 테이블의 LOC별 평균 급여를 셋째 자리에서 반올림한 값과 각 LOC별 SAL합을 조회
 */
SELECT * FROM DEPT;
SELECT * FROM EMP;
--복습
--SELECT D.LOC, ROUND(AVG(SAL),2), SUM(SAL)
--FROM DEPT D JOIN EMP e
--ON D.DEPTNO = E.DEPTNO
--GROUP BY D.LOC;

SELECT LOC, ROUND(AVG(SAL),2), SUM(SAL)
FROM DEPT d JOIN EMP e 
ON D.DEPTNO =E.DEPTNO 
GROUP BY LOC;
/*
 * PLAYER 테이블에서 팀별 최대 몸무게인 선수 전체 정보 검색
 */
--복습
--SELECT * FROM PLAYER;
--SELECT * FROM TEAM;
--
--SELECT *
--FROM (
--	SELECT TEAM_ID, MAX(WEIGHT) WEIGHT 
--	FROM PLAYER
--	GROUP BY TEAM_ID
--)P1 JOIN PLAYER p2
--ON P1.TEAM_ID = P2.TEAM_ID 
--AND P1.WEIGHT = P2.WEIGHT 
--ORDER BY P1.TEAM_ID;



SELECT P2.*
FROM (
	SELECT TEAM_ID, MAX(WEIGHT) WEIGHT
	FROM PLAYER
	GROUP BY TEAM_ID
) P1 JOIN PLAYER P2
ON P1.TEAM_ID = P2.TEAM_ID
AND P1.WEIGHT= P2.WEIGHT
ORDER BY P1.TEAM_ID;



/*
 * EMP테이블에서 HIREDATE가 FORD의 입사년도와 같은 사원 전체 정보 조회
 */

--SELECT TO_CHAR(HIREDATE,'YYYY') 
--FROM EMP
--WHERE ENAME ='FORD';
--
--SELECT *
--FROM EMP
--WHERE TO_CHAR(HIREDATE,'YYYY') = (
--	SELECT TO_CHAR(HIREDATE,'YYYY') 
--	FROM EMP
--	WHERE ENAME ='FORD'
--);


SELECT *
FROM EMP
WHERE ENAME  = 'FORD';

SELECT *
FROM EMP e 
WHERE HIREDATE BETWEEN '1971-01-01'AND '1981-12-31';

--서브쿼리
SELECT *
FROM EMP 
WHERE TO_CHAR(HIREDATE,'YYYY')=(
	SELECT TO_CHAR(HIREDATE,'YYYY')
	FROM EMP
	WHERE ENAME  = 'FORD'
);
--조인
SELECT *
FROM EMP E1 JOIN
(
	SELECT HIREDATE 
	FROM EMP
	WHERE ENAME = 'FORD'
) E2
ON TO_CHAR(E1.HIREDATE, 'YYYY')= TO_CHAR(E2.HIREDATE,'YYYY');
-- 형변환 함수
TO_CHAR();
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY"년-"MM"월-"DD"일"HH"시"MI"분"SS"초')
FROM DUAL;

SELECT 1000000000000
FROM DUAL;

SELECT TO_CHAR(1000000000000000000, FM999,999,999,999,999)
FROM DUAL;


--======================================================================
--===================================================================
-- EMP 테이블에서 DEPTNO 가 30 또는 10인 데이터를 조회하기
-- 두 테이블을 UNION 으로 연결한다.
SELECT * FROM EMP
WHERE DEPTNO = 30
UNION
SELECT * FROM EMP
WHERE DEPTNO = 10;

-- UNION 으로 다른 테이블의 값들도 같이 조회할 수 있을까??
-- 놉
-- 컬럼의 수가 달라서 에러!
SELECT * FROM EMP e 
UNION
SELECT * FROM DEPT d;

-- 자료형이 달라서 에러!
SELECT ENAME, HIREDATE, SAL
FROM EMP
UNION
SELECT * FROM DEPT d;

-- 나온다!
SELECT EMPNO, ENAME, JOB
FROM EMP
UNION
SELECT * FROM DEPT d;

-- 가상의 테이블이라는 것을 인지!
SELECT COUNT(*)
FROM
(
   SELECT EMPNO, ENAME, JOB
   FROM EMP
   UNION
   SELECT * FROM DEPT d
);

SELECT EMPNO, ENAME, JOB
FROM EMP
UNION
SELECT * 
FROM DEPT d
ORDER BY JOB;


SELECT EMPNO, ENAME, JOB
FROM EMP
UNION
SELECT * FROM
(
   SELECT * FROM DEPT d
   ORDER BY DEPTNO
);


--==================================================================
--VIEW
--PLAYER 테이블에서 나이 컬럼을 추가한 뷰 만들기
SELECT * FROM PLAYER;

SELECT P.*, ROUND((SYSDATE - BIRTH_DATE)/365) AGE
FROM PLAYER P;

CREATE VIEW VIEW_PLAYER AS 
SELECT P.*, ROUND((SYSDATE - BIRTH_DATE)/365) AGE FROM PLAYER P;

SELECT  * FROM VIEW_PLAYER;

-- 매뉴얼 커밋 하고! 실습!
SELECT * FROM VIEW_PLAYER
WHERE PLAYER_NAME = '류호근';


INSERT INTO HR.VIEW_PLAYER
(PLAYER_ID, PLAYER_NAME, TEAM_ID, E_PLAYER_NAME, NICKNAME, JOIN_YYYY, "POSITION", BACK_NO, NATION, BIRTH_DATE, SOLAR, HEIGHT, WEIGHT)
VALUES('AB', '류호근', 'K01', 'DD', 'DD', 'DD', 'DD', 3, 'DD', SYSDATE, 'D', 0, 0);

SELECT * FROM PLAYER
WHERE PLAYER_NAME = '류호근';
-- 오토커밋으로 다시 컴백!
-- EMPNM,MGR
--================================================================
--EMP 테이블에서 사원의 이름과 그 사원의 매니저 이름이 있는 VIEW 만들기
-- 구해야할것 = 사원의 이름 사원의 매니저이름, 사원번호, 매니저번호
SELECT * FROM EMP;

SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.ENAME
FROM EMP e1 JOIN EMP E2 
ON E1.MGR = E2.EMPNO;

--SELECT *
--FROM EMP e1 JOIN EMP E2 
--ON E1.MGR = E2.EMPNO;

CREATE VIEW VIEW_EMP AS
SELECT E1.EMPNO, E1.ENAME, E1.MGR, E2.ENAME
FROM EMP e1 JOIN EMP E2 
ON E1.MGR = E2.EMPNO;