package com.project.test.domain;

import org.springframework.web.multipart.MultipartFile;

public class Group {

	private int group_no;
	private String group_name;
	private String group_content;
	private String group_original;
	private String group_img;
	private String area_name;
	private String catename;
	private String opendate;
	private String userid;
	private MultipartFile uploadfile;
	private int CNT; //베스트 모임 만들때 사용 예정
	
	
	public int getGroup_no() {
		return group_no;
	}
	public void setGroup_no(int group_no) {
		this.group_no = group_no;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getGroup_content() {
		return group_content;
	}
	public void setGroup_content(String group_content) {
		this.group_content = group_content;
	}
	public String getGroup_original() {
		return group_original;
	}
	public void setGroup_original(String group_original) {
		this.group_original = group_original;
	}
	public String getGroup_img() {
		return group_img;
	}
	public void setGroup_img(String group_img) {
		this.group_img = group_img;
	}
	public String getArea_name() {
		return area_name;
	}
	public void setArea_name(String area_name) {
		this.area_name = area_name;
	}
	public String getCatename() {
		return catename;
	}
	public void setCatename(String catename) {
		this.catename = catename;
	}
	public String getOpendate() {
		return opendate;
	}
	public void setOpendate(String opendate) {
		this.opendate = opendate;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public int getCNT() {
		return CNT;
	}
	public void setCNT(int cNT) {
		CNT = cNT;
	}
	
	
	
	
	
	
}
