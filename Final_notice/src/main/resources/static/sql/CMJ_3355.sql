CREATE TABLE community (
	community_no	number		NOT NULL,
	community_subject	varchar2(100)		NOT NULL,
	community_content	varchar2(1000)		NOT NULL,
	community_original	varchar2(100)		NULL,
	community_file	varchar2(100)		NULL,
	writedate	varchar2(100)		NOT NULL,
	userid	varchar2(100)		NOT NULL
);

CREATE TABLE user_info (
	userid	varchar2(100)		NOT NULL,
	gender	varchar2(5)		NOT NULL,
	email	varchar2(100)		NOT NULL,
	area_name	varchar2(100)		NOT NULL,
	joindate	date		NOT NULL
);

CREATE TABLE group_info (
	group_no	number		NOT NULL,
	group_name	varchar2(100)		NOT NULL,
	group_original	varchar2(100)		NOT NULL,
	group_img	varchar2(100)		NOT NULL,
	area_name	varchar2(100)		NOT NULL,
	catename	varchar2(100)		NOT NULL,
	opendate	date		NOT NULL,
	userid	varchar2(100)		NOT NULL
);

select * from group_user_role

CREATE TABLE post_group (
	post_no	number		NOT NULL,
	group_no	number		NOT NULL,
	subject	varchar2(100)		NOT NULL,
	content	varchar2(1000)		NOT NULL,
	userid	varchar2(100)		NOT NULL,
	writedate	date		NOT NULL
);

CREATE TABLE group_schedule (
	calendar_no	number		NOT NULL,
	group_no	number		NOT NULL,
	title	varchar2(100)		NOT NULL,
	subject	varchar2(100)		NOT NULL,
	content	varchar2(1000)		NOT NULL,
	startdate	date		NOT NULL,
	location	varchar2(100)		NOT NULL,
	xcoord	varchar2(100)		NULL,
	ycoord	varchar2(100)		NULL
);

drop table group_schedule purge;

CREATE TABLE post_reply (
	reply_no	number		NOT NULL,
	content	varchar2(1000)		NOT NULL,
	writedate	date		NOT NULL,
	userid	varchar2(100)		NOT NULL,
	post_no	number		NOT NULL
);

CREATE TABLE notice (
	notice_no	number		NOT NULL,
	subject	varchar2(100)		NOT NULL,
	content	varchar2(1000)		NOT NULL,
	writedate	date		NOT NULL,
	notice_file_original	varchar2(100)		NULL,
	notice_file	varchar2(100)		NULL,
	userid	varchar2(100)		NOT NULL,
	group_no	number		NOT NULL
);

CREATE TABLE group_join_request (
	group_join_no	number		NOT NULL,
	userid	varchar2(100)		NOT NULL,
	group_no	number		NOT NULL
);

CREATE TABLE group_user_role (
	group_role_no	number		NOT NULL,
	userid	varchar2(100)		NOT NULL,
	group_no	number		NOT NULL,
	group_role	number		NOT NULL
);

select * from group_join_request

delete from group_join_request

select * from user_info

select * from group_user_role

ALTER TABLE community ADD CONSTRAINT PK_COMMUNITY PRIMARY KEY (
	community_no
);

ALTER TABLE user_info ADD CONSTRAINT PK_USER_INFO PRIMARY KEY (
	userid
);

ALTER TABLE group_info ADD CONSTRAINT PK_GROUP_INFO PRIMARY KEY (
	group_no
);

ALTER TABLE post_group ADD CONSTRAINT PK_POST_GROUP PRIMARY KEY (
	post_no
);

ALTER TABLE group_schedule ADD CONSTRAINT PK_GROUP_SCHEDULE PRIMARY KEY (
	calendar_no
);

ALTER TABLE post_reply ADD CONSTRAINT PK_POST_REPLY PRIMARY KEY (
	reply_no
);

ALTER TABLE notice ADD CONSTRAINT PK_NOTICE PRIMARY KEY (
	notice_no
);

ALTER TABLE group_join_request ADD CONSTRAINT PK_GROUP_JOIN_REQUEST PRIMARY KEY (
	group_join_no
);

ALTER TABLE group_user_role ADD CONSTRAINT PK_GROUP_USER_ROLE PRIMARY KEY (
	group_role_no
);