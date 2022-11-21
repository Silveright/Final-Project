package com.project.test.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.test.domain.Search;
import com.project.test.mybatis.mapper.SearchMapper;

@Service
public class SearchServiceImpl implements SearchService {

	private SearchMapper sdao;
	private static final Logger logger = LoggerFactory.getLogger(SearchServiceImpl.class);

	@Autowired
	public SearchServiceImpl(SearchMapper sdao) {
		this.sdao = sdao;
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
			map.put("search_keyword", "%" + search_keyword + "%");
		}
		int startrow = (page - 1) * limit + 1;
		int endrow = startrow + limit - 1;
		map.put("start", startrow);
		map.put("end", endrow);
		return sdao.getSearchList(map);
	}

	//search_field=경기&search_keyword=음악
	@Override
	public int getSearchListCount(String index, String search_keyword) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(!index.equals("")) {
			map.put("search_field", index);
			map.put("search_keyword", "%" + search_keyword + "%");
		}
		return sdao.getSearchListCount(map);
	}


}