package com.project.test.service;

import java.util.List;


import com.project.test.domain.Search;

public interface SearchService {

	int getSearchListCount(String index, String search_keyword);

	List<Search> getSearchList(String index, String search_keyword, int page, int limit);



}
