drop table call_list ; 
CREATE TABLE IF NOT EXISTS call_list	-- 전화번호부
(
	call_list_code int primary key auto_increment comment '전화번호부 코드',
	user_no int not null comment '유저번호',
	constraint fk_user_no FOREIGN key (user_no) references user_info (user_no)

) ENGINE=INNODB;

drop table call_link ;
CREATE TABLE IF NOT EXISTS call_link	-- 전화번호 링크
(
	call_list_code int not null comment '전화번호부 코드',
	call_code int not null comment '전화번호 코드',
	constraint fk_call_list_code FOREIGN key (call_list_code) references call_list (call_list_code),
	constraint fk_call_code FOREIGN key (call_code) references call_number (call_code)

) ENGINE=INNODB;

drop table call_number;
cREATE TABLE IF NOT EXISTS call_number	-- 전화번호
(
    call_code int primary key auto_increment comment '전화번호 코드',
    user_no int not null comment '유저번호',
    call_name varchar(255) NOT NULL comment '전화번호 구분',
    call_number varchar(13) NOT NULL comment '전화번호',
    main_call varchar(1) check(main_call in ('y','n')) comment '상태(대표번호)',
    constraint fk_ref_user_no FOREIGN key (user_no) references user_info (user_no)
) ENGINE=INNODB;

drop table user_info;
CREATE TABLE IF NOT EXISTS user_info	-- 유저정보
(
    user_no int primary key auto_increment comment '유저번호',
    user_name varchar(255) not null comment '유저이름',
    user_address varchar(255) comment '유저주소'
) ENGINE=INNODB;
select
	*
  from call_number cn ;
 
 select
	*
  from user_info ui  

insert into user_info values (null, '김다영', '면목동');
insert into user_info values (null, '김재석', '고잔동');
insert into user_info values (null, '박하영', '군자동');
insert into user_info values (null, '서은진', '가산동');
insert into user_info values (null, '김민주', '암사동');

insert into call_number values (null, 1, '핸드폰', '010-8846-5954', 'Y');
insert into call_number values (null, 2, '핸드폰', '010-6368-9728', 'Y');
insert into call_number values (null, 3, '핸드폰', '010-8985-3027', 'Y');
insert into call_number values (null, 4, '핸드폰', '010-6270-4016', 'Y');
insert into call_number values (null, 5, '핸드폰', '010-2863-0788', 'Y');
SELECT
        USER_NO
        FROM USER_INFO
        WHERE USER_NAME = '김다영';
