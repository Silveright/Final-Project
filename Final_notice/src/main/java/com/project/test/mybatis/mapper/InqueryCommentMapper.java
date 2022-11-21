package com.project.test.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.test.domain.Comment;
import com.project.test.domain.InquiryComment;
@Mapper
public interface InqueryCommentMapper {

	//글의 갯수 구하기
	public int getListCount(int comment_inquery_num);
	
	//댓글 목록 가져오기
	public List<InquiryComment> getCommentList(Map<String, Integer> map);
	
	//댓글 등록하기
	public int commentsInsert(InquiryComment c);
	
	//댓글 삭제
	public int commentsDelete(int num);
	
	//댓글 수정
	public int commentsUpdate(InquiryComment co);

	public int commentsReply(InquiryComment co);

	public int commentsReplyUpdate(InquiryComment co);

}
