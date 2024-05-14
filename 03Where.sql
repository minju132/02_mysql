select 
	menu_name,
	menu_price,
	orderable_status
  from tbl_menu
 where orderable_status = 'Y';

select 
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
where menu_price >= 13000
order by menu_price desc;

select 
	*
  from tbl_menu
 where orderable_status != 'Y';

select 
	*
  from tbl_menu
 where orderable_status = 'Y' or category_code = 10;
-- 같은 문자열이 있는지 조회하기
select 
	menu_name,
	menu_price
  from tbl_menu
 where menu_name like '%치쉐%';
-- 포함하지 않은 값 조회
select 
	menu_name,
	menu_price
  from tbl_menu
 where menu_name not like '%치쉐%';

select 
	category_code,
	category_name,
	ref_category_code
  from tbl_category
 where ref_category_code is not null;




 
