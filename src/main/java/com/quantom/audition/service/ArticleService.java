package com.quantom.audition.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quantom.audition.dao.ArticleDao;
import com.quantom.audition.dto.Article;
import com.quantom.audition.dto.ArticleReply;
import com.quantom.audition.dto.Member;
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
		articleReply.getExtra().put("actorCanModify", actorCanModify(actor,articleReply));	
	}
	
	public boolean actorCanModify(Member actor, ArticleReply articleReply) {
		return actor != null && actor.getId() == articleReply.getMemberId()? true : false;
	}

	public boolean actorCanDelete(Member actor, ArticleReply articleReply) {
		return actorCanModify(actor, articleReply);
	}

	public void deleteReply(int id) {
		articleDao.deleteReply(id);
		
	}
	
	public ArticleReply getForPrintArticleReplyById(int id) {
		return articleDao.getForPrintArticleReplyById(id);
	}

	public ResultData modfiyReply(Map<String, Object> param) {
		articleDao.modifyReply(param);
		return new ResultData("S-1", String.format("%d번 댓글을 수정하였습니다.", Util.getAsInt(param.get("id"))), param);
	}
	
	
	
}
