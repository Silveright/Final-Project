package com.project.test.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.test.domain.Planner;
@Mapper
public interface CalendarMapper {

	List<Planner> getCalendarList(String group_no);

	Planner getCalendarDetail(String calendar_no);

	int CalendarAdd(Planner calendar);

	int CalendarDelete(int calendar_no);

	int CalendarModify(Planner calendar);

	int CalendarModifyDate(Map<String, Object> map);

}
