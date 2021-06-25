package com.quantom.audition.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.quantom.audition.dto.Article;
import com.quantom.audition.dto.Member;
import com.quantom.audition.dto.Reply;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.ArticleService;
import com.quantom.audition.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("usr/article/list")
	public String showArticles (Model model) {
		
		List<Article> articles = articleService.getForPrintArticles();
		
		model.addAttribute("articles",articles);
		
		return "article/list";
	}
	
	@RequestMapping("usr/article/detail")
	public String showArticle (Model model, @RequestParam Map<String, Object> param) {
		
		int id = Integer.parseInt((String)param.get("id"));
		Article article = articleService.getForPrintArticleById(id);
		
		model.addAttribute("article",article);
		
		return "article/detail";
	}
	
	@RequestMapping("usr/article/write")
	public String showWrite() {
		
		return "article/write";
	}
	
	@RequestMapping("usr/article/doWrite")
	public String doWrite(Model model, @RequestParam Map<String, Object> param) {
		
		int newArticleId = articleService.write(param);
		
		String redirectUrl = (String)param.get("redirectUrl");
		redirectUrl = redirectUrl.replace("#id", newArticleId + ""); 
		
		model.addAttribute("id", newArticleId);
		
		return "redirect:" + redirectUrl;
	}
	
	@RequestMapping("/usr/article/doWriteReplyAjax")
	@ResponseBody
	public ResultData doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		Map<String, Object> rsDataBody = new HashMap<>();
		param.put("memberId", request.getAttribute("loginedMemberId"));
		
		param.put("relTypeCode", "article");
		Util.changeMapKey(param, "articleId", "relId");

		int newReplyId = articleService.writeReply(param);
		rsDataBody.put("replyId", newReplyId);
		
		return new ResultData("S-1", String.format("%d번 댓글이 생성되었습니다.", newReplyId), rsDataBody);
	}
	
	@RequestMapping("/usr/article/getForPrintReplies")
	@ResponseBody
	public ResultData getForPrintReplies(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Map<String, Object> rsDataBody = new HashMap<>();
		
		param.put("relTypeCode", "article");
		Util.changeMapKey(param, "articleId", "relId");
		
		param.put("actor", loginedMember);
		List<Reply> replies = articleService.getForPrintReplies(param);
		rsDataBody.put("replies", replies);

		return new ResultData("S-1", String.format("%d개의 댓글을 불러왔습니다.", replies.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/article/doDeleteReplyAjax")
	@ResponseBody
	public ResultData doDeleteReplyAjax(int id, HttpServletRequest req) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Reply reply = articleService.getForPrintReplyById(id);

		if (articleService.actorCanDelete(loginedMember, reply) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 삭제할 권한이 없습니다.", id));
		}

		articleService.deleteReply(id);

		return new ResultData("S-1", String.format("%d번 댓글을 삭제했습니다.",id),id);
	}
	
	@RequestMapping("/usr/article/doModifyReplyAjax")
	@ResponseBody
	public ResultData doModifyReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest req, int id) {
		Member loginedMember = (Member) req.getAttribute("loginedMember");
		Reply reply = articleService.getForPrintReplyById(id);

		if (articleService.actorCanModify(loginedMember, reply) == false) {
			return new ResultData("F-1", String.format("%d번 댓글을 수정할 권한이 없습니다.", id));
		}

		Map<String, Object> modfiyReplyParam = Util.getNewMapOf(param, "id", "body");
		ResultData rd = articleService.modfiyReply(modfiyReplyParam);

		return rd;
	}
	
}
