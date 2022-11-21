package com.project.test.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.test.domain.Group;
import com.project.test.domain.GroupJoin;
import com.project.test.domain.GroupUser;

@Mapper
public interface GroupAdminMapper {



    int getJoinListCount(int group_no);

    List<GroupJoin> getJoinList(Map<String, Object> map);

    void acceptMember(Map<String, Object> map);
    
    int deleteRequest(Map<String, Object> map);

    int getUserSearchListCount(Map<String, Object> map);
    
    List<GroupUser> getUserSearchList(Map<String, Object> map);

	void disagreeMember(Map<String, Object> map);
	
	void groupuserdelete(String userid, int group_no);
	
	Group getDetail(int num);
	
	int groupDelete(Group group);
	
	int groupModify(Group modifygroup);
	
	void grouproleupdate(Map<String, Object> map);





}