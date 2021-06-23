package com.quantom.audition.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.quantom.audition.dto.Article;

@Mapper
public interface ArticleDao {

	public List<Article> getArticles();
	
}
