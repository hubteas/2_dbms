/*정규화
정규화
   - 삽입/수정/삭제의 이상현상을 제거하기 위한 작업
   - 데이터의 중복을 최소화하는 데에 목적이 있다.
   - 6차 정규화까지 있으나, 3차 정규화까지만 진행한다.

1차 정규화
   - 같은 성격과 내용의 컬럼이 연속적으로 나타날 경우
   상품명
   바지1, 바지2, 바지3

   상품명1   상품명2   상품명3
   바지1   바지2   바지3

   상품명
   바지1
   바지2
   바지3

2차 정규화
   조합키(복합키)로 구성되었을 경우 조합키의 일부분에만 종속되는 속성이 있을 경우

   과자
   이름PK   맛PK   가격   제조사
   포카칩   오리지날   1500   오리온
   포카칩   양파맛   1700   오리온
   포스틱   오리지널   1000   농심
   포스틱   감자맛   1200   농심

   ※ 제조사 컬럼은 이름 컬럼만 알고 있어도, 알 수 있기에 2차 정규화에 대상이된다.
   제조사 컬럼이 조합키의 일부분에만 종속된다.

   과자
   이름PKFK   맛PK   가격
   포카칩   오리지날   1500
   포카칩   양파맛   1700
   포스틱   오리지널   1000
   포스틱   감자맛   1200

   과자_제조사
   이름PK   제조사
   포카칩   오리온
   포스틱    농심

3차 정규화
   PK가 아닌 컬럼이 다른 컬럼을 결정하는 경우
   
   회원번호   이름   시   구   동   우편번호
   1   류호근   서울시   관악구   신림동   11111
   2   홍길동   수원시   장안구   조원동   22222

   - 이행함수를 제거하자!

   - 3차 정규화 진행
   회원번호   이름   우편번호
   
   우편번호   시   구   동
   

데이터베이스에 정규화가 필요한 이유
   데이터베이스를 잘못 설계하면 불필요한 데이터 중복으로 인해 공간이 낭비된다.
   그리고 삽입/수정/삭제에 관한 이상현상이 일어난다.

박살난 테이블 -> 직원 테이블
   직원번호PK   이름   부서   프로젝트코드PK1   급여   부서별 명수
   1111   홍길동   개발팀   ABCD1111   3000   4
   1111   홍길동   개발팀   EFGH1111   2000   4
   1111   홍길동   개발팀   NAVER123   3500   4
   3333   이유리   기획팀   ABCD1111   5000   2
   4444   박웅이   디자인팀   QWER1234   6000   3

이상현상의 종류
   - 삽입 이상
      새로운 데이터를 삽입하기 위해 불필요한 데이터도 삽입해야하는 문제
      담당 프로젝트가 정해지지 않은 사원이 있다면
      프로젝트 코드에 NULL을 작성할 수 없으므로 이 사원은 테이블에 추가될 수 없다.
      따라서 '미정'이라는 프로젝트 코드를 따로 만들어서 삽입해야 한다.

   - 갱신 이상
      중복 행 중에서 일부만 변경하여 데이터가 불일치하게 되는 모순의 문제
      한 명의 사원은 반드시 하나의 부서에만 속할 수 있다.
      만약 홍길동 이 기획팀으로 부서를 옮길 시 3개 모두 갱신해주지 않는다면
      개발팀인지 기획팀인지 알 수 없다.

   - 삭제 이상
      행을 삭제했을 때 필요한 데이터도 같이 삭제되는 문제
      박웅이 담당한 프로젝트를 박살내서 드랍된다면 박웅이 행을 모두 삭제하게 된다.
      따라서 프로젝트에서 드랍되면 정보를 모두 드랍하게 된다.

- 2차 정규화 진행
   회원번호 컬럼에만 종속되는 이름, 부서라는 컬럼이 있기에, 2차 정규화를 진행!

   직원번호PKFK   프로젝트코드PK   급여   
   1111      ABCD1111   3000   
   1111      EFGH1111   2000   
   1111      NAVER123   3500   
   3333      ABCD1111   5000   
   4444      QWER1234   6000   

   직원번호PK   이름   부서   부서별 명수
   1111   홍길동   개발팀   4
   3333   이유리   기획팀   2
   4444   박웅이   디자인팀   3
   5555   류호근   개발팀   4

- 3차 정규화 진행
   직원 테이블에서 PK가 아닌 부서컬럼이 부서별 명수를 결정하고 있다.

   직원번호PK   이름   부서FK   
   1111   홍길동   1   
   3333   이유리   2   
   4444   박웅이   3   
   5555   류호근   1   

   부서번호PK   부서이름   부서별 명수
   1   개발팀   4
   2   기획팀   2
   3   디자인팀   3

   - 이 테이블은 그대로!
   직원번호PKFK   프로젝트코드PK   급여   
   1111      ABCD1111   3000   
   1111      EFGH1111   2000   
   1111      NAVER123   3500   
   3333      ABCD1111   5000   
   4444      QWER1234   6000   

	
*/

SELECT * FROM PLAYER;
SELECT * FROM TEAM;
SELECT * FROM STADIUM;




-- PLAYER 테이블에서 WEIGHT가 70이상이고 80이하인 선수 검색
SELECT PLAYER_NAME, WEIGHT
FROM PLAYER
WHERE WEIGHT BETWEEN 70 AND 80;
-- PLAYER 테이블에서 TEAM_ID가 K03 이고 HEIGHT가 180미만인 선수 검색
SELECT PLAYER_NAME, TEAM_ID, HEIGHT 
FROM PLAYER
WHERE TEAM_ID = 'K03' AND HEIGHT < 180;
-- PLAYER 테이블에서 TEAM_ID가 K06 이고 NICKNAME이 제리인 선수 검색
SELECT PLAYER_NAME, TEAM_ID, NICKNAME
FROM PLAYER
WHERE TEAM_ID = 'K06' AND NICKNAME = '제리';
-- PLAYER 테이블에서 HEIGHT가 170이상이고 WEIGHT가 80이상인 선수 이름 검색
SELECT PLAYER_NAME, HEIGHT, WEIGHT
FROM PLAYER
WHERE HEIGHT >=170 AND WEIGHT  >= 80;
-- PLAYER 테이블에서 TEAM_ID가 K02 이거나 K07 이고 포지션은 MF인 선수 검색
SELECT PLAYER_NAME, TEAM_ID , "POSITION"
FROM PLAYER
WHERE (TEAM_ID = 'K02' OR TEAM_ID= 'K07') AND "POSITION" = 'MF';
-- STADIUM 테이블에서 SEAT_COUNT가 30000 초과 이고 41000 이하 인 경기장 검색
SELECT STADIUM_NAME
FROM STADIUM
WHERE SEAT_COUNT > 30000 AND SEAT_COUNT <= 41000;

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

	




























