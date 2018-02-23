package com.crawler.action.book;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.BookService;
import com.crawler.utils.GeneralMethod;

@Controller
public class DeleteBookAllAction {
	@Resource
	BookService service;

	public void execute() {
		service.clear();
		GeneralMethod.BackMessage("success");
	}
}