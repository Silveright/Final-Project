package com.project.test.domain;


import java.sql.Date;

public class Planner {
	private String start;//달력 일정 처음 로드 시 Fullcalendar library 필요 속성
	private String color;//달력 일정 태그 색상 부여 용도
	private int calendar_no;
	private Date startdate;
	private String content;
	private String subject;
	private String group_no;
	private String title;//이벤트일정 태그이름
	private String location;
	private String xcoord;
	private String ycoord;
	
	public String getStart() {
			return start;
	}
	public void setStart(String start) {
			this.start = start;
	}
	public String getColor() {
			return color;
	}
	public void setColor(String color) {
			this.color = color;
	}
    public int getCalendar_no() {
		return calendar_no;
	}
	public void setCalendar_no(int calendar_no) {
		this.calendar_no = calendar_no;
	}
    public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGroup_no() {
		return group_no;
	}
	public void setGroup_no(String group_no) {
		this.group_no = group_no;
	}
	public Date getStartdate() {
		return startdate;
	}
	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getXcoord() {
		return xcoord;
	}
	public void setXcoord(String xcoord) {
		this.xcoord = xcoord;
	}
	public String getYcoord() {
		return ycoord;
	}
	public void setYcoord(String ycoord) {
		this.ycoord = ycoord;
	}
}
