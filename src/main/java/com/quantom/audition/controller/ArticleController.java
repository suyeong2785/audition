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
import com.quantom.audition.dto.ArticleReply;
import com.quantom.audition.dto.ResultData;
import com.quantom.audition.service.ArticleService;

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
		int newArticleReplyId = articleService.writeReply(param);
		rsDataBody.put("articleReplyId", newArticleReplyId);

		return new ResultData("S-1", String.format("%d번 댓글이 생성되었습니다.", newArticleReplyId), rsDataBody);
	}
	
	@RequestMapping("/usr/article/getForPrintArticleReplies")
	@ResponseBody
	public ResultData getForPrintArticleReplies(@RequestParam Map<String, Object> param) {
		Map<String, Object> rsDataBody = new HashMap<>();
		
		List<ArticleReply> articleReplies = articleService.getForPrintArticleReplies(param);
		rsDataBody.put("articleReplies", articleReplies);

		return new ResultData("S-1", String.format("%d개의 댓글을 불러왔습니다.", articleReplies.size()), rsDataBody);
	}
	
	@RequestMapping("/usr/article/doDeleteArticleReplyAjax")
	@ResponseBody
	public ResultData doDeleteArticleReplyAjax(int id) {
		
		articleService.doDeleteArticleReplyAjax(id);

		return new ResultData("S-1", String.format("%d번 댓글을 삭제했습니다.",id),id);
	}
	
}
