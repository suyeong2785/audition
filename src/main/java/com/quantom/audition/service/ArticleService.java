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
	
	public int writeReply(Map<String, Object> param) {
		articleDao.writeReply(param);

		return Util.getAsInt(param.get("id"));
	}
	
	public List<Reply> getForPrintReplies(@RequestParam Map<String, Object> param) {
		List<Reply> replies = articleDao.getForPrintReplies(param);
	
		Member actor = (Member)param.get("actor");
		
		for ( Reply reply : replies ) {
			//출력용 부가데이터를 추가한다.
			updateForPrintInfo(actor, reply);
		}
		
		return replies;
	}

	private void updateForPrintInfo(Member actor, Reply reply) {
		reply.getExtra().put("actorCanDelete", actorCanDelete(actor, reply));
		reply.getExtra().put("actorCanModify", actorCanModify(actor, reply));
	}
	
	public boolean actorCanModify(Member actor, Reply reply) {
		return actor != null && actor.getId() == reply.getMemberId() ? true : false;
	}

	public boolean actorCanDelete(Member actor, Reply reply) {
		return actorCanModify(actor, reply);
	}

	public void deleteReply(int id) {
		articleDao.deleteReply(id);
		
	}
	
	public Reply getForPrintReplyById(int id) {
		return articleDao.getForPrintReplyById(id);
	}

	public ResultData modfiyReply(Map<String, Object> param) {
		articleDao.modifyReply(param);
		return new ResultData("S-1", String.format("%d번 댓글을 수정하였습니다.", Util.getAsInt(param.get("id"))), param);
	}
	
	
	
}
