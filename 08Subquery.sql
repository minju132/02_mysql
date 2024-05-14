-- 서브쿼리 : 쿼리 안에서 보조적으로 찾는 셀렉트문
select
	category_code
  from tbl_menu tm
 where menu_name ='민트미역국';

select 
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
  from tbl_menu tm 
 where category_code = (select 
							category_code 
						  from tbl_menu tm2 
						 where menu_name = '우럭스무디');
select 
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
  from tbl_menu tm 
 where category_code in (select 
							category_code 
						  from tbl_menu tm2);
-- from 절에 쓰인 서브쿼리
select
	max(count)
--	*
  from (
  	select
  		count(*) as 'count'	-- 가상의 테이블을 만들었기에 지칭을 정해줘야한다. 가상테이블의 갯수만큼 동작됨
  		from tbl_menu tm
  		group by category_code
  ) as countmenu;
-- 카테고리별 평균 가격보다 높은 가격의 메뉴 조회
select 
	menu_code,
	menu_name,
	menu_price,
	category_code,
	orderable_status
  from tbl_menu tm 
 where menu_price > (select
 						avg(menu_price)
 					  from tbl_menu tm
 					 where category_code = tm.category_code);
-- exists
-- 조회 결과가 있을 때 true 아니면 false
select 
	category_name
  from tbl_category tc
 where exists (select
				1
			  from tbl_menu tm
			 where tm.category_code = tc.category_code);
	
