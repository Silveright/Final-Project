package com.project.test.service;

import java.util.List;

import com.project.test.domain.Planner;

public interface CalendarService {

	List<Planner> getCalendarList(String group_no);

	Planner getCalendarDetail(String calendar_no);

	int CalendarAdd(Planner calendar);

	int CalendarDelete(int calendar_no);

	int CalendarModifyDate(String startdate, int calendar_no);

	int CalendarModify(Planner calendar);

}
