-- 모임회원 게시판
drop table post_group CASCADE CONSTRAINTS;
create table post_group (
   post_no      number   not null,
   group_no   varchar2(100)   not null,
   subject      varchar2(100) not null,
   content      varchar2(1000) not null,
   userid      varchar2(100) not null,
   writedate   date not null,
   primary key(post_no)
);

select * from post_group;


-- 모임회원 댓글
drop table post_reply CASCADE CONSTRAINTS;

create table post_reply (
   reply_no   number   not null,
   content      varchar2(1000) not null,
   writedate   date not null,
   userid      varchar2(100) not null,
   post_no      number   not null,
   primary key(reply_no)
);

select * from post_reply;


-- 회원정보
drop table user_info CASCADE CONSTRAINTS;
create table user_info (
   userid         varchar2(100) not null,
   name         varchar2(50) not null,
   gender         varchar2(5) not null,
   age            number(2)   not null,
   password       varchar2(60) not null,
   email         varchar2(100) not null,
   area_name      varchar2(100) not null,
   joindate      date not null,
   auth       varchar2(50) not null,   
   primary key(userid)
);

--그룹 내 게시판
drop table Group_Board CASCADE CONSTRAINTS;
CREATE TABLE Group_Board(
   GROUP_NO       NUMBER,
   BOARD_NUM       NUMBER,         --글 번호
   BOARD_NAME      VARCHAR2(30),   --작성자
   BOARD_PASS      VARCHAR2(30),   --비밀번호
   BOARD_SUBJECT   VARCHAR2(300),  --제목
   BOARD_CONTENT   VARCHAR2(4000), --내용
   BOARD_FILE      VARCHAR2(50),   --첨부 파일 명(가공)
   BOARD_ORIGINAL  VARCHAR2(50),   --첨부 파일 명
   BOARD_READCOUNT NUMBER,    --글의 조회수
   BOARD_DATE DATE,           --글의 작성 날짜
   PRIMARY KEY(BOARD_NUM)
);

--그룹 내 게시판 댓글
drop table comments CASCADE CONSTRAINTS;
create table comments(
  num          number       primary key,
  userid           varchar2(30) references user_info(userid),
  content      varchar2(200),
  reg_date     date,
  board_num    number references Group_Board(board_num) 
               on delete cascade 
  );
  
  


select * from user_info;
select * from group_info;

-- 모임 정보
drop table group_info CASCADE CONSTRAINTS;
create table group_info (
   group_no      	NUMBER not null,
   group_name      varchar2(100) not null,
   group_original   varchar2(100) not null,
   group_img      varchar2(100) not null,
   area_name      varchar2(100) not null,
   catename      varchar2(100) not null,
   opendate      date not null,
   userid         varchar2(100) not null,
   group_content   varchar2(1000) not null,
   primary key(group_no)
);

-- 모임 내 역할
drop table group_user_role CASCADE CONSTRAINTS;
create table group_user_role (
   group_role_no   number not null,
   userid         varchar2(100) not null,
   group_no       number not null references group_info(group_no)  
               on delete cascade ,
   group_role      number not null,
   primary key(group_role_no)
);

select * from group_user_role;


select * from group_info;


-- 모임 일정
drop table group_schedule CASCADE CONSTRAINTS;
create table group_schedule (
   calendar_no      number   not null,
   group_no      varchar2(100) not null,
   title         varchar2(100) not null,
   subject         varchar2(100) not null,
   content         varchar2(1000) not null,
   startdate      date not null,
   location      varchar2(100) not null,
   xcoord         varchar2(100) null,
   ycoord         varchar2(100) null,
   primary key(calendar_no)
);

select * from group_schedule;


-- 가입 승인 요청
drop table group_join_request CASCADE CONSTRAINTS;
create table group_join_request (
   group_join_no   number   not null,
   userid         varchar2(100) not null,
   group_no      varchar2(100) not null,
   primary key(group_join_no)
);

select * from group_join_request;


-- 커뮤니티
drop table community CASCADE CONSTRAINTS;
create table community (
   community_no         number   not null,
   community_subject      varchar2(100) not null,
   community_content      varchar2(1000) not null,
   community_original      varchar2(100) null,
   community_file         varchar2(100) null,
   writedate            varchar2(100) not null,
   userid               varchar2(100) not null,
   primary key(community_no)
);

select * from community;


--모임장 공지
drop table notice CASCADE CONSTRAINTS;
create table notice (
   notice_no            number not null,
   subject               varchar2(100) not null,
   content               varchar2(1000) not null,
   writedate            date not null,
   notice_file_original   varchar2(100) null,
   notice_file            varchar2(100) null,
   userid               varchar2(100) not null,
   group_no            varchar2(100) not null,
   primary key(notice_no)
);

select * from notice;

drop sequence JOIN_SEQ;

drop sequence role_seq;

drop sequence calendar_seq;

drop sequence com_seq;


create sequence JOIN_SEQ;

create sequence role_seq;

create sequence calendar_seq;

create sequence com_seq;

--admin 계정 회원가입 후 실행
update user_info
set auth='ROLE_ADMIN'
where userid = 'admin';

select * from group_info
select * from group_user_role

delete from group_info
where group_no = 1

delete from group_user_role
where group_no = 3

DELETE FROM group_info, group_user_role
    	USING group_info AS a
    	LEFT JOIN group_user_role AS b
    	ON a.group_no = b.group_no
		WHERE b.group_no = '1'
		
		
		
DELETE 
  FROM (SELECT a.userid
             , b.group_no
      FROM group_info a
         , group_user_role b)
 WHERE group_no = 1	