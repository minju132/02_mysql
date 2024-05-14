-- ddl (data definition language)

-- create
create table if not exists tb1(	-- if not exists는 없으면 만들고 있으면 넘어가라는 구문
	pk int primary key,	-- primary key는 식별키
	fk int,
	col1 varchar(255),	-- varchar는 문자형을 저장하는 변수명이고 한글은 2byte를 먹는다.
	check(col1 in('y', 'n'))	-- y 나 n 으로만 col1에 저장가능하다고 확인하는 구문
) engine = INNODB;

describe tb1;
insert into tb1 values(1, 10, 'y');
select * from tb1;

-- Alter
-- 테이블에 추가/변경/수정/삭제하는 모든 것을 alter 명령어를 사용해 적용한다.
-- 종류가 너무 많고 복잡하기 때문에 대표적인 것만 사용해볼 것이다.

-- column를 추가하는 경우
alter table tb1
add col2 int not null;
insert into tb1 values(1, 10, 'y', null);
describe tb1;
-- column를 삭제하는 경우
alter table tb1
drop column col2;
describe tb1;

-- 열 이름 및 데이터 형식 변경
alter table tb1
change column fk change_fk int not null;
describe tb1;

-- 테이블 다시 생성
create table if not exists tb2(	
	pk int primary key auto_increment,	
	fk int,
	col1 varchar(255),	
	check(col1 in('y', 'n'))	
) engine = INNODB;

describe tb2;
-- auto_increment가 걸려 있는 컬럼은 primary key 제거가 안되므로 auto_increment를 modify 명령어로 제거한다.
-- modify는 컬럼의 정의를 바꾸는 것이다.
alter table tb2
modify pk int;

-- 테이블의 primary key는 하나만 가질 수 있어 별도의 컬럼을 지정하지 않아도 primary 삭제가 가능하다.
alter table tb2
drop primary key;
describe tb2;

-- 테이블 삭제하기
create table if not exists tb3(	
	pk int primary key auto_increment,	
	fk int,
	col1 varchar(255),	
	check(col1 in('y', 'n'))	
) engine = INNODB;
create table if not exists tb4(	
	pk int primary key auto_increment,	
	fk int,
	col1 varchar(255),	
	check(col1 in('y', 'n'))	
) engine = INNODB;
create table if not exists tb5(	
	pk int primary key auto_increment,	
	fk int,
	col1 varchar(255),	
	check(col1 in('y', 'n'))	
) engine = INNODB;

drop table if exists tb3, tb4, tb5;
show tables;

-- truncate 확인하기위한 테이블 생성
create table if not exists tb3(	
	pk int primary key auto_increment,	
	fk int,
	col1 varchar(255),	
	check(col1 in('y', 'n'))	
) engine = INNODB
-- 데이터 insert
insert into tb3 values(null, 10, 'n');
insert into tb3 values(null, 10, 'n');
insert into tb3 values(null, 10, 'n');
insert into tb3 values(null, 10, 'n');

select * from tb3;
delete from tb3;
-- truncate
truncate tb3;
-- delete의 차이

-- Transaction
-- mysql은 기본적으로 commit이 자동으로 되므로 수동으로 조절하고 싶다면 autocommit 설정을 변경해야한다.
set autocommit = 1;
-- 또는
set autocommit = on;

-- autocommit 비활성화
set autocommit = 0;
-- 또는 
set autocommit = off;

-- 트랜잭션의 시작을 알림
start transaction;
select * from tbl_menu tm;

INSERT INTO tbl_menu VALUES (null, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 메뉴' WHERE menu_code = 5;
DELETE FROM tbl_menu WHERE menu_code = 7;

commit;
rollback;