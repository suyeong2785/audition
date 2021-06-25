package com.quantom.audition.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.dao.ArticleDao;
import com.quantom.audition.dto.Article;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Reply;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.util.Util;

@Service
public class ArticleService {
	@Autowired
	ArticleDao articleDao;
	
	public List<Article> getForPrintArticles() {
		return articleDao.getForPrintArticles();
	}

	public Article getForPrintArticleById(int id) {
		return articleDao.getForPrintArticleById(id);
	}

	public int write(Map<String, Object> param) {
		articleDao.write(param);

		return Util.getAsInt(param.get("id"));
	}

}
