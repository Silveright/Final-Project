package com.project.test.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.test.domain.AdminChartAreaDate;
import com.project.test.domain.AdminChartCategory;
import com.project.test.domain.AdminMember;
import com.project.test.domain.Inquery;
import com.project.test.domain.Planner;
import com.project.test.domain.Member;
import com.project.test.domain.Notice;

@Mapper
public interface AdminMapper {

	int getTotaluser();

	int getTotalschedule();

	String getBestgroup();

	int getTotalgroup();

	List<AdminChartAreaDate> getChartareadate();


	List<AdminChartCategory> getPieChart();

	int getSearchListCount(Map<String, String> map);

	List<AdminMember> getSearchList(Map<String, Object> map);

	int getGroupSearchListCount(Map<String, String> map);

	List<AdminMember> getGroupSearchList(Map<String, Object> map);

	void delete(String userid);

	List<Planner> getChartSchedule();

	List<AdminChartCategory> getChartGender();

	int getNoticeListCount(Map<String, String> map);

	List<Notice> getNoticeList(HashMap<String, Object> map);

	void insertNotice(Notice notice);

	int setReadCountUpdate(int num);

	Notice getDetail(int num);

	int noticeModify(Notice notice);

	int noticeDelete(int num);

	List<Inquery> getInqueryList(HashMap<String, Object> map);

	int getInqueryListCount(Map<String, String> map);

	void insertInquery(Inquery inquery);

	int setInquiryReadCountUpdate(int num);

	Inquery getInquiryDetail(int num);

	Inquery isBoardWriter(HashMap<String, Object> map);

	int inqueryModify(Inquery inquery);

	int inqueryDelete(Inquery inquery);

	int inqueryReply(Inquery inquery);

	int inqueryReplyUpdate(Inquery inquery);

}
