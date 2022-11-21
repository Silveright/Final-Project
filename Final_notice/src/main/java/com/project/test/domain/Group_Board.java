package com.project.test.domain;

import org.springframework.web.multipart.MultipartFile;

public class Group_Board {
	private int BOARD_NUM;			//글 번호
	private String BOARD_NAME;		//글 작성자
	private String BOARD_PASS;		//글 비밀번호
	private String BOARD_SUBJECT;	//글 제목
	private String BOARD_CONTENT;	//글 내용
	private String BOARD_FILE;		//실제 저장된 파일의 이름
	private int BOARD_READCOUNT;	//글의 조회수
	private int GROUP_NO;
	public int getGROUP_NO() {
		return GROUP_NO;
	}

	public void setGROUP_NO(int gROUP_NO) {
		GROUP_NO = gROUP_NO;
	}

	//board_write.jsp에서 name 속성 확인하세요.
	//<input type="file" id="upfile" name="uploadfile"> 확인
	private MultipartFile uploadfile;
	
	private String BOARD_ORIGINAL;	//첨부될 파일의 이름
	private String BOARD_DATE;
	
	//이곳에서 오른쪽 마우스 버튼 클릭 후  -> Source
	//-> Generate Getters and Setters(alt + shift + s) 
	
	private int CNT;
	
	public int getCNT() {
		return CNT;
	}

	public void setCNT(int cNT) {
		CNT = cNT;
	}

	public int getBOARD_NUM() {
		return BOARD_NUM;
	}
	
	public void setBOARD_NUM(int bOARD_NUM) {
		BOARD_NUM = bOARD_NUM;
	}
	
	public String getBOARD_NAME() {
		return BOARD_NAME;
	}
	
	public void setBOARD_NAME(String bOARD_NAME) {
		BOARD_NAME = bOARD_NAME;
	}
	
	public String getBOARD_PASS() {
		return BOARD_PASS;
	}
	
	public void setBOARD_PASS(String bOARD_PASS) {
		BOARD_PASS = bOARD_PASS;
	}
	
	public String getBOARD_SUBJECT() {
		return BOARD_SUBJECT;
	}
	
	public void setBOARD_SUBJECT(String bOARD_SUBJECT) {
		BOARD_SUBJECT = bOARD_SUBJECT;
	}
	
	public String getBOARD_CONTENT() {
		return BOARD_CONTENT;
	}
	
	public void setBOARD_CONTENT(String bOARD_CONTENT) {
		BOARD_CONTENT = bOARD_CONTENT;
	}
	
	public String getBOARD_FILE() {
		return BOARD_FILE;
	}
	
	public void setBOARD_FILE(String bOARD_FILE) {
		BOARD_FILE = bOARD_FILE;
	}	
	
	public int getBOARD_READCOUNT() {
		return BOARD_READCOUNT;
	}
	
	public void setBOARD_READCOUNT(int bOARD_READCOUNT) {
		BOARD_READCOUNT = bOARD_READCOUNT;
	}
	
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	
	public String getBOARD_ORIGINAL() {
		return BOARD_ORIGINAL;
	}
	
	public void setBOARD_ORIGINAL(String bOARD_ORIGINAL) {
		BOARD_ORIGINAL = bOARD_ORIGINAL;
	}
	
	public String getBOARD_DATE() {
		return BOARD_DATE;
	}
	
	public void setBOARD_DATE(String bOARD_DATE) {
		BOARD_DATE = bOARD_DATE.substring(0,10);
	}
	
}
