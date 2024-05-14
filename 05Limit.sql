select
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
 order by menu_price;
 
select
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
 order by menu_price desc
 limit 3;
 
-- 2번 행부터 5번 행까지 조회
select
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
 order by menu_code
 limit 3, 5;