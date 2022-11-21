 package com.project.test.controller;

import java.security.Principal;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping(value="/group")
public class ChattController {
	

	@RequestMapping(value="/chatt", method=RequestMethod.GET)
    public ModelAndView chatt(ModelAndView mv,
    		@RequestParam(value="group_no", defaultValue="1",required=false) int group_no,
    		Principal userPrincipal) {
       mv.setViewName("chatt/chatting");
       mv.addObject("group_no",group_no);
       mv.addObject("userid",userPrincipal.getName());
       return mv;
	}
	
}