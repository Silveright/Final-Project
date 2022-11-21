drop table calendar purge
drop sequence calendar_seq
select * from calendar
create table calendar(
	calendar_no number,
	group_no number,
	title varchar2(15),
	subject varchar2(300),
	content varchar2(1000),
	startdate date --start는 예약어로 사용할 수 없음..
)
create sequence calendar_seq
insert into calendar
values (1,1,'정모','만나요','강남역에서 봐요','2022-09-09')

insert into calendar
values (2,1,'번개','만나요','집에서 봐요','2022-09-12')
select calendar_no, title, to_char(startdate,'yyyy-mm-dd') as "start"
	from calendar 
	where group_no = 1
	
delete from calendar
where calendar_no =32

select * from group_info--모임 생성시 모임 정보를 담는 테이블
CREATE TABLE group_info (
	group_no	number(5) primary key not null,
	user_id	VARCHAR2(20)	NOT NULL,
	group_name	VARCHAR2(60)	NOT NULL,
	group_content	VARCHAR2(3000)	NOT NULL,
	area	VARCHAR2(10)	NULL,
	category	VARCHAR2(20)	NULL,
	group_img	VARCHAR2(50)	NULL,
	opendate	date	default sysdate
);

CREATE TABLE group_user (--모임 가입 회원 정보를 담는 테이블
	group_no	VARCHAR(5) NOT NULL,
	user_id	VARCHAR(20)	NOT NULL--,
	--user_role	VARCHAR(255)	NULL 굳이 있어야하나..?
);

select * from user_info--회원테이블
create table user_info(
	id varchar2(20),
	password varchar2(10),
	name varchar2(15),
	age Number(2),
	gender varchar2(3),
	email varchar2(30),
	PRIMARY KEY(id)
)

1. 모임 생성
insert into group_info values (1, 'user1','코딩 모임','같이 코딩 공부 해요','서울','공부/자기개발','이미지',sysdate)
insert into group_info values (2, 'user2','요리 모임','같이 요리 해요','서울','요리','이미지',sysdate)

2. 모임 가입 유저
insert into group_user values (1, 'joinuser')
insert into group_user values (2, 'joinuser')
insert into group_user values (1, 'joinuser2')

3. 모임장일 경우
select * from group_info where user_id = 'user1'

4. 가입한 모임리스트
select * from group_info gi, GROUP_USER gu
where gi.group_no = gu.group_no
and gu.user_id ='joinuser'

5. 모임원 모임 상세보기
select * from group_info gi, GROUP_USER gu
where gi.group_no = gu.group_no
and gu.user_id ='joinuser'
and gi.group_no = 1




