package com.project.test.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.test.domain.Search;
import com.project.test.service.GroupService;
import com.project.test.service.MySaveFolder;
import com.project.test.service.SearchService;

@Controller
@RequestMapping(value="/search")
public class SearchController {
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	private SearchService searchService;
	
	
	@Autowired
	public SearchController(SearchService searchService, MySaveFolder mysavefolder, GroupService groupService) {
		this.searchService = searchService;
	}
	
	//search_field=경기&search_keyword=음악
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public ModelAndView searchlist(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
								  @RequestParam(value = "limit", defaultValue = "12", required = false) int limit,
								  ModelAndView mv,
								  @RequestParam(value = "search_field", defaultValue = "", required = false) String index,
								  @RequestParam(value = "search_keyword", defaultValue = "", required = false)
								  String search_keyword) {

		int listcount = searchService.getSearchListCount(index, search_keyword); //총 리스트 수를 받아옵니다.

		List<Search> list = searchService.getSearchList(index, search_keyword, page, limit);

		//총 페이지 수
		int maxpage = (listcount + limit - 1) / limit;

		//현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 ...)
		int startpage = ((page - 1) / 10) * 10 + 1;

		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30 ...)
		int endpage = startpage + 10 - 1;

		if(endpage > maxpage)
			endpage = maxpage;

		mv.setViewName("search/search_list");
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("searchlist", list);
		mv.addObject("search_field", index);
		mv.addObject("search_keyword", search_keyword);
		return mv;
	}
	
	
}
