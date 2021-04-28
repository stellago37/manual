-- 3.selectFunction.sql
-- 단일행 함수 : 입력 데이터 수만큼 출력 데이터
/* Oracle Db 자체적인 지원 내장 함수 다수 존재

1. 숫자 함수
2. 문자 함수
3. 날짜 함수 
4. ... */

-- 오라클 dummy table 검색
-- dual table : 산술 연산 결과등을 확인하기 위한 임시 table
select * from dual;
select 2+3 from dual;

-- sysdate : 시스템 현 시간 파악 가능한 오라클 자체 속성
-- date 타입 : date 타입도 연산식 적용 가능
select sysdate from dual;
select sysdate-1 as 어제날짜 from dual;



-- *** [숫자함수] ***
-- 1. 절대값 구하는 함수 : abs()
select -10, abs(-10) from dual;


-- 2. 반올림 구하는 함수 : round(데이터 [, 반올림자릿수])
 select 5.6, round(5.6) from dual;


-- 3. 지정한 자리수 이하 버리는 함수 : trunc()
-- trunc(데이터, 자릿수)
-- 자릿수 : +(소수점 이하), -(정수 의미)
-- 참고 : 존재하는 table의 데이터만 삭제시 방법 : delete[복원]/truncate[복원불가]
select 5.6, round(5.6), trunc(5.6) from dual;
  

-- 4. 나누고 난 나머지 값 연산 함수 : mod()
-- 모듈러스 연산자, % 표기로 연산, 오라클에선 mod() 함수명 사용
select mod(7, 2) from dual;


-- 5. ? emp table에서 사번(empno)이 홀수인 사원의 이름(ename), 사번(empno) 검색 
select ename, empno from emp where mod(empno, 2) = 1;

select ename, empno from emp where mod(empno, 2) != 0;

/* -- art
select empno, ename from emp where empno in (%1, %3, %5, %7, %9); */

--6. 제곱수 구하는 함수 : power()
select power(3, 2) from dual;

-- *** [문자함수] ***
/* 영어 대소문자 의미하는 단어들
대문자 : upper
소문자 : lower
철자 : case 
*/
-- 1. 대문자로 변화시키는 함수
-- upper() : 대문자[uppercase]
-- lower() : 소문자[lowercase]
select ename from emp;
select lower(ename) from emp;

--2. ? manager로 job 칼럼과 뜻이 일치되는 사원의 사원명 검색하기 
select job from emp;
-- 존재하는 데이터를 소문자로 변경해서 검색, 
select job from emp;
select lower(job) from emp;

select ename, job from emp where lower(job) = 'manager';


-- 검색으로 유입된 manager라는 단어를 대문자로 변경해서 검색?
-- 실행속도가 유입된 문자열 하나만 변경하는게 더 효과적
select ename, job from emp where job = upper('manager');


--3. 문자열 길이 체크함수 : length()
-- 참고 사항 : oracle xe 버전은 단순 교육용 버전만
-- 한글은 정석은 2byte(16bit) 소진, xe 버전은 3byte 소진
-- java에서도 한글 한 철자는 2byte 즉 char 타입으로 처리
--4. byte 수 체크 함수 : lengthb()
 select length('가'), length('A'), lengthb('가') from dual;


--5. 문자열 일부 추출 함수 : substr()
-- 서브스트링 : 하나의 문자열에서 일부 언어 발췌하는 로직의 표현
-- *** 자바스크립트, 파이썬, 자바에서의 문자열 index(각음절의 위치 순서)는 0부터 시작, sql에선 1부터 시작



/* 참고
1. java는 문자열 index로 표현시 0부터 절대적으로 시작
2. oracle db 11xe의 문자열, date 타입의 index 표현시 0과 1을 같다고 간주
   - 에러 발생은 아님 
*/
-- substr(데이터, 시작위치, 추출할개수)
-- '엔코아 플레이데이터' 문자열에서 '플레이데이터'만 착출하기
select '엔코아 플레이데이터' from dual;
select substr('엔코아 플레이데이터', 0, 1) from dual;


--6. ? 년도 구분없이 2월에 입사한 사원이름(ename), 입사일(hiredate) 검색
-- date 타입에도 substr() 함수 사용 가능 
select hiredate from emp;
select ename, hiredate
from emp
where substr(hiredate,4,2)='02';



--7. 문자열 앞뒤의 잉여 여백 제거 함수 : trim()
/*length(trim(' abc ')) 실행 순서
   ' abc ' 문자열에 디비에 생성
   trim() 호출해서 잉여 여백제거
   trim() 결과값으로 length() 실행 */

select length(trim(' abc ')) from dual;



--8. ?emp table에서 두번째 철자가 I인 사원들 검색하기 
-- 김연식님 작품
select ename
from emp
where ename like '_I%';

select ename from emp where substr(ename, 2, 1)='I';



-- *** [날짜 함수] ***
--1. ?어제, 오늘, 내일 날짜 검색 
-- 현재 시스템 날짜에 대한 정보 제공 속성 : sysdate

/* 논리적인 오류가 있는 문장 
 emp가 보유하고 있는 row수 만큼 검색
 emp table의 데이터와 연관없는 것들은 emp table 사용 금지 */
select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from emp;


select sysdate-1 어제, sysdate 오늘, sysdate+1 내일 from dual;


--2.?emp table에서 근무일수 계산하기, 사번과 근무일수(반올림) 검색
select empno, round(sysdate-hiredate) as 근무일수 from emp;



--3. 특정 개월수 더하는 함수 : add_months(기준데이터, 더해지는개월수)
-- 6개월 이후 검색 
select sysdate, add_months(sysdate, 6) from dual; 


