package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.ArticleService;
import com.example.demo.vo.Article;

import java.util.List;

@Controller
public class UsrHomeController {

	@Autowired
	private ArticleService articleService;

	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		// 공지사항 최신 게시글 3개 가져오기
		List<Article> articles = articleService.getForPrintArticles(1, 3, 1, "title,body", "");
		model.addAttribute("articles", articles);

		// 축제후기 최신 게시글 3개 가져오기
		List<Article> articlesFestival = articleService.getForPrintArticles(3, 3, 1, "title,body", "");
		model.addAttribute("articlesFestival", articlesFestival);

		return "/usr/home/main";
	}

	@RequestMapping("/usr/home/siteintro")
	public String showIntro() {
		return "/usr/home/siteintro";
	}

	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
}
