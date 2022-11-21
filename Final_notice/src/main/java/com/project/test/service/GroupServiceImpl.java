package com.project.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.test.domain.Group;
import com.project.test.domain.GroupJoin;
import com.project.test.domain.GroupUser;
import com.project.test.domain.Group_Board;
import com.project.test.domain.Search;
import com.project.test.domain.UserGroup;
import com.project.test.mybatis.mapper.GroupAdminMapper;
import com.project.test.mybatis.mapper.GroupMapper;

@Service
public class GroupServiceImpl implements GroupService {

	private GroupAdminMapper dao;
	private GroupMapper gdao;
	private static final Logger logger = LoggerFactory.getLogger(GroupServiceImpl.class);

	@Autowired
	public GroupServiceImpl(GroupAdminMapper dao, GroupMapper gdao) {
		this.dao = dao;
		this.gdao = gdao;
	}

	@Override
	public int acceptmembers(List<String> requestList, int group_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("requestid", requestList);
		map.put("group_no", group_no);
		dao.acceptMember(map);
		dao.deleteRequest(map);

		return 1;
	}

	@Override
	public int getJoinListCount(int group_no) {
		// TODO Auto-generated method stub
		return dao.getJoinListCount(group_no);
	}

	@Override
	public List<GroupJoin> getJoinList(int group_no, int page, int limit) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_no", group_no);
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getJoinList(map);
	}

	@Override
	public int getUserSearchListCount(int index, String search_word, int group_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_no", group_no);
		if (index != -1) {
			String[] search_field = new String[] {"userid", "area_name", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		logger.info(search_word);
		return dao.getUserSearchListCount(map);
	}

	@Override
	public List<GroupUser> getUserSearchList(int index, String search_word, int page, int limit, int group_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_no", group_no);
		if (index != -1) {
			String[] search_field = new String[] {"userid", "area_name", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return dao.getUserSearchList(map);
	}

	@Override
	public int getSearchListCount(int index, String search_word) {
		// TODO Auto-generated method stub
		return 0;
	}

	//=======================================================================	
		//모임 생성
		@Override
		public void insertGroup(Group group) {
			gdao.insertGroup(group);
			
		}
		
		@Override
		public boolean isGroupWriter(int num, String userid) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("num", num);
			map.put("userid", userid);
			Group result = gdao.isGroupWriter(map);
			if(result==null)
				return false;
			else
				return true;
		}


		@Override
		public List<String> getDeleteFileList() {
			// TODO Auto-generated method stub
			return null;
		}

		@Override
		public void deleteFileList(String filename) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public List<Group> getGroupList(int page, int limit) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			int startrow = (page - 1) * limit + 1;
			int endrow = startrow + limit - 1;
			map.put("start", startrow);
			map.put("end", endrow);
			return gdao.getGroupList(map);
		}
		
		@Override
		public List<Group> getNewGroupList(int page, int limit) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			int startrow = (page - 1) * limit + 1;
			int endrow = startrow + limit - 1;
			map.put("start", startrow);
			map.put("end", endrow);
			return gdao.getNewGroupList(map);
		}

		@Override
		public List<Group> getBestGroupList(int page, int limit) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			int startrow = (page - 1) * limit + 1;
			int endrow = startrow + limit - 1;
			map.put("start", startrow);
			map.put("end", endrow);
			return gdao.getBestGroupList(map);
		}
		
		@Override
		public int getListCount() {
			return gdao.getListCount();
		}


		@Override
		public Group getDetail(int num) {
			return gdao.getDetail(num);
		}
		


		@Override
		public int getListCount(int num) {
			return gdao.getListCount();
		}

		@Override
		public GroupUser getUserRole(int group_no, String userid) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("group_no", group_no);
			map.put("userid", userid);
			return gdao.getUserRole(map);
		}

		@Override
		public int getMemberCount(int num) {
			// TODO Auto-generated method stub
			return gdao.getMemberCount(num);
		}

		@Override
		public void insert(String userid, int group_no) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("group_no", group_no);
			map.put("userid", userid);
			gdao.insert(map);
		}

		@Override
		public List<Group_Board> getGroupBoardList(int page, int limit, int group_no) {
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			int startrow = (page - 1) * limit + 1;
			int endrow = startrow + limit - 1;
			map.put("start", startrow);
			map.put("end", endrow);
			map.put("group_no", group_no);
			return gdao.getGroupBoardList(map);
		}

		@Override
		public int getBoardListCount(int group_no) {
			return gdao.getBoardListCount(group_no);
		}

		@Override
		public void insertBoard(Group_Board groupboard) {
			gdao.insertBoard(groupboard);
			
		}

		@Override
		public int setReadCountUpdate(int num) {
			return gdao.setReadCountUpdate(num);
			
		}

		@Override
		public Group_Board getBoardDetail(int num) {
			return gdao.getBoardDetail(num);
		}

		@Override
		public boolean isBoardWriter(int board_NUM, String board_PASS) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("num", board_NUM);
			map.put("pass", board_PASS);
			Group_Board result = gdao.isBoardWriter(map);
			if(result==null)
				return false;
			else
				return true;
		}

		@Override
		public int boardModify(Group_Board boarddata) {
			return  gdao.boardModify(boarddata);
		}

		@Override
		public int boardDelete(int num) {
			int result = 0;
			Group_Board groupboard = gdao.getBoardDetail(num);
			if(groupboard != null ) {
				result = gdao.boardDelete(groupboard);
			}
			return result;
		}

		
		
		@Override
		public List<UserGroup> getUserGroup(String userid) {
			// TODO Auto-generated method stub
			return gdao.getUserGroup(userid);
		}

		@Override
		public int getUserJoin(int group_no, String userid) {
			GroupUser user = gdao.getUserJoin(group_no, userid);
			return (user==null) ? -1 : 1;
		}

		@Override
		public int getUserGroupCount(String userid) {
			// TODO Auto-generated method stub
			return gdao.getUserGroupCount(userid);
		}
		
		//모임 생성시 모임장 구분
		@Override
		public boolean isGroupWriter(int group_no) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("group_no", group_no);
			Group result = gdao.isGroupWriter(map);
			if(result==null)
				return false;
			else
				return true;
		}
		
		//모입 수정
		@Override
		public int groupModify(Group modifygroup) {
			return  gdao.groupModify(modifygroup);
		}

		//모임 삭제
		@Override
		public int groupDelete(int num) {
			int result = 0;
			Group group = gdao.getDetail(num);
			if(group != null ) {
				result = gdao.groupDelete(group);
			}
			return result;
		}
		
		

		

	

		@Override
		public void groupuserdelete(String userid, int group_no) {
			gdao.groupuserdelete(userid, group_no);
			
		}

		@Override
		public int getSearchListCount(String index, String search_keyword) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			if(!index.equals("")) {
				map.put("search_field", index);
				map.put("search_word", "%" + search_keyword + "%");
			}
			logger.info(map.get("search_field") + "");
			return gdao.getSearchListCount(map);
		}

		@Override
		public List<Search> getSearchList(String index, String search_keyword, int page, int limit) {
			Map<String, Object> map = new HashMap<String, Object>();
			//http://localhost:8088/myhome4/member/list로 접속하는 경우
			//select를 선택하지 않아 index는 "-1"의 값을 갖습니다.
			//이 경우 아래의 문장을 수행하지 않기 때문에 "search_field" 키에 대한
			//map.get("search_field")의 값은 null이 됩니다.
			if(!index.equals("")) {
				map.put("search_field", index);
				map.put("search_word", "%" + search_keyword + "%");
			}
			int startrow = (page - 1) * limit + 1;
			int endrow = startrow + limit - 1;
			map.put("start", startrow);
			map.put("end", endrow);
			return gdao.getSearchList(map);
		}

		@Override
		public void grouproleupdate(String userid, String manager, int group_no) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userid", userid);
			map.put("manager", manager);
			map.put("group_no", group_no);
			gdao.grouproleupdate(map);
		}


}