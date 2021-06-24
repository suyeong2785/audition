package com.quantom.audition.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.quantom.audition.dto.Article;
import com.quantom.audition.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/article/list")
	public String showArticles (Model model) {
		
		List<Article> articles = articleService.getForPrintArticles();
		
		model.addAttribute("articles",articles);
		
		return "article/list";
	}
	
	@RequestMapping("/article/detail")
	public String showArticle (Model model, @RequestParam Map<String, Object> param) {
		
		int id = Integer.parseInt((String)param.get("id"));
		Article article = articleService.getForPrintArticleById(id);
		
		model.addAttribute("article",article);
		
		return "article/detail";
	}
	
	@RequestMapping("/article/write")
	public String showWrite() {
		
		return "article/write";
	}
	
	@RequestMapping("/article/doWrite")
	public String doWrite(Model model, @RequestParam Map<String, Object> param) {
		
		int newArticleId = articleService.write(param);
		
		String redirectUrl = (String)param.get("redirectUrl");
		redirectUrl = redirectUrl.replace("#id", newArticleId + ""); 
		
		model.addAttribute("id", newArticleId);
		
		return "redirect:" + redirectUrl;
	}
}
