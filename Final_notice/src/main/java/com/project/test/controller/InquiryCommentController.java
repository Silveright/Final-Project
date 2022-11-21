package com.project.test.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.test.domain.Comment;
import com.project.test.domain.InquiryComment;
import com.project.test.service.InquiryCommentService;

@Controller
@RequestMapping(value = "/inquirycomment")
public class InquiryCommentController {
	
	private InquiryCommentService commentService;
	private static final Logger logger = LoggerFactory.getLogger(InquiryCommentController.class);
	@Autowired
	public InquiryCommentController(InquiryCommentService commentService) {
		this.commentService=commentService;
	}
	
	@ResponseBody
	@PostMapping(value = "/list")
	public Map<String, Object> CommentList(int comment_inquery_num, int state, int page) {
		logger.info("comment_inquery_num은"+comment_inquery_num);
		
		List<InquiryComment> list = commentService.getCommentList(comment_inquery_num, state, page);
		int listcount = commentService.getListCount(comment_inquery_num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("listcount", listcount);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/add")
	public int CommentAdd(InquiryComment co) {
		return commentService.commentsInsert(co);
	}

	@ResponseBody
	@PostMapping(value = "/reply")
	public int CommentReply(InquiryComment co) {
		return commentService.commentsReply(co);
	}
	
	@ResponseBody
	@PostMapping(value = "/update")
	public int CommentUpdate(InquiryComment co) {
		return commentService.commentsUpdate(co);
	}
	
	@ResponseBody
	@GetMapping(value = "/delete")
	public int CommentDelete(int num) {
		return commentService.commentsDelete(num);
	}
}
