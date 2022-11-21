package com.project.test.service;

import java.util.List;

import com.project.test.domain.AdminChartAreaDate;
import com.project.test.domain.AdminChartCategory;
import com.project.test.domain.AdminMember;
import com.project.test.domain.Inquery;
import com.project.test.domain.Planner;
import com.project.test.domain.Member;
import com.project.test.domain.Notice;

public interface AdminService {

	int gettotaluser();

	int gettotalschedule();

	String getbestgroup();

	int gettotalgroup();

	List<AdminChartAreaDate> getChartareaDate();


	List<AdminChartCategory> getPieChart();

	int getSearchListCount(int index, String search_word);

	List<AdminMember> getSearchList(int index, String search_word, int page, int limit);

	int getGroupSearchListCount(int index, String search_word);

	List<AdminMember> getGroupSearchList(int index, String search_word, int page, int limit);

	void delete(String userid);

	List<Planner> getChartSchedule();

	List<AdminChartCategory> getPieChart2();

	int getNoticeListCount(int index, String search_word);

	List<Notice> getNoticeList(int index, String search_word, int page, int limit);

	void insertNotice(Notice notice);

	int setReadCountUpdate(int num);

	Notice getDetail(int num);

	int noticeModify(Notice notice);

	int noticeDelete(int num);

	List<Inquery> getInqueryList(int index, String search_word, int page, int limit);

	int getInqueryListCount(int index, String search_word);

	void insertInquery(Inquery inquery);

	int setInquiryReadCountUpdate(int num);

	Inquery getInquiryDetail(int num);

	boolean isBoardWriter(int inquery_num, String inquery_pass);

	int inqueryModify(Inquery inquery);

	int inqueryDelete(int num);

	int inqueryReply(Inquery inquery);
	
	public int inqueryReplyUpdate(Inquery inquery);

}
