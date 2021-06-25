package com.quantom.audition.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.ArticleDao;
import com.quantom.audition.dto.Article;
import com.quantom.audition.dto.ArticleReply;
import com.quantom.audition.dto.Member;
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
	
	public int writeReply(Map<String, Object> param) {
		articleDao.writeReply(param);

		return Util.getAsInt(param.get("id"));
	}
	
	public List<ArticleReply> getForPrintArticleReplies(Map<String, Object> param) {
		List<ArticleReply> articleReplies = articleDao.getForPrintArticleReplies(param);
	
		Member actor = (Member)param.get("actor");
		
		for ( ArticleReply articleReply : articleReplies) {
			//출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, articleReply);
		}
		
		return articleReplies;
	}

	private void updateForPrintInfo(Member actor, ArticleReply articleReply) {
		articleReply.getExtra().put("actorCanDelete", actorCanDelete(actor,articleReply));
		articleReply.getExtra().put("actorCanUpdate", actorCanUpdate(actor,articleReply));	
	}
	
	private Object actorCanUpdate(Member actor, ArticleReply articleReply) {
		return actor != null && actor.getId() == articleReply.getMemberId()? true : false;
	}

	private Object actorCanDelete(Member actor, ArticleReply articleReply) {
		return actorCanUpdate(actor, articleReply);
	}

	public void doDeleteArticleReplyAjax(int id) {
		articleDao.doDeleteArticleReplyAjax(id);
		
	}
	
}
