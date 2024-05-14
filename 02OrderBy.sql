select
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
  order by menu_price asc; -- asc : 오름차순 정렬, dsec : 내림차순 정렬
  
-- order by 절을 사용하여 결과 집합의 여러 열로 정렬
select 
	menu_code,
	menu_name,
	menu_price
  from tbl_menu
order by
	menu_price desc,	-- 가격으로 정렬 후 같은 가격에서 이름으로 정렬됨
	menu_name asc;
-- 메뉴의 코드, 이름 메뉴 코드 곱하기 가격을 화면에 코드만 기준으로 오름차순 정렬해주세요
select 
	menu_code,
	menu_name,
	menu_code * menu_price
  from tbl_menu
  order by menu_code asc;
-- a
select
	field('C','A','B','C');

select
	menu_code,
	menu_name,
	menu_price
	field(orderable_status,'N','y')
  from tbl_menu;
 

select
	*
	field(orderable_status, 'N','Y') 
  from tbl_menu;

select
	category_code,
	category_name,
	ref_category_code
  from tbl_category
  order by ref_category_code is null asc;
	
  
