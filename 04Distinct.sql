-- distinct
-- 중복값을 제거한다.

-- 단일 열 distinct
-- 아래의 데이터를 조회 시 중복되는 category_code가 출력된다.
select
	category_code
  from tbl_menu
 order by category_code;

-- distinct를 이용하면 중복값을 제거하고 출력할 수 있게 된다.
select
	ref_category_code
  from tbl_category;
 -- null 값을 포함한 열의 distinct
select 
	distinct ref_category_code
  from tbl_category;
-- 열이 여러 개인 distinct
select
	category_code
	orderable_status
  from tbl_menu;
 
 select distinct 
	category_code
	orderable_status
  from tbl_menu;

 -- 순서를 바꿔도 결과값은 동일하다.   
-- distinct 는 select 구문 다음에 온다.

select distinct 
   orderable_status,
   category_code
   from tbl_menu;
