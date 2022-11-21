package com.project.test.mybatis.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.test.domain.*;

@Mapper
public interface GroupMapper {
	//모임 생성
    public void insertGroup(Group Group);

	public List<Group> getGroupList(HashMap<String, Integer> map);
	
	public List<Group> getNewGroupList(HashMap<String, Integer> map);
	
	public List<Group> getBestGroupList(HashMap<String, Integer> map);

	public int getListCount();

	public Group getDetail(int num);

	public GroupUser getUserRole(HashMap<String, Object> map);

	public int getMemberCount(int num);

	public void insert(HashMap<String, Object> map);

	public List<Group_Board> getGroupBoardList(HashMap<String, Integer> map);

	public int getBoardListCount(int group_no);

	public void insertBoard(Group_Board groupboard);

	public int setReadCountUpdate(int num);

	public Group_Board getBoardDetail(int num);

	public int boardModify(Group_Board boarddata);

	public Group_Board isBoardWriter(HashMap<String, Object> map);

	public int boardDelete(Group_Board groupboard);
	
	public List<UserGroup> getUserGroup(String userid);

	public GroupUser getUserJoin(int group_no, String userid);
	
	public int getUserGroupCount(String userid);

	public Group isGroupWriter(HashMap<String, Object> map);
	
	public int groupModify(Group modifygroup);

	public int groupDelete(Group group);
	
	public void groupuserdelete(String userid, int group_no);

	public int getSearchListCount(HashMap<String, Object> map);

	public List<Search> getSearchList(Map<String, Object> map);

	public void grouproleupdate(Map<String, Object> map);

}
