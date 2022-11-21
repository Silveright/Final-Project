drop table member CASCADE CONSTRAINTS;
--1. index.jsp에서 시작합니다.
--2. 관리자 계정 admin, 비번 1234를 만듭니다.
--3. 사용자 계정을 3개 만듭니다.

create table member(
  id         varchar2(15),
  password   varchar2(60), --암호화를 하면 password가 60자 필요합니다.
  name       varchar2(15),
  age        number(2),
  gender     varchar2(5),
  email      varchar2(30),
  auth		 varchar2(50) not null,	-- 회원의 role(권한)을 저장하는 곳으로 기본값은 'ROLE_MEMBER' 입니다.
  PRIMARY KEY(id)
);

update member
set auth='ROLE_ADMIN'
where id = 'admin';

select * from member;

drop table comments CASCADE CONSTRAINTS;

insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (1,'user1', 1);
insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (2,'user2', 1);
insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (3,'user3', 1);
 insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (4,'user4', 1);
 insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (5,'user5', 1);
  insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (6,'user6', 1);
  insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (7,'user7', 1);
 insert into group_join_request(GROUP_JOIN_NO, userid, group_no)
 values (8,'user8', 1);
 
insert into user_info values ('user1', '여', 'user1@kakao.com', '서울', sysdate)
insert into user_info values ('user2', '남', 'user2@kakao.com', '서울', sysdate)
insert into user_info values ('user3', '여', 'user3@kakao.com', '서울', sysdate)
insert into user_info values ('user4', '여', 'user4@kakao.com', '서울', sysdate)
insert into user_info values ('user5', '여', 'user5@kakao.com', '서울', sysdate)
insert into user_info values ('user6', '여', 'user6@kakao.com', '서울', sysdate)
insert into user_info values ('user7', '여', 'user6@kakao.com', '서울', sysdate)
insert into user_info values ('user8', '여', 'user8@kakao.com', '서울', sysdate)

CREATE TABLE user_info (
   userid   varchar2(100)   NOT NULL primary key,
   gender   varchar2(5)   NOT NULL,
   email   varchar2(100)   NOT NULL,
   area_name   varchar2(100)   NOT NULL,
   joindate   date   NOT NULL
);

delete table user_info
delete from group_user_role

select * from group_user_role
select * from user_info
select * from GROUP_JOIN_REQUEST

create sequence calendar_seq

create sequence join_seq

drop table user_info purge;

select *
from (select rownum rnum, j.userid, group_no, group_role, gender, email, area_name
     from (
           select * 
from group_user_role
join (select userid as id, gender, email, area_name
from user_info) 
on id=userid
where group_no=1
and group_role=1--일반 회원만 출력
--and userid like '%1%'--검색 기능
           )j
           where rownum<=10)
where rnum>=1 and rnum<=10;