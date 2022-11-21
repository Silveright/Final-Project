package com.project.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.test.domain.AdminChartAreaDate;
import com.project.test.domain.AdminChartCategory;
import com.project.test.domain.AdminMember;
import com.project.test.domain.Inquery;
import com.project.test.domain.Planner;
import com.project.test.domain.Notice;
import com.project.test.mybatis.mapper.AdminMapper;
@Service
public class AdminServiceImpl implements AdminService{
	private AdminMapper dao;
	private static final Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);
	@Autowired
	public AdminServiceImpl(AdminMapper dao) {
		this.dao = dao;
	}
	@Override
	public int gettotaluser() {
		return dao.getTotaluser();
	}

	@Override
	public int gettotalschedule() {
		return dao.getTotalschedule();
	}

	@Override
	public String getbestgroup() {
		return dao.getBestgroup();
	}

	@Override
	public int gettotalgroup() {
		return dao.getTotalgroup();
	}
	@Override
	public List<AdminChartAreaDate> getChartareaDate() {
		return dao.getChartareadate();
	}
	@Override
	public List<AdminChartCategory> getPieChart() {
		return dao.getPieChart();
	}
	@Override
	public int getSearchListCount(int index, String search_word) {
		Map<String, String> map = new HashMap<String, String>();
		if(index!=-1) {
			String[] search_field = new String[] {"userid", "area_name", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
		}
		return dao.getSearchListCount(map);
	}
	@Override
	public List<AdminMember> getSearchList(int index, String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(index!=-1) {
			String[] search_field = new String[] {"userid", "area_name", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
		}
		int startrow = (page-1)*limit+1;
		int endrow=startrow+limit-1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getSearchList(map);

	}
	@Override
	public int getGroupSearchListCount(int index, String search_word) {
		Map<String, String> map = new HashMap<String, String>();
		if(index!=-1) {
			String[] search_field = new String[] {"userid", "catename", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
		}
		return dao.getGroupSearchListCount(map);
	}
	@Override
	public List<AdminMember> getGroupSearchList(int index, String search_word, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(index!=-1) {
			String[] search_field = new String[] {"userid", "catename", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
		}
		int startrow = (page-1)*limit+1;
		int endrow=startrow+limit-1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getGroupSearchList(map);

	}
	@Override
	public void delete(String userid) {
		dao.delete(userid);
		
	}
	@Override
	public List<Planner> getChartSchedule() {
		return dao.getChartSchedule();
	}
	@Override
	public List<AdminChartCategory> getPieChart2() {
		return dao.getChartGender();
	}
	@Override
	public int getNoticeListCount(int index, String search_word) {
		Map<String, String> map = new HashMap<String, String>();
		logger.info("인덱스는 "+ index);
		if(index!=-1) {
			String[] search_field = new String[] {"subject", "content"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
			logger.info("search_field 는 "+ search_field[index]);
		}
		return dao.getNoticeListCount(map);
	}
	@Override
	public List<Notice> getNoticeList(int index, String search_word, int page, int limit) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(index!=-1) {
			String[] search_field = new String[] {"subject", "content"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
		}
		
		int startrow = (page-1)*limit +1;
		int endrow = startrow +limit-1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getNoticeList(map);
	}
	@Override
	public void insertNotice(Notice notice) {
		dao.insertNotice(notice);
		
	}
	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}
	@Override
	public Notice getDetail(int num) {
		return dao.getDetail(num);
	}
	@Override
	public int noticeModify(Notice notice) {
		return dao.noticeModify(notice);
	}
	@Override
	public int noticeDelete(int num) {
		return dao.noticeDelete(num);
	}
	@Override
	public List<Inquery> getInqueryList(int index, String search_word, int page, int limit) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(index!=-1) {
			String[] search_field = new String[] {"subject", "content"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
		}
		
		int startrow = (page-1)*limit +1;
		int endrow = startrow +limit-1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getInqueryList(map);
	}
	@Override
	public int getInqueryListCount(int index, String search_word) {
		Map<String, String> map = new HashMap<String, String>();
		if(index!=-1) {
			String[] search_field = new String[] {"subject", "content"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%"+ search_word+"%");
		}
		return dao.getInqueryListCount(map);
	}
	@Override
	public void insertInquery(Inquery inquery) {
		dao.insertInquery(inquery);
		
	}
	@Override
	public int setInquiryReadCountUpdate(int num) {
		return dao.setInquiryReadCountUpdate(num);
		
	}
	@Override
	public Inquery getInquiryDetail(int num) {
	    return dao.getInquiryDetail(num);
	}
	@Override
	public boolean isBoardWriter(int inquery_num, String inquery_pass) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("inquery_pass", inquery_pass);
		map.put("inquery_num", inquery_num);
		
		Inquery result = dao.isBoardWriter(map);
		if(result==null)
			return false;
		else
			return true;
	}
	@Override
	public int inqueryModify(Inquery inquery) {
		return dao.inqueryModify(inquery);
	}
	@Override
	public int inqueryDelete(int num) {
		int result=0;
		Inquery inquery = dao.getInquiryDetail(num);
		if(inquery!=null) {
			result=dao.inqueryDelete(inquery);
		}
		return result;
	}
	@Override
	public int inqueryReply(Inquery inquery) {
		inqueryReplyUpdate(inquery);
		inquery.setInquery_re_lev(inquery.getInquery_re_lev()+1);
		inquery.setInquery_re_seq(inquery.getInquery_re_seq()+1);
		return dao.inqueryReply(inquery);
	}
	
	public int inqueryReplyUpdate(Inquery inquery) {
		return dao.inqueryReplyUpdate(inquery);
	}

}
