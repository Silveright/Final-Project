package com.project.test.service;

import java.util.List;


import com.project.test.domain.Group;
import com.project.test.domain.GroupJoin;
import com.project.test.domain.GroupUser;
import com.project.test.domain.Group_Board;
import com.project.test.domain.Search;
import com.project.test.domain.UserGroup;

public interface GroupService {

	int getSearchListCount(int index, String search_word);

	int getJoinListCount(int group_no);

	List<GroupJoin> getJoinList(int group_no, int page, int limit);

	int acceptmembers(List<String> requestList, int group_no);
	
	//모임 생성
	public void insertGroup(Group group);
	
	public List<String> getDeleteFileList();

	public void deleteFileList(String filename);
	
	//모임장인지 확인
	public boolean isGroupWriter(int num, String userid);
	
	//그룹 리스트
	public List<Group> getGroupList(int page, int limit);
		
	//New그룹 리스트
	public List<Group> getNewGroupList(int page, int limit);
		
	//Best그룹 리스트
	public List<Group> getBestGroupList(int page, int limit);

	public int getListCount();

	public Group getDetail(int num);

	public int getListCount(int num);

	GroupUser getUserRole(int group_no, String userid);

	int getMemberCount(int num);
	
	//모임 가입 신청
	public void insert(String userid, int group_no);

	//public List<Group_Board> getGroupBoardList(int page, int limit);

	public int getBoardListCount(int group_no);

	void insertBoard(Group_Board groupboard);

	int setReadCountUpdate(int num);

	Group_Board getBoardDetail(int num);

	boolean isBoardWriter(int board_NUM, String board_PASS);

	int boardModify(Group_Board boarddata);

	int boardDelete(int num);

	List<Group_Board> getGroupBoardList(int page, int limit, int group_no);

	List<UserGroup> getUserGroup(String userid);

	int getUserJoin(int group_no, String userid);

	int getUserGroupCount(String userid);

	void groupuserdelete(String userid, int group_no);

	int getSearchListCount(String index, String search_keyword);

	List<Search> getSearchList(String index, String search_keyword, int page, int limit);

	//모임 수정처리 
	boolean isGroupWriter(int group_no);

	//모임 수정
	public int groupModify(Group modifygroup);
	
	//모임 삭제
	public int groupDelete(int num);

	int getUserSearchListCount(int index, String search_word, int group_no);

	List<GroupUser> getUserSearchList(int index, String search_word, int page, int limit, int group_no);

	void grouproleupdate(String userid, String manager, int group_no);
	

}
