package com.quantom.audition.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Article;

@Mapper
public interface ArticleDao {

	public List<Article> getForPrintArticles();

	public Article getForPrintArticleById(@Param(value = "id") int id);
	
}
