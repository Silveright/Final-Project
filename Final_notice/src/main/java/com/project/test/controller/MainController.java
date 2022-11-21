package com.project.test.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.test.domain.Group;
import com.project.test.domain.UserGroup;
import com.project.test.service.GroupService;

@Controller
@RequestMapping(value="/main")
public class MainController {
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private GroupService groupService;
	/*
	 * @Autowired public GroupController(GroupService groupservice) {
	 * this.groupservice = groupservice; }
	 */
	
	@Autowired
	public MainController(GroupService groupService) {
		this.groupService = groupService;
	}
	
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public ModelAndView main(ModelAndView mv) {
		mv.setViewName("main/main");
		return mv;
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView groupList(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
								  ModelAndView mv) {
		int limit = 12; // 한 화면에 출력할 로우 갯수
		
		int listcount = groupService.getListCount(); // 총 리스트 수를 받아옴
		
		// 총 페이지 수
		int maxpage = (listcount + limit -1) / limit;
		
		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
		int startpage = ((page - 1) / 10) * 10 +1;
		
		// 현재 페이지에 보여줄 마지막 페이지 수(10,20,30 등..)
		int endpage = startpage + 10 -1;
		
		if(endpage > maxpage)
			endpage = maxpage;
		
		List<Group> grouplist = groupService.getGroupList(page, limit); // 리스트를 받아옴
		List<Group> newgrouplist = groupService.getNewGroupList(page, limit); // NEW리스트를 받아옴
		List<Group> bestgrouplist = groupService.getBestGroupList(page, limit); // BEST리스트를 받아옴
		
		mv.setViewName("main/main");
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("grouplist", grouplist);
		mv.addObject("newgrouplist", newgrouplist);
		mv.addObject("bestgrouplist", bestgrouplist);
		mv.addObject("limit", limit);
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userid=authentication.getName();
		logger.info(authentication.getName());
		if(userid.equals("anonymousUser")) {
			logger.info("비로그인유저");
		} else {
			List<UserGroup> usergroup = groupService.getUserGroup(userid);
			mv.addObject("usergroup",usergroup);//GROUP_NO, GROUP_NAME, GROUP_CONTENT, CATENAME, GROUP_USER, GROUP_ROLE
		}
		
		return mv;
	}
	
	// 그룹 참여하기
	@RequestMapping(value="/enter", method=RequestMethod.POST)
	public ModelAndView group_enter(ModelAndView mv) {
		mv.setViewName("group/group_enter");
		
		return mv;
	}
	
}
