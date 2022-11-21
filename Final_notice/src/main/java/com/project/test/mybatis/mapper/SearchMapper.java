package com.project.test.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.project.test.domain.*;

@Mapper
public interface SearchMapper {
	
	public int getSearchListCount(Map<String, Object> map) ;

	public List<Search> getSearchList(Map<String, Object> map) ;
	
}
