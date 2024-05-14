-- group by
-- 같은 값을 묶을 때 사용하는 키워드이다.
select 
	category_code,
	count(*)
  from tbl_menu
 group by category_code ;
 
select 
	
	category_code,
	sum(menu_price)
  from tbl_menu
  group by category_code ;

select 
	concat (menu_price)
  from tbl_menu;

select 
	category_code,
	avg(menu_price)
  from tbl_menu
 group by category_code;
-- 여러 값을 묶는 경우
select
	category_code,
	menu_price,
	count(*)
  from tbl_menu
 group by category_code, menu_price ;
-- 그룹에 조건을 부여하기
-- having
select
	category_code,
	count(*)
  from tbl_menu
 where category_code  > 6 -- sql 퀴리의 전체의 대한 조건
 group by category_code
 having category_code between 5 and 8;
