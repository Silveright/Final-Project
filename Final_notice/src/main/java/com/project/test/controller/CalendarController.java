package com.project.test.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.test.domain.Planner;
import com.project.test.service.CalendarService;

@Controller
@RequestMapping(value="/calendar")
public class CalendarController {
	private static final Logger logger = LoggerFactory.getLogger(CalendarController.class);
	private CalendarService calendarService;
	
	@Autowired
	public CalendarController(CalendarService calendarService) {
		this.calendarService = calendarService;
	}
	
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public ModelAndView view(@RequestParam("group_no") String group_no, ModelAndView mv) {
		logger.info("모임번호는"+group_no);
		mv.addObject("group_no",group_no);
		mv.setViewName("calendar/calendar");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/loadevent", method = RequestMethod.GET)////달력 일정 로딩
    public List<Planner> calendarlist(@RequestParam("group_no") String group_no) {
		logger.info("모임번호는"+group_no);
        List<Planner> list = calendarService.getCalendarList(group_no);
        return list;
    }

	@ResponseBody
	@RequestMapping(value = "/detail", method = RequestMethod.GET)//세부일정 정보 확인
	public Planner calendarDetail(@RequestParam("group_no") String group_no,
										  @RequestParam("calendar_no") String calendar_no) {
		Planner calendar = calendarService.getCalendarDetail(calendar_no);
		logger.info("시작시간"+calendar.getStartdate());
		return calendar;
	}

	@ResponseBody
	@RequestMapping(value = "/add", method = RequestMethod.POST)//일정 추가
	public int calendarAdd(Planner calendar) {
		return calendarService.CalendarAdd(calendar);
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.GET)//일정 삭제
	public int calendarDelete(@RequestParam("calendar_no") int calendar_no) {
		return calendarService.CalendarDelete(calendar_no);
	}

	@ResponseBody
	@RequestMapping(value = "/modify", method = RequestMethod.POST)//일정 수정
	public int calendarModify(Planner calendar) {
		return calendarService.CalendarModify(calendar);
	}

	@ResponseBody
	@RequestMapping(value = "/modifydate", method = RequestMethod.POST)//일정 날짜 변경
	public int calendarModifyDate(String startdate, int calendar_no) {
		logger.info("일정번호"+calendar_no);
		return calendarService.CalendarModifyDate(startdate,calendar_no);
	}
}
