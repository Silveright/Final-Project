package com.project.test.service;

import java.util.List;

import com.project.test.domain.*;

public interface MemberService {
	
	public int isId(String id, String password);
	
	public int insert(Member m);
	
	public int isId(String id);
	
	public Member member_info(String id);
	
	public void delete(String id);
	
	public int update(Member m);
	
	public List<Member> getSearchList(int index, String search_word,
									  int page, int limit);
	
	public int getSearchListCount(int index, String search_word);
	
	//채팅유저이름 
	public String username(String id);

	//모임 생성시 유저 정보
	public Member userInfoBasic(String userid); 
}
