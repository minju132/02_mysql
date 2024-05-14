-- join
-- 두 테이블을 연결할 때 사용하는 키워드이다.

-- 문제 메뉴의 카테고리를 알 수 없다.
select
	menu_code,
	menu_name,
	category_code,
	menu_price
  from tbl_menu
 order by menu_price desc;
	
select 
	*
  from tbl_category;
  
-- inner join을 이용한다면
 select
 	m.menu_code,
 	m.menu_name,
 	m.category_code,
 	c.category_name,
 	m.menu_price
  from tbl_menu as m
  join tbl_category as c on (m.category_code = c.category_code)
  
  select 
  	a.category_name,
  	b.menu_name
  from tbl_category a
  left join tbl_menu b on a.category_code = b.category_code ;
  
  select 
  	a.category_name,
  	b.menu_name
  from tbl_menu b
  left join tbl_category a on a.category_code = b.category_code ;
 
  select 
  	a.category_name,
  	b.menu_name
  from tbl_menu b
  right join tbl_category a on a.category_code = b.category_code ;
 
 -- cross join
  select 
  	a.category_name,
  	b.menu_name
  from tbl_menu b
  cross join tbl_category a 
  
  -- self join
    select 
  	a.category_name,
  	b.category_name
  from tbl_category a
  join tbl_category b on a.ref_category_code = b.category_code ;
 
 /* JOIN 알고리즘 */
/* NESTED LOOP JOIN */
-- MySQL은 기본적으로 NESTED LOOP JOIN을 사용한다.

-- 두 개 이상의 테이블에서 하나의 집합을 기준으로 순차적으로 상대방 Row를 결합하여 조합하는 방식

-- 중첩 반복문처럼 첫번 째 테이블의 Row와 관련된 두번째 테이블에 대한 Row를 검색하고 이후 첫 번째
-- 테이블의 다음 Row에 대해 두번쨰 테이블에 대한 것을 검색하며 이후 이와 같은 방식을 반복한다.

-- MySQL은 기본적으로 NESTED LOOP JOIN을 사용하지만 이를 강제하려면 힌트절을 작성해 HASH JOIN을
-- 사용하지 않도록 강제할 수 있다.
 
/* HASH JOIN */
-- MySQL8.0.18버전 이후 지원하게 되었다.
-- 대규모 데이터 세트에 대한 조인 연산을 효과적으로 진행할 수 있다.

-- 해싱 단계에서 조인을 수행하는 두 테이블 중 작은 쪽을 선택하여 해시 테이블을 만들어 메모리에 저장하고
-- 해시 함수를 사용해서 각 행을 특정 "해시 버킷"에 할당한다.

-- 조인 단계에서 다른 테이블을 순회하며 각 행에 대해 동일한 해시 함수를 사용하여 해당 행이 어떤 버킷에 속하는지
-- 결정하고 이 버킷의 모든 행과 해당 행을 비교하여 조인 조건을 만족한다.

-- 이 방법은 조인할 테이블 중 하나가 메모리에 적합할 만큼 충분히 작아야 한다. 그렇지 않으면 해시 테이블이 메모리를
-- 넘어서 디스크로까지 넘어가고 이는 성능 저하를 초래한다.

-- HASH JOIN은 등가 조인('=' 연산자를 사용하는 조인)에만 사용할 수 있고 비등가 조인에는 사용할 수 없다.
SELECT           /*+ HASH_JOIN(a) */
    a.menu_name,
    b.category_name
FROM
    tbl_menu a
JOIN tbl_category b ON a.category_code = b.category_code;
 