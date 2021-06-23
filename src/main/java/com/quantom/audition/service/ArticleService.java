package com.quantom.audition.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.ArticleDao;
import com.quantom.audition.dto.Article;

@Service
public class ArticleService {
	@Autowired
	ArticleDao articleDao;
	
	public List<Article> getArticles() {
		return articleDao.getArticles();
	}
	
}
