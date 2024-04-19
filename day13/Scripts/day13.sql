--DDL 데이터 정의어
-- 데이터베이스를 정의하는 언어를 말하며 데이터를 생성하거나 수정, 삭제 등 데이터의 전체 골격을 결정하는 역할의 언어
-- CREATE, ALTER, DROP, TRUNCATE
--DML 데이터 조작어
-- 정의된 데이터베이스에 입력된 레코드를 조회하거나 수정하거나 삭제하는 등의 역할을 하는언어를 말한다
-- 테이블에 있는 행과 열을 조작하는 언어 즉 데이터를 실질적으로 처리하는데 사용하는 언어
-- SELECT, INSERT, UPDATE, DELETE
--TCL DCL에서 트랜잭션을 제어하는 명력인 COMMIT와 ROLLBACK 만을 따로 분리해서 TCL이라고 표현한다.
-- COMMIT, ROLLBACK
--DCL 데이터 제어어
-- 데이터베이스에 접근하거나 객체에 권한을 주는 등의 역할을 하는 언어를 말한다. 데이터를 제어하는 언어.
-- 데이터를 제어하는언어. 데이터의 보안 무결성 회복등을 정의하는데 사용한다
-- grant, revoke, commit, rollback


--CASE 표현식
/*
CASE
	WHEN 조건1 THEN 값1
	WHEN 조건2 THEN 값2
	...
	ELSE 값//생략 -> NULL
END
*/

/* CASE
 EMPLOYEES 테이블에서
부서 ID가 50인 부서는 기존 급여에서 10% 삭감
부서ID가 80인 부서는 기존급여에서 10% 인상
나머지는 그대로인 컬럼을 하나 만들어서 조회해보자
*/
-- CASE 조건은 위부터 검사하고, TRUE가 뜨면 끝
-- 자바의 IF ELSE

SELECT FIRST_NAME 이름,
	DEPARTMENT_ID 부서,
	SALARY 기존급여,
	CASE 
		WHEN DEPARTMENT_ID = 50 THEN SALARY * 0.9
		WHEN DEPARTMENT_ID = 80 THEN SALARY * 1.1
		ELSE SALARY
	END 조정급여
FROM EMPLOYEES;


SELECT FIRST_NAME 이름,
	DEPARTMENT_ID 부서,
	SALARY 기존급여,
	CASE DEPARTMENT_ID 
		WHEN 50 THEN SALARY * 0.9
		WHEN 80 THEN SALARY * 1.1
		ELSE SALARY
	END 조정급여
FROM EMPLOYEES;

--실습
/*
EMP테이블에서 사원들의 번호, 이름, 급여와
최종 급여 컬럼을 같이 조회한다.
최종 급여는 커미션(COMM)이 존재하면 봉급과 더하고
커미션이 존재하지 않는다면 100을 더해준다.
조회 결과는 최종급여 오름차순으로 정렬한다
*/

SELECT * FROM EMP;


SELECT EMPNO 사번, 
	ENAME 이름, 
	SAL 급여,
	COMM,
	CASE 
		WHEN COMM IS NOT NULL THEN SAL + COMM
		ELSE SAL + 100
	END 최종급여
FROM EMP
ORDER BY 최종급여;

/*
실습
EMP 테이블의 사원정보를 가져온다
이때 SAL가 높은순으로 정렬하고 비고 컬럼을 만든다.
비고 컬럼에는 급여 순위가 1~5등이면 상
6~10등이면 중
나머지는 하를 넣는다.
*/

SELECT ROWNUM, E.* ,
   CASE
      WHEN ROWNUM BETWEEN 1 AND 5 THEN '상'
      WHEN ROWNUM BETWEEN 6 AND 10 THEN '중'
      ELSE '하'
   END 등급
FROM (
   SELECT *
   FROM EMP
   ORDER BY SAL DESC
) E;


/*
EMP테이블의 사원들의 사원번호, 이름, 부서번호, 급여, 지역을 조회한다
이때 영업부서는(SALES)급여를 30%인상
RESERCH부서는(SALES)급여를 20% 인상하여 조회한다.
 */
SELECT * FROM EMP;
--서브쿼리 내부에서 JOIN을 사용하면 같은 컬럼명을 별칭으로 각각뽑을 수 없다.
-- 서브쿼리의 SELECT 에 원하는 컬럼만 직접 명시해서 조회하거나 따로 조회하여 별칭을 주고 가져와야 함

SELECT D.DEPTNO 부서번호, D.*, E.* 
FROM DEPT D JOIN EMP E
ON D.DEPTNO = E.DEPTNO;

SELECT EMPNO, ENAME, 부서번호,
   CASE DNAME
      WHEN 'SALES' THEN SAL * 1.3
      WHEN 'RESEARCH' THEN SAL * 1.2
      ELSE SAL
   END 급여,
   LOC
FROM 
(
   SELECT D.DEPTNO 부서번호, D.*, E.* 
   FROM DEPT D JOIN EMP E
   ON D.DEPTNO = E.DEPTNO
);

--===========================================================================================
--JDBC 
--   자바프로그램에서 데이터베이스를 표준화된 방법으로 접속할 수 있도록 만든 API
--   자바와 외부 데이터베이스 간의 연결을 지원한다.
--
--   각 기종들 마다 드라이버를 제공해주고 있음.
--   즉 자바에서 DBMS를 바꿀 때는 이 드라이버만 바꾸고 별도의 코드 수정없이 동작하게끔 지원한다.
--
--JDBC 프로그래밍 순서
--   1. JDBC 드라이버 로딩
--   2. 연결관리를 할 수 있는 객체 - Connection
--   3. 쿼리 실행을 위한 객체 - PreparedStatement, Statement
--   4. 쿼리 실행
--   5. 결과 확인 - select / ResultSet, insert, delete, update / int
--   6. ResultSet 종료
--   7. PreparedStatement or Statement 종료
--   8. Connection 종료