--4. ? 입사일 이후 3개월 지난 일수 검색
select hiredate, add_months(hiredate, 3) from emp;


--5. 두 날짜 사이의 개월수 검색 : months_between()
-- 오늘(sysdate) 기준으로 2016-09-19
select months_between(sysdate, '2016-09-19') from dual;



--6. 요일을 기준으로 특정 날짜 검색 : next_day()
/* os 운영체제도 한글 사용하기 때문에 토요일 이라는 데이터로 검색 */
select next_day(sysdate, '토요일') from dual;


--7. 주어진 날짜를 기준으로 해당 달의 가장 마지막 날짜 : last_day()
select last_day(sysdate) from dual;


--8.? 2020년 2월의 마지막 날짜는?
/* 주의 사항 
   yy/mm/dd or yyyy/mm/dd 일반적인 날짜 표현 포멧
   tip : yy/mm 으로만 처리하고자 할 경우엔 함수등을 통해서 가공 후에 작업 해야 함
*/
-- 에러 select last_day('2020-02') from dual;
 select last_day('2020-02-01') from dual;
select last_day('2020/02/01') from dual;
select last_day('20/02/01') from dual;


-- *** [형변환 함수] ***
-- 사용 빈도가 높음
--[1] to_char() : 날짜 -> 문자, 숫자 -> 문자
	-- to_char(날자데이타, '희망포멧문자열')
--[2] to_date() : 날짜로 변경 시키는 함수
--[3] to_number() : 문자열을 숫자로 변환



-- [1] to_char()
--1. 오늘 날짜를 'yyyy-mm-dd' 변환 : 
select to_char(sysdate, 'yyyy/mm/dd') from dual;

select to_char(sysdate, 'yyyy-mm-dd') from dual;

--dy는 요일 의미
select to_char(sysdate, 'yyyy-mm-dd dy') from dual;

-- hh:mi:ss = 12시간을 기준으로 시분초
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss') from dual;

-- hh24:mi:ss = 24시간을 기준으로 시분초
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;

-- hh:mi:ss am = am과 pm은 오전 오후 의미, am을 주로 사용 
select to_char(sysdate, 'yyyy-mm-dd hh:mi:ss am') from dual;


--? 2.날짜(sysdate)의 round(), trunc()
-- 날짜의 round() : 정오를 기준으로 이 시간 초과시 무조건 다음 날짜
--			   : 가령 12까지를 원서 접수 또는 택배마감등
-- 날짜의 trunc() : 24시간 내의 모든 내용 당일 처리
select sysdate, round(sysdate), trunc(sysdate) from dual;


-- 3. 숫자를 문자형으로 변환 : to_char()
--1. 숫자를 원하는 형식으로 변환 검색
-- 9 : 실제 데이터의 유효한 자릿수 숫자 의미(자릿수 채우지 않음)
-- 0 :	 "		(자릿수 채움)
-- . : 소수점 표현
-- , : 원단위 표현
-- $ : 달러 
-- L or l : 로케일의 줄임말(os 자체의 인코딩 기본 정보로 해당 언어의 기본 통화표현)
select to_char(1234, '9999.99') from dual;
select to_char(1234, '$9999,99') from dual;
select to_char(1234, '9999') from dual;
select to_char(1234, '999,999') from dual;
select to_char(1234, '99999') from dual;
select to_char(1234, '00000') from dual;
select to_char(1234, 'L99,999') from dual;
select to_char(1234, 'l99,999') from dual;

 

--[2] to_date() : 날짜로 변경 시키는 함수

--1. 올해 며칠이 지났는지 검색(포멧 yyyy/mm/dd)
select sysdate - 20200719 from dual;



--2. 문자열로 date타입 검색 가능[데이터값 표현이 유연함]
-- 1980년 12월 17일 입사한 직원명 검색
select ename from emp where hiredate='1980/12/17';
select ename from emp where hiredate='80/12/17';
select ename from emp where hiredate='1980-12-17';


-- [3] to_number() : 문자열을 숫자로 변환
--1. '20,000'의 데이터에서 '10,000' 문자열의 값을 산술 연산하기 
-- 힌트 - 9 : 실제 데이터의 유효한 자릿수 숫자 의미(자릿수 채우지 않음)
-- ?
select to_number('20,000', '99,999') - to_number('10,000', '99,999') from dual;



-- *** 조건식 함수 ***
-- decode()-if or switch문과 같은 함수 ***
-- decode(조건칼럼, 조건값1,  출력데이터1,
--			   조건값2,  출력데이터2,
--				...,
--			   default값) from table명;

--1. deptno 에 따른 출력 데이터
select * 
from dept;

-- 10번 부서인 경우 A등급, 20번 부서는 B등급, 나머지는 C등급으로 출력
select deptno, decode(deptno, 10, 'A등급',
                              20, 'B등급',
                              'C등급') 
from dept;


--2. emp table의 연봉(sal) 인상계산
-- job이 ANALYST 5%인상(sal*1.05), SALESMAN 은 10%(sal*1.1) 인상, MANAGER는 15%(sal*1.15), CLERK 20%(sal*1.2) 이상 
select ename, sal, decode(job, 'ANALYST', sal*1.05,
                               'SALESMAN', sal*1.1,
                               'MANAGER', sal*1.15,
                               'CLERK', sal*1.2,
                                sal)  as 인상분
from emp;



--3. 'MANAGER'인 직군은 '갑', 'ANALYST' 직군은 '을', 나머지는 '병'으로 검색
select ename, job, decode(job, 'MANAGER', '갑',
                               'ANALYST', '을',
                               '병') as 관계
from emp;                               



