package com.project.test.service;

import java.util.List;
import java.util.Map;

import com.project.test.domain.Group;
import com.project.test.domain.GroupJoin;
import com.project.test.domain.GroupUser;

public interface GroupAdminService {
	
	List<GroupUser> getUserSearchList(int index, String search_word,int page, int limit, int group_no, String userid);
	
	int getUserSearchListCount(int index, String search_word, int group_no, String userid);

	int getJoinListCount(int group_no);
	
	List<GroupJoin> getJoinList(int group_no, int page, int limit);
	
	int acceptmembers(List<String> requestList, int group_no);
	
	void groupuserdelete(String userid, int group_no);
	
	public int groupDelete(int num);
	
	public Group getDetail(int num);
	
	public int groupModify(Group modifygroup);
	
	void grouproleupdate(String userid, String manager, int group_no);
	
	int deleteRequest(Map<String, Object> map);

}
