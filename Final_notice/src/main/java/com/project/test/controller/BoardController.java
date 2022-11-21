package com.project.test.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class BoardController {

	@RequestMapping("/board_main")
	public ModelAndView board_main() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/board_main");
		return mv;
	}
	
	@RequestMapping(value="/board_main", method =RequestMethod.GET)
	public ModelAndView board_main(ModelAndView mv) {
		mv.setViewName("board/board_main");
		return mv;
	}
	
}
