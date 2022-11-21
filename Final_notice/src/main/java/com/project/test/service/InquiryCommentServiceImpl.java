package com.project.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.test.domain.Comment;
import com.project.test.domain.InquiryComment;
import com.project.test.mybatis.mapper.CommentsMapper;
import com.project.test.mybatis.mapper.InqueryCommentMapper;
@Service
public class InquiryCommentServiceImpl implements InquiryCommentService{
	
	@Autowired
	private InqueryCommentMapper dao;
	
	
	@Autowired
	public InquiryCommentServiceImpl(InqueryCommentMapper dao) {
		this.dao = dao;
	}

	@Override
	public int getListCount(int comment_inquery_num) {
		return dao.getListCount(comment_inquery_num);
	}

	@Override
	public List<InquiryComment> getCommentList(int comment_inquery_num, int state, int page) {
		int startrow=1;
		int endrow=page*3;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("comment_inquery_num", comment_inquery_num);
		map.put("state", state);
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getCommentList(map);
	}

	@Override
	public int commentsInsert(InquiryComment c) {
		return dao.commentsInsert(c);
	}

	@Override
	public int commentsDelete(int num) {
		return dao.commentsDelete(num);
	}

	@Override
	public int commentsUpdate(InquiryComment co) {
		return dao.commentsUpdate(co);
	}

	@Override
	public int commentsReply(InquiryComment co) {
		commentsReplyUpdate(co);
		co.setComment_re_lev(co.getComment_re_lev()+1);
		co.setComment_re_seq(co.getComment_re_seq()+1);
		return dao.commentsReply(co);
	}

	public int commentsReplyUpdate(InquiryComment co) {
		// TODO Auto-generated method stub
		return dao.commentsReplyUpdate(co);
	}
}
