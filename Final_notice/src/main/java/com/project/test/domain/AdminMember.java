package com.project.test.domain;

public class AdminMember {
	//관리자 회원 조회용 DTO
			private String userid;
			private String area_name;
			private String gender;
			private String email;
			private String joindate;
			private int rnum;
			private String group_name;
			private String cnt;
			private String catename;
			
			public String getCatename() {
				return catename;
			}

			public void setCatename(String catename) {
				this.catename = catename;
			}

			public String getGroup_name() {
				return group_name;
			}

			public void setGroup_name(String group_name) {
				this.group_name = group_name;
			}

			public String getCnt() {
				return cnt;
			}

			public void setCnt(String cnt) {
				this.cnt = cnt;
			}

			public int getRnum() {
				return rnum;
			}

			public void setRnum(int rnum) {
				this.rnum = rnum;
			}

			public String getUserid() {
				return userid;
			}

			public void setUserid(String userid) {
				this.userid = userid;
			}

			public String getArea_name() {
				return area_name;
			}

			public void setArea_name(String area_name) {
				this.area_name = area_name;
			}

			public String getJoindate() {
				return joindate;
			}

			public void setJoindate(String joindate) {
				this.joindate = joindate;
			}

			public AdminMember() {
				
			}
			
			public String getName() {
				return area_name;
			}
			public void setName(String name) {
				this.area_name = name;
			}
			public String getGender() {
				return gender;
			}
			public void setGender(String gender) {
				this.gender = gender;
			}
			public String getEmail() {
				return email;
			}
			public void setEmail(String email) {
				this.email = email;
			}
			
}
