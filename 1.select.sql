-- 1.select.sql

-- 검색(질의) : select(query)

-- 표기법 : oracle db의 주석

/* 오라클 db의 블록 주석 표기법
1. 검색 syntax
	select절  검색컬럼명, 검색컬럼명2, ...
	from절 table명;

2. 1 + 정렬(order by)
	select절
	from절
	order by절

	from절 -> select절 -> order by절 순으로 실행 

3. 1 + 조건절
	select절 
	from절 
	where절 

	from절 -> where절 -> select절 
*/

		  
--1. sqlplus창 보기 화면 여백 조절 편집 명령어
	-- 단순 sqlplus tool만의 편집 명령어
	-- 영구 저장 안됨. sqlplus 실행시마다 해 줘야 함
set linesize 200
set pagesize 200


--2. 해당 계정의 모든 table 목록 검색
select * from tab;


--3. emp table의 모든 정보 검색
select * from emp;


--4. emp table의 구조 검색[묘사]
-- 컬러명과 데이터 타입 확인하는 명령어
desc emp;


--5. emp table의 사번(empno)과 이름(ename)만 검색
select empno, ename from emp;

--6. emp table의 입사일(hiredate) 검색
/* 검색된 결과가 yy/mm/dd 형식으로 검색*/
select hiredate from emp;
	
--7. emp table의 검색시 칼럼명 empno를 사번이란 별칭으로 검색 
select empno as 사번 from emp;
select empno 사번 from emp;



--8. emp table에서 부서번호(deptno) 검색시 중복 데이터 제거후 검색 
-- 중복 데이터 제거 : distinct
select distinct deptno from emp;


--9. 데이터를 오름차순(asc)으로 검색하기(순서 정렬)
-- order by절로 정렬 표현
-- 오름차순 : asc / 내림차순 : desc
select distinct deptno from emp order by deptno asc;

-- ? 데이터를 내림차순(desc)으로 검색하기(순서 정렬)
select distinct deptno from emp order by deptno desc;


-- ? 사번(empno)을 오름차순(order by asc)으로 정렬 해서 사번만 검색
select empno from emp order by empno asc;


-- 10.emp table 에서 deptno 내림차순(desc) 정렬(order by) 적용해서 ename과 deptno 검색하기
select ename, deptno from emp order by deptno desc;


--? 10번 문제 + ename은 오름차순 정렬 추가해서 검색 
select ename, deptno from emp order by deptno desc, ename asc;


--? empno와 deptno를 검색하되 단 deptno는 오름차순(asc) 검색
-- 정수 데이터 정렬 
select empno, deptno from emp order by deptno asc; 


-- 11. 입사일(date 타입의 hiredate) 검색, 
-- date 타입은 정렬가능 따라서 
-- 경력자(입사일이 오래된 직원)부터 검색(asc)
select hiredate from emp order by hiredate asc;




-- *** 연산식 ***
--12. emp table의 모든 직원명(ename), 월급여(sal), 연봉(sal*12) 검색
-- 단 sal 컴럼값은 comm을 제외한 sal만으로 연봉 검색
select ename, sal, sal*12 as 연봉 from emp;



-- 13. 모든 직원의 연봉 검색(sal *12 + comm) 검색
select sal*12+comm from emp; --> comm(영업부 사원만 받는 보너스) 없는 직원의 연산 불가

select sal, comm from emp; -- 확인

-- 해결책 
/* 데이터가 미존재(널, null)는 0으로  대체해서 연산 
   필요한 로직 : null을 0으로 변경(nvl(널값컬럼, 치환값) 함수 제공)
		nvl - null value의 약어
		함수는 null값 보유한 컬럼명과 대체하고자 하는 값을 필요
*/
select comm, nvl(comm, 0) from emp; 

-- 답안
select sal*12 + nvl(comm, 0) from emp;
select sal*12 + nvl(comm, 0) as 연봉 from emp;


-- *** 조건식 ***
-- where 절

--14. 보너스 안받는[]=comm이 null(존재자체가 없는)인] 사원에 대한 검색(ename, comm)
select ename, comm from emp;


select ename, comm from emp where comm is null;


	
--15. comm이 null이 아닌 사원에 대한 검색(ename, comm)
	-- is not null

select ename, comm from emp where comm is not null;


/*
문법 오류
select ename, comm 
from emp
where comm not is null;*/


--16. ename, 전체연봉... comm 포함 연봉 검색
select ename, sal*12 + nvl(comm, 0) as 연봉 from emp;

--17. emp table에서 deptno 값이 20인(조건식 where) 
-- 직원 정보 모두(*) 출력하기  : = [sql 동등비교 연산자]

-- from -> where -> select 순으로 실행 

select * from emp where deptno=20;

--? 검색된 데이터의 sal 값이 내림차순으로 정렬(order by) 검색 
select empno, sal from emp order by sal desc;

select ename from emp;

-- 문자열 표현은 단일따옴표 
select deptno, ename from emp where ename='SMITH';

--19. sal가 900이상(>=)인 직원들의 이름(ename), sal 검색
select ename, sal from emp where sal >= 900;


--20. deptno가 10이고(and) job이 매니저인 사원이름 검색 
-- job 파악하기 : MANAGER 라는 대문자로 구성됨을 확인 
select job from emp;   

select ename, job from emp where deptno=10 and job='MANAGER';

select ename from emp where deptno=10 and job='MANAGER';



-- 21. ?deptno가 10이거나(or) job이 메니저(MANAGER)인 사원이름(ename) 검색
select ename, job, deptno from emp where deptno=10 or job='MANAGER';


-- 22. deptno가 10이 아닌 모든 사원명(ename) 검색
-- !=, <>, not 

select ename, deptno from emp where deptno != 10;

select ename, deptno from emp where deptno <> 10;


select ename, deptno from emp where not deptno = 10;


--23. sal이 2000 이하(sal<=2000)이거나(or) 3000이상인(sal>=3000)
-- 사원명(ename) 검색
select ename, sal from emp where sal <= 2000 or sal >= 3000;



--24. comm이 300 or 500 or 1400인 사원명, comm 검색
-- in ( 300, 500, 1400)
select ename, comm from emp;


select ename, comm from emp where comm in (300, 500, 1400);
	

--25. ?comm이 300 or 500 or 1400이 아닌(not) 사원명, comm 검색
select ename, comm from emp where comm not in (300, 500, 1400);


select ename, comm from emp where not comm in (300, 500, 1400);


-- 26. 81년도에 입사(hiredate)한 사원 이름(ename) 검색
-- 포함된 범위 연산자 : date 타입도 단일 따옴표 표현, 연산식 적용 가능

select ename, hiredate from emp;

-- 81년도 : 81년 1월 1일 ~ 81년 12월 31
-- yy/mm/dd 포멧이 비교가 가능

select ename, hiredate from emp where hiredate='80/12/17';

select ename, hiredate from emp where hiredate between '81/01/01' and '81/12/31';



-- 27. ename이 M으로 시작되는 모든 사원번호(empno), 이름(ename) 검색  
-- 연산자 like : 한 음절 _ , 음절 개수 무관하게 검색할 경우 %
select empno, ename from emp where ename like 'M%';

-- 28. ename이 M으로 시작되는 전체 자리수가 두음절의 사원번호, 이름 검색
select empno, ename from emp where ename like 'M_';

-- 29. 두번째 음절의 단어가 M인 모든 사원명 검색 
select empno, ename from emp where ename like '_M%';

-- 30. 단어가 M을 포함한 모든 사원명 검색 
select empno, ename from emp where ename like '%M%';


