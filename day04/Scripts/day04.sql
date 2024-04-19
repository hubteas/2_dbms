SELECT * FROM EMPLOYEES;

CREATE  TABLE TBL_MEMBER(
	MEMBER_NAME VARCHAR2(1000),
	MEMBER_AGE NUMBER
);


-- 컬럼이름을 직접 명시한INSERT
-- 내가 원하는 컬럼에 값만 넣을 수 있다.
-- 순서 중요!
INSERT INTO TBL_MEMBER (MEMBER_NAME, MEMBER_AGE)
VALUES ('류호근',22);

INSERT INTO TBL_MEMBER (MEMBER_NAME)
VALUES ('류호근');


-- 모든 컬럼에 값을 넣고 싶을때!

INSERT INTO TBL_MEMBER 
VALUES('김철수', 12);


--INSERT INTO TBL_MEMBER 
--VALUES(22, '김민수');
--SELECT * FROM TBL_MEMBER;

--========================================================================
--UPDATE
--이상태로 실행하면, 모든 행의 해당열을 전부 수정.
UPDATE TBL_MEMBER
SET MEMBER_AGE = 49;

SELECT * FROM TBL_MEMBER;

--WHERE 을 사용해서, 원하는 행의 컬럼만 수정 가능

UPDATE TBL_MEMBER 
SET MEMBER_AGE = 22 -- 대입 연산자
WHERE MEMBER_NAME = '류호근'; --비교 연산자

--==========================================================================
--DELETE
DELETE FROM TBL_MEMBER
WHERE MEMBER_AGE = 49;

SELECT * FROM TBL_MEMBER;

--======================================================================
CREATE TABLE TBL_STUDENT(
	STUDENT_NUMBER NUMBER,
	STUDENT_NAME VARCHAR2(1000),
	STUDENT_MATH NUMBER,
	STUDENT_ENG NUMBER,
	STUDENT_KOR NUMBER,
	STUDENT_GRADE VARCHAR2(1000)
);

SELECT * FROM TBL_STUDENT;

INSERT INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES (1,'김철수', 90, 90, 90);
INSERT INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES (2,'홍길동', 70, 25, 55);
INSERT INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES (3,'이유리', 89, 91, 77);
INSERT INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES (4,'김웅이', 48, 100, 92);
INSERT INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
VALUES (5,'신짱구', 22, 13, 9);

--다중 INSERT 해보려고 삭제 다함.
DELETE FROM TBL_STUDENT;

SELECT * FROM TBL_STUDENT;

--한번에 데이터 다넣기(다중INSERT)
INSERT ALL 
   INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
   VALUES (1, '김철수', 90, 90, 90)
   INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
   VALUES (2, '홍길동', 70, 25, 55)
   INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
   VALUES (3, '이유리', 89, 91, 77)
   INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
   VALUES (4, '김웅이', 48, 100, 92)
   INTO TBL_STUDENT (STUDENT_NUMBER, STUDENT_NAME, STUDENT_MATH, STUDENT_ENG, STUDENT_KOR)
   VALUES (5, '신짱구', 22, 13, 9)
SELECT *
FROM DUAL;

SELECT * FROM TBL_STUDENT;


/*
[실습]
학점이 잘 들어갔는지 확인하기 위해서
학생 번호, 이름, 평균, 학점 조회하기 (별칭 넣기)
*/
-- 소수점 자르기
-- ROUND(값, 자릿수)

SELECT STUDENT_NAME 이름, (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)평균점수
FROM TBL_STUDENT;

SELECT STUDENT_NAME 이름, 
   ROUND((STUDENT_MATH + STUDENT_ENG + STUDENT_KOR) / 3, 2)평균점수
FROM TBL_STUDENT;

/*
[실습]
학생의 평균점수를 구하고 학점을 수정하기
A : 90점 이상
B : 80점 이상 90점 미만
C : 50점 이상 80점 미만
F : 50점 미만
*/

UPDATE TBL_STUDENT 
SET STUDENT_GRADE = 'A'
WHERE (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 >= 90;
UPDATE TBL_STUDENT 
SET STUDENT_GRADE = 'B'
WHERE (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 >= 80 AND (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 < 90;
UPDATE TBL_STUDENT 
SET STUDENT_GRADE = 'C'
WHERE (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 >= 50 AND (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 < 80;
UPDATE TBL_STUDENT 
SET STUDENT_GRADE = 'F'
WHERE (STUDENT_MATH + STUDENT_ENG + STUDENT_KOR)/3 < 50;

SELECT * FROM TBL_STUDENT;

SELECT STUDENT_NUMBER 학생번호, STUDENT_NAME 이름, ROUND((STUDENT_MATH + STUDENT_ENG + STUDENT_KOR) / 3, 2) 평균, STUDENT_GRADE 학점
FROM TBL_STUDENT; 


/*
학생의 수학, 영어, 국어 점수 중 한 과목이라도 50점 미만이 아니고
학점이 B이상인 학생만 학생 번호, 이름, 학점 출력하기
 */

SELECT STUDENT_NUMBER 번호, STUDENT_NAME 이름, STUDENT_GRADE 학점
FROM TBL_STUDENT
WHERE NOT (STUDENT_MATH < 50 OR STUDENT_ENG < 50 OR STUDENT_KOR < 50)
AND (STUDENT_GRADE = 'B' OR STUDENT_GRADE = 'A')        ;
SELECT * FROM TBL_STUDENT;

--AND 가 OR보다 우선 순위가 더 높다.
-- 그렇기 때문에 제일 뒤에 학점 OR은 최우선 연산으로 묶어줘야 원하는 값을 얻을 수 있다.

/*
학생의 수학, 영어, 국어 점수 중
한 과목이라도 30점 미만이면 퇴학시키기(삭제) 
 */

DELETE FROM TBL_STUDENT
WHERE STUDENT_MATH < 30 OR STUDENT_ENG < 30 OR STUDENT_KOR < 30;
SELECT * FROM TBL_STUDENT;


--=======================================================================
/*제약조건
1. PK : 고유한 값이며  각 행의 구분점으로 사용된다.
		중복이 없고 NULL값을 허용하지 않는다.
2. FK : 다른 테이블의 PK를 사용하며 중복이 가능하다.
        보통 테이블끼리 관계를 맺을 때 사용한다.
        NULL을 허용한다.
3. UK : NULL은 허용하지만 중복을 허용하지 않는다.
4. NOT NULL : NULL을 허용하지 않는다.
*/

--=======================================================================
/*
 DDL 
 
 1. CREATE : 테이블 생성
 	CREATE TABEL 테이블명 (
 		컬럼명 자료형 [제약조건],
 		...
 	);
 2. DROP : 테이블 삭제
 	DROP TABLE 테이블명;
 	
 3. ALTER : 테이블 수정
 	 	ALTER TABLE 테이블명
 	
 	- 테이블명 수정 : RENAME TO 새로운 테이블명;
 	- 컬럼추가 : ADD(컬럼명 자료형(용량));
 	- 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 새 컬럼명;
 	- 컬럼 삭제 : DROP COLUMN 기존 컬럼명;
 	- 컬럼 타입 수정 : MODIFY(컬럼명 자료형(용량));
 	- 제약조건 추가 : ADD CONSTRAINT [이름] 제약조건 
 	- 제약조건 삭제 : DROP CONSTRAINT 이름;
 	

 4. TRUNCATE : 테이블 내용 전체 삭제
 	TRUNCATE TABLE 테이블명;
 */

