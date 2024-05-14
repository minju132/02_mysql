-- '어'가 들어가는 메뉴 중에 비싼 top 2,3의 가격를 더하고 그 값에 메뉴 코드에 1를 뺀 값으로 나눈 다음 0을 곱한 값 구하기
select 
	menu_code,
	menu_name,
	menu_price
  from tbl_menu tm 
  where menu_name like '%어%'
  order by menu_price desc
  limit 1, 2;
  -- group by menu_code;
 select 
  a.menu_name,
   a.menu_price,
   b.category_name
   from tbl_menu a
   left join tbl_category b  on a.category_code = b.category_code
   where b.category_name  = "일식" and a.menu_price >= 10000;
 
-- 재석님 문제 : 메뉴판 10개중에 가격 제일 높은걸 10개 내림차순으로 출력 후 10개의 평균값을 구해주세용 :3

	
-- 은진님 문제 : category_name을 기준을 menu_name 과 menu_price 를 출력하시오. 단 menu_price 는 비싼 거부터 출력하세요!
select
	tc.category_name ,
	tm.menu_name,
	tm.menu_price
  from tbl_menu tm
  left join tbl_category tc on tc.category_code = tm.category_code 
 order by menu_price desc;

-- 하영님 문제 : 가격이 3000원 이상, 10000원 이하인 메뉴 중에서 '마늘'이 없는 메뉴를 찾아주세요.
select 
	menu_name,
	menu_price
  from tbl_menu tm 
  having tm.menu_price between 3000 and 10000 and tm.menu_name not in ('%마늘%','%갈릭%');