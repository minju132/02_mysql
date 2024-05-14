-- constraints
-- 제약 조건 이해하기

-- 제약조건
-- 테이블 작성 시 가 컬럼에 값 기록에 대한 제약조건을 설정할 수 있다.
-- 데이터 무결성 보장을 목적으로 함
-- 입력/수정

-- not null
drop table if exists user_notnull;
create table if not exists user_notnull(
	user_no1 int not null,
	user_id varchar(255) not null,
	user_pwd varchar(255) not null,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255) not null,
	email varchar(255)
)engine=innodb;

insert into user_notnull(
	user_no1, user_id, user_pwd, user_name, gender, phone, email)
values
(1, 'use01','pass01', '홍길동', '남', '010-1234-1234', 'hong123@gmail.com'),
(2, 'use02','pass02', '유관순', '여', '010-1234-1234', 'U123@gmail.com');
select * from user_notnull;

-- not null 제약조건
insert into user_notnull(	-- phone 자리도 입력도 없어서 오류남
	user_no1, user_id, user_pwd, user_name, gender, email)
values
(1, 'use01','pass01', '홍길동', '남', 'hong123@gmail.com');
select * from user_notnull;

-- unique 중복을 허용하지 않는다
drop table if exists user_unique;
create table if not exists user_unique(
	user_no int not null unique,
	user_id varchar(255) not null,
	user_pwd varchar(255) not null,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255) not null,
	email varchar(255)
)engine=innodb;

insert into user_unique(	-- 두 번 실행하면 오류남
	user_no, user_id, user_pwd, user_name, gender, phone, email)
values
(1, 'use01','pass01', '홍길동', '남', '010-1234-1234', 'hong123@gmail.com');
select * from user_unique;

-- primary key
-- 테이블에서 한 행의 정보를 찾기 위해서 사용할 컬럼을 의미한다.
-- 테이블에 대한 식별자 역할을 한다(한 행씩 구분하는 역할을 한다.)
-- not null + unique 제약조건의 의미
-- 한 테이블 한 개만 설정할 수 있음
-- 컬럼 레벨, 테이블 레벨 둘 다 설정 가능함
-- 한 개 컬럼에 설정할 수도 있고, 여러 개의 걸럼을 묶어서 설정할 수도 있다.(복합키)

drop table if exists user_primarykey;
create table if not exists user_primarykey(
	user_no1 int primary key,
	user_id varchar(255) not null,
	user_pwd varchar(255) not null,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255) not null,
	email varchar(255)
)engine=innodb;

insert into user_primarykey(
	user_no1, user_id, user_pwd, user_name, gender, phone, email)
values
(1, 'use01','pass01', '홍길동', '남', '010-1234-1234', 'hong123@gmail.com'),
(2, 'use02','pass02', '유관순', '여', '010-1234-1234', 'U123@gmail.com');
insert into user_primarykey(
	user_no1, user_id, user_pwd, user_name, gender, phone, email)
values
(3, 'use03','pass03', '잉', '남', '010-1234-1234', 'hong123@gmail.com');
select * from user_primarykey;

insert into user_primarykey(	-- primary key는 not null과 unique 제약조건을 갖는다.
	user_id, user_pwd, user_name, gender, phone, email)
values
('use03','pass03', '잉', '남', '010-1234-1234', 'hong123@gmail.com');
select * from user_primarykey;

-- foreign key
-- 참조(references)된 다른 테이블에서 제공하는 값만 사요이할 수 있음
-- 참조 무결성을 위해하지않기 위해 사용
-- foreign key 제약조건에 의해서
-- 테이블 간의 관계(relationship)이 형성됨
-- 제공되는 값 외에는 null을 사용할 수 있음
drop table if exists user_grade;
create table if not exists user_grade(
	grade_code int primary key,
	grade_name varchar(255) not null
)engine=innodb;
insert into user_grade
values
(10,'보통강사'),
(20,'만족강사'),
(30,'매우만족강사');
select * from user_grade;

drop table if exists instructor_foreignkey;
create table if not exists instructor_foreignkey(
	user_no int primary key,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255),
	grade_code int,
	-- grade_name varchar(255),
	foreign key(grade_code) references user_grade(grade_code)
)engine=innodb;

select * from instructor_foreignkey;

select 
	i.user_name,
	u.grade_name
  from instructor_foreignkey i
  join user_grade u on i.grade_code = u.grade_code;

