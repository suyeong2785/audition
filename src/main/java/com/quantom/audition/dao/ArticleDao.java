package com.quantom.audition.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.quantom.audition.dto.Article;
import com.quantom.audition.dto.ArticleReply;

@Mapper
public interface ArticleDao {

	List<Article> getForPrintArticles();

	Article getForPrintArticleById(@Param(value = "id") int id);

	void write(Map<String, Object> param);

	List<ArticleReply> getForPrintArticleReplies(Map<String, Object> param);

	void writeReply(Map<String, Object> param);
	
}
