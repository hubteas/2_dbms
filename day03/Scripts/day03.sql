SELECT * FROM EMPLOYEES;

--DUAL테이블 : 다른 테이블을 참조할 필요가 없이
-- 값을 확인하고 싶을 때 사용할 수 있는 테이블
-- (오라클에서 지원해준다.)
SELECT 10||20 AS RES
FROM DUAL;


-- 문자
-- 항상 작은 따옴표
-- 중간에 공백은 들어가지 않는다.
SELECT '츄파츕스'||'요거트'
FROM DUAL; --문자 연결 문자 -> 문자

-- 테이블을 이용해서 연결 연산자 실습.
SELECT FIRST_NAME||LAST_NAME AS 풀네임 
FROM EMPLOYEES;
-- 날짜 타입 + 문자 OR 숫자 -> 문자

SELECT HIRE_DATE||'에 취업' AS 취업일
FROM EMPLOYEES;

--실습
-- 사원의 이름과 메일 주소를 출력해라

SELECT FIRST_NAME ||' '||LAST_NAME AS 이름
	, EMAIL||'@gamil.com'메일주소
FROM EMPLOYEES;

--산술 연산자
--산술연산자는 피연산자로 문자가 올수 없다
SELECT 10*10
FROM dual;

-- 날짜 타입의 연산
SELECT HIRE_DATE , HIRE_DATE  + 12/24 -- +되는 날짜는 1 = 1일
FROM EMPLOYEES

--SYSDATE
--현재 날짜와 시간 정보를 가지고있으며
--오라클에서 제공해준다
SELECT SYSDATE 
FROM DUAL;

--날짜와 날짜의 연산은 뺄셈만 지원.
SELECT HIRE_DATE , SYSDATE ,
	SYSDATE - HIRE_DATE 
FROM EMPLOYEES;

SELECT 7576.839849537037037037037037037037037037/365
FROM DUAL;

SELECT SYSDATE ,
	SYSDATE + 0.5,
	SYSDATE - 12/24,
	SYSDATE -10/60/24 
FROM DUAL;


--===========================================================================
-- 관계 연산자,WHERE 절
-- 직원의 이름, 성, 봉급을 조회한다.
-- 단, 봉급이 10000이상인 직원종보만 조회
SELECT FIRST_NAME , LAST_NAME , SALARY 
FROM EMPLOYEES
WHERE SALARY >= 10000;
--해당조건이 TRUE 인 행만 가져온다.

--정렬도 추가!
SELECT FIRST_NAME , LAST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME  = 'David';

--================================================================
--SQL 실행순서
SELECT FIRST_NAME 성,		--3 원하는 컬럼을 조회
	LAST_NAME 이름,			--각 컬럼에 별칭을 부여	
	SALARY 봉급
FROM EMPLOYEES --1 EMPLOYEES 테이블에서!
WHERE SALARY >=10000 -- 2. 봉급이 10000이상인 데이터만 가져와라 SQL실행순서때문에 SALARY를 봉급으로 바꾸면 오류가 난다.
ORDER BY 봉급; -- 4. 봉급기준으로 오름차순 정렬
			-- SELECT절에서 별칭이 부여가 되어있는 상황!


--=============================================================================
--SQL 연산자
-- BETWEEN a AND b

-- 직원 테이블에서
-- 봉급이 10,000 이상, 12,000 이하인 직원의
-- 이름, 성, 봉급을 봉급 오름차순으로 조회

SELECT FIRST_NAME ,LAST_NAME ,SALARY 
FROM EMPLOYEES  
WHERE SALARY BETWEEN 10000 AND 12000
ORDER BY SALARY ;

SELECT FIRST_NAME ,LAST_NAME ,SALARY 
FROM EMPLOYEES  
WHERE SALARY IN(10000,11000,12000)
ORDER BY SALARY ;

-- LIKE
-- '%@': ~아무거나
-- '_@': 자릿수
-- '%e%' -> 그냥 e가 있으면 TRUE
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%e';

SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'D%';

SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%f%';

SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '____e'; -- e로 끝나는 단어의 자릿수(1자리 = 1_)

SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '%e%';

-- '%en%' -> en이 있으면 TRUE
-- '%e%n%'-> e와 n을 포함하면 TRUE(순서대로)
-- '%e_n%' -> e와 n 사이에 무조건 한글자가 더 있으면 TRUE

--=================================================================
--COMMITION_PCT에 NULL이 있는것 확인

--NULL을 이용한 연산의 결과는 항상 NULL
SELECT NULL + 10
FROM DUAL;

--직원 테이블에서
--할인률이 NULL인 직원의 이름과 성과 할인률을 조회

SELECT FIRST_NAME , LAST_NAME , COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

SELECT FIRST_NAME , LAST_NAME , COMMISSION_PCT 
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

--=================================================================
-- 논리연산자
-- 직원테이블에서 부서가 영업부서이면서, 봉급이 10000이상인 직원들의 이름, 성, 봉급, 부서ID를 봉급 오름차순으로 조회하기

SELECT FIRST_NAME , LAST_NAME , SALARY , DEPARTMENT_ID 
FROM EMPLOYEES
WHERE DEPARTMENT_ID =80 AND SALARY >= 10000
ORDER BY SALARY ASC;

--=================================================================
-- 논리연산자
-- 직원테이블에서 부서가 영업부서가 아니면서, 봉급이 10000이상인 직원들의 이름, 성, 봉급, 부서ID를 봉급 오름차순으로 조회하기

SELECT FIRST_NAME , LAST_NAME , SALARY , DEPARTMENT_ID 
FROM EMPLOYEES
WHERE NOT (DEPARTMENT_ID = 80) AND SALARY >= 10000
ORDER BY SALARY ASC;


SELECT FIRST_NAME , LAST_NAME , SALARY , DEPARTMENT_ID 
FROM EMPLOYEES
WHERE NOT DEPARTMENT_ID = 80 AND SALARY >= 10000
ORDER BY SALARY ASC;

