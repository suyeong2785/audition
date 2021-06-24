package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Article;

@Mapper
public interface ArticleDao {

	List<Article> getForPrintArticles();

	Article getForPrintArticleById(@Param(value = "id") int id);

	void write(Map<String, Object> param);
	
}
