-- view
-- 가상의 테이블을 형성하는 view를 이해하기
-- select 쿼리문을 저장한 객체로 가상테이블이라고 불린다.
-- 실질적인 데이터를 물리적으로 저장하고 있지 않는다.
-- 데이터를 사용하는 것처럼 동일하게 사용할 수 있다

-- view 생성
create view hansik as
select
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
  from tbl_menu tm 
 where category_code = 4;
 
select * from hansik;

insert into tbl_menu values(null, '식혜맛국밥', 5500, 4, 'Y');

--view를 통한 dml
-- 1) view를 통한 insert(view는 auto_increment가 없으므로 pk 컬럼의 값을 지정해주어야 한다.)
insert into hansik values(99, '수정과맛국밥', 5500, 4, 'Y');
insert into hansik values(100, '수정과맛국밥', 5500, 5, 'Y');
select * from tbl_menu tm ;
select * from hansik;

--test
create view hansik2 as
select
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
  from tbl_menu tm 
 join tbl_category tc on tm.category_code = tc.category_code;
 
select * from hansik2;
-- join을 하는 경우 값을 입력하는 것이 불가능함.
-- 필드 목록이 없으면 조인 뷰 'gangnam.hansik2'에 삽입할 수 없습니다.
insert into hansik2 values
('열무 kimchi', 10000, '한식');

-- 2) view를 통한 update
update hansik
	set menu_name = '수정된 메뉴',
		menu_price = 5700,
  where menu_code = 99;
 
 select * from hansik2;

-- join으로 설정된 테이블의 경우 view의 값을 변경하는 것은 불가능
update hansik2
	set category_name = '열무스',
		menu_price =5700
	 where menu_name = '열무김치라떼';
select * from hansik2;

--view를 삭제
drop view hansik2;
-- view가 삭제되어 조회할 수 없음
select * from hansik2;

-- view에 쓰인 subquery 안에 연산 결과 컬럼도 사용 가능하다.
create view hansik2 as
select
	menu_name as '메뉴명',
	truncate(menu_price/1000,1)as '가격(천원)',
	category_name as '카테고리명'
  from tbl_menu tm
  join tbl_category tc on tm.category_code = tc.category_code
 where tc.category_name = '한식';
create view hansik2 as
select 
   menu_name as '메뉴명',
   truncate(menu_price/1000, 1)as '가격(천원)',
   category_name as '카테고리명'
   from tbl_menu a
   join tbl_category b on a.category_code = b.category_code
   where b. category_name = '한식';
-- view 생성시 지시한 칼럼의 별칭이 view 의칼럼 명이 됨.

select 
   *
    from hansik2
   where 메뉴명 like '%수정%';

-- or replace 옵션
-- 테이블을 drop 하지 않고 기존의 view를 새로운 view로 쉽게 대체할 수 있다.
create or replace view hansik as
select
   menu_code as '메뉴코드',
   menu_name as '메뉴명',
   category_name as '카테고리명'
from tbl_menu
join tbl_category on tbl_menu.category_code = tbl_category.category_code;


select * from hansik;
