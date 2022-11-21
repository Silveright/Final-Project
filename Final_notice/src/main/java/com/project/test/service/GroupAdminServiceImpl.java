package com.project.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.project.test.domain.Group;
import com.project.test.domain.GroupJoin;
import com.project.test.domain.GroupUser;
import com.project.test.mybatis.mapper.GroupAdminMapper;
import com.project.test.mybatis.mapper.GroupMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service
public class GroupAdminServiceImpl implements GroupAdminService{
	
	
	private GroupAdminMapper dao;
	private static final Logger logger = LoggerFactory.getLogger(GroupAdminServiceImpl.class);
	
	@Autowired
	public GroupAdminServiceImpl(GroupAdminMapper dao) {
		this.dao = dao;
	}
	@Override
	public List<GroupUser> getUserSearchList(int index, String search_word, int page, int limit, int group_no, String userid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_no", group_no);
		map.put("userid", userid);
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
	@Transactional
	public int acceptmembers(List<String> requestList, int group_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("requestid", requestList);
		map.put("group_no", group_no);
		dao.acceptMember(map);
		deleteRequest(map);
		return deleteRequest(map);
	}
	
	public int deleteRequest(Map<String, Object> map ) {
		int result = dao.deleteRequest(map);
		return result;
	}

	@Override
	public void groupuserdelete(String userid, int group_no) {
		dao.groupuserdelete(userid, group_no);
		
	}

	@Override
	public int groupDelete(int num) {
		int result = 0;
		Group group = dao.getDetail(num);
		if(group != null ) {
			result = dao.groupDelete(group);
		}
		return result;
	}

	@Override
	public Group getDetail(int num) {
		// TODO Auto-generated method stub
		return dao.getDetail(num);
	}

	@Override
	public int groupModify(Group modifygroup) {
		return  dao.groupModify(modifygroup);
	}

	@Override
	public void grouproleupdate(String userid, String manager, int group_no) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userid", userid);
		map.put("manager", manager);
		map.put("group_no", group_no);
		dao.grouproleupdate(map);
		
	}


	@Override
	public int getUserSearchListCount(int index, String search_word, int group_no, String userid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("group_no", group_no);
		map.put("userid", userid);
		if (index != -1) {
			String[] search_field = new String[] {"userid", "area_name", "gender"};
			map.put("search_field", search_field[index]);
			map.put("search_word", "%" + search_word + "%");
		}
		return dao.getUserSearchListCount(map);
	}
	
}
