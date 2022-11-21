package com.project.test.domain;
import org.springframework.web.multipart.MultipartFile;

public class Inquery {
	private int inquery_num;
	private String inquery_name;
	private String inquery_pass;
	private String inquery_subject;
	private String inquery_content;
	private String inquery_file;
	private int inquery_re_ref;//답변 글 작성시 참조 글 번호
	private int inquery_re_lev;//답변 글 깊이
	private int inquery_re_seq;//답변 글의 순서
	private int inquery_readcount;//글의 조회수
	private String inquery_date;
	private int inquery_secret;
	public int getInquery_secret() {
		return inquery_secret;
	}
	public void setInquery_secret(int inquery_secret) {
		this.inquery_secret = inquery_secret;
	}
	private int cnt;
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	//inquery_write.jsp에서 name속성 확인
	//<input type="file" id="upfile" name="uploadfile">확인
	private MultipartFile uploadfile;
	private String inquery_original;//첨부될 파일 이름
	
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getInquery_original() {
		return inquery_original;
	}
	public void setInquery_original(String inquery_original) {
		this.inquery_original = inquery_original;
	}
	
	
	public Inquery() {
		
	}
	public int getInquery_num() {
		return inquery_num;
	}
	public void setInquery_num(int inquery_num) {
		this.inquery_num = inquery_num;
	}
	public String getInquery_name() {
		return inquery_name;
	}
	public void setInquery_name(String inquery_name) {
		this.inquery_name = inquery_name;
	}
	public String getInquery_pass() {
		return inquery_pass;
	}
	public void setInquery_pass(String inquery_pass) {
		this.inquery_pass = inquery_pass;
	}
	public String getInquery_subject() {
		return inquery_subject;
	}
	public void setInquery_subject(String inquery_subject) {
		this.inquery_subject = inquery_subject;
	}
	public String getInquery_content() {
		return inquery_content;
	}
	public void setInquery_content(String inquery_content) {
		this.inquery_content = inquery_content;
	}
	public String getInquery_file() {
		return inquery_file;
	}
	public void setInquery_file(String inquery_file) {
		this.inquery_file = inquery_file;
	}
	public int getInquery_re_ref() {
		return inquery_re_ref;
	}
	public void setInquery_re_ref(int inquery_re_ref) {
		this.inquery_re_ref = inquery_re_ref;
	}
	public int getInquery_re_lev() {
		return inquery_re_lev;
	}
	public void setInquery_re_lev(int inquery_re_lev) {
		this.inquery_re_lev = inquery_re_lev;
	}
	public int getInquery_re_seq() {
		return inquery_re_seq;
	}
	public void setInquery_re_seq(int inquery_re_seq) {
		this.inquery_re_seq = inquery_re_seq;
	}
	public int getInquery_readcount() {
		return inquery_readcount;
	}
	public void setInquery_readcount(int inquery_readcount) {
		this.inquery_readcount = inquery_readcount;
	}
	public String getInquery_date() {
		return inquery_date;
	}
	public void setInquery_date(String inquery_date) {
		this.inquery_date = inquery_date.substring(0,10);//년월일 시분초 >> 년월일만 
	}
	
}