insert into instructor_foreignkey
values (1, '왕강사', '남', '010-2323-2323', 30);

-- on update set null, on delete set null
create table if not exists instructor_foreignkey2(
	user_no int primary key,
	user_name varchar(255) not null,
	gender varchar(3),
	phone varchar(255),
	grade_code int,
	-- grade_name varchar(255),
	foreign key(grade_code) references user_grade(grade_code)
	on update set null
	on delete set null
)engine=innodb;

insert into instructor_foreignkey2
values (1, '왕강사', '남', '010-2323-2323', 30),
		(2, '이상우', '남', '010-2323-2323', 10);
select * from instructor_foreignkey2;
-- instructor_foreignkey 테이블에서 참조의 대한 옵션을 설정하지 않았다.
-- 이로인해 아래의 update에서 user_grade를 변경한다면 instructor_foreignkey 테이블이 참조하고 있어
-- 변경할 수 없는 오류가 발생하게 된다. 그래서 삭제
drop table if exists instructor_foreignkey;

-- grade_code = null
-- grade_code는 제약조건으로 primary key 조건이 부여되었다.
-- 이로인해 grade_code를 삭제하는 것은 primary key 제약조건에 위배하여 불가능하다.
update user_grade
set grade_code = 40
where grade_code = 10;
select * from user_grade;
-- 아래의 테이블을 조회하면 grade_code가 변경됨에 따라 grade_code가 null로 변경된다.
-- 이는 on delete set null 옵션에 의해 참조하는 테이블이 변경되면 자신의 참조값을 null로 처리하는 것이다.
select * from instructor_foreignkey2;

-- check
drop table if exists user_check;
create table if not exists user_check(
	user_no int auto_increment primary key,
	user_name varchar(255) not null,
	gender varchar(3) check (gender in ('남', '여')),
	age int check (age >= 15)
)engine=innodb;

insert into user_check
values (null, '홍길동', '남',15);
-- 아래의 값은 성별과 나이가 check 제약조건에 의해 맞지 않아 오류가 난다.
	-- (null, '홍길', '짭',20),
	-- (null, '짱구', '남',5)
select * from user_check;

-- default 
-- 컬럼에 null 대신 기본 값 적용
-- 컬럼 타입이 date일 시 current_date만 가능하다.
-- 컬럼 타입이 datetime일 시 current_time과 current_timestamp, now() 모두 사용 가능
drop table if exists tbl_country;
create table if not exists tbl_country(
	country_code int auto_increment primary key,
	country_name varchar(255) default '한국',
	poplation varchar(255) default '0명',
	add_day date default (current_date),
	add_time datetime default (current_time)
)engine=innodb;
select * from tbl_country;
insert into tbl_country
values (null, default, default, default, default);
insert into tbl_country
	(country_code)
values (null);
select * from tbl_country;

SELECT AVG(menu_price) FROM tbl_menu;
SELECT CAST(AVG(menu_price) AS SIGNED INTEGER) AS '평균 메뉴 가격' FROM tbl_menu;
SELECT CONVERT(AVG(menu_price), SIGNED INTEGER) AS '평균 메뉴 가격' FROM tbl_menu;

SELECT CAST('2023$5$30' AS DATE);
SELECT CAST('2023/5/30' AS DATE);
SELECT CAST('2023%5%30' AS DATE);
SELECT CAST('2023@5@30' AS DATE);

-- 카테고리별 메뉴 가격 합계 구하기
SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원') FROM tbl_menu;

-- 카테고리별 메뉴 가격 합계 구하기
SELECT category_code, CONCAT(CAST(SUM(menu_price) AS CHAR(10)), '원') FROM tbl_menu GROUP BY category_code;

/* 암시적 형변환(Implicit Conversion) */
SELECT '1' + '2';    -- 각 문자가 정수로 변환됨
SELECT CONCAT(menu_price, '원') FROM tbl_menu;    -- menu_price가 문자로 변환됨
SELECT 3 > 'MAY';    -- 문자는 0으로 변환된다.
SELECT 5 > '6MAY';   -- 문자에서 첫번째로 나온 숫자는 정수로 전환된다.
SELECT 5 > 'M6AY';   -- 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.
SELECT '2023-5-30';  -- 날짜형으로 바뀔 수 있는 문자는 DATE형으로 변환된다.




	
