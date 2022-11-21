insert into group_join_request values (1, 'user1', 1);
insert into group_join_request values (2, 'user2', 1);
insert into group_join_request values (3, 'user3', 1);
insert into group_join_request values (4, 'user4', 1);
insert into group_join_request values (5, 'user5', 1);
insert into group_join_request values (6, 'user6', 1);
insert into group_join_request values (7, 'user7', 1);
insert into group_join_request values (8, 'user8', 1);
insert into group_join_request values (9, 'user9', 1);
select * from inquery
select * from board
drop table comm purge;
select * from board order by board_num
create table comm(
	num number primary key,
	id varchar2(30),
	content varchar2(200),
	reg_date date,
	comment_inquery_num number references inquery(Inquery_NUM) on delete cascade,
	--comm 테이블이 참조하는 보드 글 번호
	comment_re_lev number(1) check(comment_re_lev in (0,1,2)),--원문이면 0 답글이면 1
	comment_re_seq number,--원문이면 0, 1레벨이면 1레벨 시퀀스 +1
	comment_re_ref number--원문은 자신 글번호, 답글이면 원문 글번호
);
delete from comm
select * from inquery
create table inquery(
	Inquery_NUM NUMBER,--글 번호
	Inquery_NAME VARCHAR2(30),--작성자
	Inquery_PASS VARCHAR2(30),--비밀번호
	Inquery_SUBJECT VARCHAR2(300),--제목
	Inquery_CONTENT VARCHAR2(4000),--내용
	Inquery_FILE VARCHAR2(50),--첨부파일명(가공)
	Inquery_ORIGINAL VARCHAR2(50), --첨부 파일 명
	Inquery_RE_REF NUMBER,--답변 글 작성시 참조되는 글의 번호
	Inquery_RE_LEV NUMBER,--답변 글의 깊이
	Inquery_RE_SEQ NUMBER,--답변 글의 순서
	Inquery_READCOUNT NUMBER,--글의 조회수
	Inquery_DATE DATE,--글 작성 날짜
	Inquery_Secret Number check(Inquery_Secret in(0,1)),
	PRIMARY KEY(Inquery_NUM)
);

select * 
	  from  (select * 
	                 from inquery                
	                  left outer join (select comment_inquery_num, count(*) cnt
                                            from comm
                                            group by comment_inquery_num) c
                  on inquery.inquery_num = c.comment_inquery_num
                  order by inquery.inquery_num desc) b 
	        
	  where inquery_num = 2
	  
	  
	  
select * from inquery
where group_no = 10
-- 최종 테이블 모음(수정X)
update GROUP_USER_ROLE
set group_role =
case
when userid='test2' then 1--모임장은 일반 회원으로
when userid='test1' then 0--해당 회원은 모임장이 된다.
else 1
end
where group_no=6
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
alter table user_info modify (area_name varchar2(100) default '서울'); 
select * from user_info;


-- 모임 정보
drop table group_info CASCADE CONSTRAINTS;
CREATE TABLE group_info (
   group_no   		number   		NOT NULL primary key,
   group_name   	varchar2(100)   NOT NULL,
   group_content   	varchar2(1000)  NOT NULL,
   group_original   varchar2(100)   NOT NULL,
   group_img   		varchar2(100)   NOT NULL,
   area_name   		varchar2(100)   NOT NULL,
   catename   		varchar2(100)   NOT NULL,
   opendate  		date   			NOT NULL,
   userid   		varchar2(100)   NOT NULL 
   					references user_info(userid)  
               		on delete cascade
);

select * from group_info;


-- 모임 내 역할
drop table group_user_role CASCADE CONSTRAINTS;
create table group_user_role (
	group_role_no	number not null,
	userid			varchar2(100) not null,
	group_no		number not null references group_info(group_no)  
					on delete cascade,
	group_role		number not null,
	primary key(group_role_no)
);

select * from group_user_role;

update GROUP_USER_ROLE
set group_role =
case
when userid='test1' then 1
when userid='test2' then 0
else 1
end;
 GROUP_ROLE_NO USERID GROUP_NO GROUP_ROLE
 ------------- ------ -------- ----------
            81 test2         6          1
            82 test1         6          0
            85 test3         6          1
            86 test4         6          1
            87 test5         6          1
            28 test3         3          0
            27 test2         2          0
            32 test2         7          0
            
            
 GROUP_ROLE_NO USERID GROUP_NO GROUP_ROLE
 ------------- ------ -------- ----------
            81 test2         6          0
            82 test1         6          1
            85 test3         6          1
            86 test4         6          1
            87 test5         6          1
            28 test3         3          0
            27 test2         2          0
            32 test2         7          0
            
            update group_user_role
            set group_role=0
            where group_no=3

update GROUP_USER_ROLE
set group_role =
case
when userid='test2' then 1--모임장은 일반 회원으로
when userid='test1' then 0--해당 회원은 모임장이 된다.
else 1
end
where group_no=6

select * from group_info
select * from group_user_role
update GROUP_USER_ROLE
set group_role=0
where userid='test1'
 GROUP_ROLE_NO USERID GROUP_NO GROUP_ROLE
 ------------- ------ -------- ----------
            81 test2         6          1
            82 test1         6          0
            85 test3         6          1
            86 test4         6          1
            87 test5         6          1
            28 test3         3          0
            27 test2         2          0
            32 test2         7          0
            
            -- 모임 일정
drop table group_schedule CASCADE CONSTRAINTS;
create table group_schedule (
	calendar_no		number not null,
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


--그룹 내 게시판
drop table Group_Board CASCADE CONSTRAINTS;
CREATE TABLE Group_Board(
	GROUP_NO 		NUMBER,
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

select * from Group_Board;

--그룹 내 게시판 댓글
drop table comments CASCADE CONSTRAINTS;
create table comments(
  num          number       primary key,
  userid       varchar2(30) references user_info(userid),
  content      varchar2(200),
  reg_date     date,
  board_num    number references Group_Board(board_num) 
               on delete cascade 
);

select * from comments;

-- 시퀀스
drop sequence JOIN_SEQ;

drop sequence role_seq;

drop sequence calendar_seq;

drop sequence com_seq;

create sequence JOIN_SEQ;

create sequence role_seq;

create sequence calendar_seq;

create sequence com_seq;
select * from board3

update user_info
set auth='ROLE_ADMIN'
where userid = 'admin';

CREATE TABLE notice (
	notice_no	number	NOT NULL,
	subject	varchar2(100)	NOT NULL,
	content	varchar2(1000)	NOT NULL,
	READCOUNT NUMBER,  
	notice_file_original	varchar2(100)	NULL,----첨부 파일 명(가공)
	notice_file	varchar2(100)	NULL,
	writedate	date	NOT NULL
);

 select *
        from group_schedule
                 left join group_info gi on gi.group_no = group_schedule.group_no
select * from 
			(select rownum rnum, j.*	  
			from (select * from notice
			order by notice_no desc
			--where subject like '%개%'
					) j  	
			where rownum<=10
			) 
		where rnum>=1  and rnum<=10
		
select * from notice
drop table notice purge
delete from notice
insert into board3 (board_num, board_name, board_pass, board_subject, board_content, board_date) values (20, 'admin', '1234', '조회수', 'test', sysdate)