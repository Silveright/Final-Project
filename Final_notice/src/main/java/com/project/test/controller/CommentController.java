package com.project.test.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.test.domain.Comment;
import com.project.test.service.CommentService;

@Controller
@RequestMapping(value = "/comment")
public class CommentController {
	
	private CommentService commentService;
	
	@Autowired
	public CommentController(CommentService commentService) {
		this.commentService=commentService;
	}
	
	/*
	 * ResponseBody와 jackson을 이용하여 JSON 사용하기
	 */
	@ResponseBody
	@PostMapping(value = "/list")
	public Map<String, Object> CommentList(int board_num, int page) {
		List<Comment> list = commentService.getCommentList(board_num, page);
		int listcount = commentService.getListCount(board_num);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("listcount", listcount);
		return map;
	}
	
	@ResponseBody
	@PostMapping(value = "/add")
	public int CommentAdd(Comment co) {
		return commentService.commentsInsert(co);
	}
	
	@ResponseBody
	@PostMapping(value = "/update")
	public int CommentUpdate(Comment co) {
		return commentService.commentsUpdate(co);
	}
	
	@ResponseBody
	@PostMapping(value = "/delete")
	public int CommentDelete(int num) {
		return commentService.commentsDelete(num);
	}
}
