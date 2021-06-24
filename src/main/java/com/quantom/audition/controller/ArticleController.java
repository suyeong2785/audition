package com.quantom.audition.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.quantom.audition.dto.Article;
import com.quantom.audition.service.ArticleService;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	
	@RequestMapping("/article/list")
	public String showArticles (Model model) {
		
		List<Article> articles = articleService.getArticles();
		
		model.addAttribute("articles",articles);
		
		return "article/list";
	}
}
