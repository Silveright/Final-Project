-- 모임회원 게시판
drop table post_group CASCADE CONSTRAINTS;
create table post_group (
	post_no		number	not null,
	group_no	number	not null,
	subject		varchar2(100) not null,
	content		varchar2(1000) not null,
	userid		varchar2(100) not null,
	writedate	date not null,
	primary key(post_no)
);

select * from post_group;


-- 모임회원 댓글
drop table post_reply CASCADE CONSTRAINTS;

create table post_reply (
	reply_no	number	not null,
	content		varchar2(1000) not null,
	writedate	date not null,
	userid		varchar2(100) not null,
	post_no		number	not null,
	primary key(reply_no)
);

select * from post_reply;


-- 회원정보
drop table user_info CASCADE CONSTRAINTS;
create table user_info (
	userid			varchar2(100) not null,
	name			varchar2(50) not null,
	gender			varchar2(5) not null,
	age				number(2)	not null,
	password 		varchar2(60) not null,
	email			varchar2(100) not null,
	area_name		varchar2(100) not null,
	joindate		date not null,
	auth		 varchar2(50) not null,	
	primary key(userid)
);

select * from USER_INFO


update user_info
set auth='ROLE_ADMIN'
where userid = 'admin';
insert into user_info values(
		'admin' , '관리자' , '남', 32, 1234,'ansd3073@naver.com','서울',sysdate,
		'ROLE_MEMBER')
select * from user_info;


-- 모임 내 역할
drop table group_user_role CASCADE CONSTRAINTS;
create table group_user_role (
	group_role_no	number not null,
	userid			varchar2(100) not null,
	group_no		number not null,
	group_role		number not null,
	primary key(group_role_no)
);

select * from group_user_role;


-- 모임 정보
drop table group_info CASCADE CONSTRAINTS;
create table group_info (
	group_no		number not null,
	group_name		varchar2(100) not null,
	group_original	varchar2(100) not null,
	group_img		varchar2(100) not null,
	area_name		varchar2(100) not null,
	catename		varchar2(100) not null,
	opendate		date not null,
	userid			varchar2(100) not null,
	primary key(group_no)
);

select * from group_info;


-- 모임 일정
drop table group_schedule CASCADE CONSTRAINTS;
create table group_schedule (
	calendar_no		number	not null,
	group_no		number not null,
	title			varchar2(100) not null,
	subject			varchar2(100) not null,
	content			varchar2(1000) not null,
	startdate		date not null,
	location		varchar2(100) not null,
	xcoord			varchar2(100) null,
	ycoord			varchar2(100) null,
	primary key(calendar_no)
);

select * from group_schedule;


-- 가입 승인 요청
drop table group_join_request CASCADE CONSTRAINTS;
create table group_join_request (
	group_join_no	number	not null,
	userid			varchar2(100) not null,
	group_no		number not null,
	primary key(group_join_no)
);

select * from group_join_request;


-- 커뮤니티
drop table community CASCADE CONSTRAINTS;
create table community (
	community_no			number	not null,
	community_subject		varchar2(100) not null,
	community_content		varchar2(1000) not null,
	community_original		varchar2(100) null,
	community_file			varchar2(100) null,
	writedate				varchar2(100) not null,
	userid					varchar2(100) not null,
	primary key(community_no)
);

select * from community;


--모임장 공지
drop table notice CASCADE CONSTRAINTS;
create table notice (
	notice_no				number not null,
	subject					varchar2(100) not null,
	content					varchar2(1000) not null,
	writedate				date not null,
	notice_file_original	varchar2(100) null,
	notice_file				varchar2(100) null,
	userid					varchar2(100) not null,
	group_no				number not null,
	primary key(notice_no)
);

select * from notice;





