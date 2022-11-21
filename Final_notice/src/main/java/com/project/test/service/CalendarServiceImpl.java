package com.project.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.test.domain.Planner;
import com.project.test.mybatis.mapper.CalendarMapper;
@Service
public class CalendarServiceImpl implements CalendarService{
	private CalendarMapper dao;
	
	@Autowired
	public CalendarServiceImpl(CalendarMapper dao) {
		this.dao = dao;
	}
	
	@Override
	public List<Planner> getCalendarList(String group_no) {
		return dao.getCalendarList(group_no);
	}

	@Override
	public Planner getCalendarDetail(String calendar_no) {
		return dao.getCalendarDetail(calendar_no);
	}

	@Override
	public int CalendarAdd(Planner calendar) {
		return dao.CalendarAdd(calendar);
	}

	@Override
	public int CalendarDelete(int calendar_no) {
		return dao.CalendarDelete(calendar_no);
	}

	@Override
	public int CalendarModify(Planner calendar) {
		return dao.CalendarModify(calendar);
	}

	@Override
	public int CalendarModifyDate(String startdate, int calendar_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startdate", startdate);
		map.put("calendar_no", calendar_no);
		return dao.CalendarModifyDate(map);
	}
}
