package com.crawler.action.book;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Book;
import com.crawler.service.BookService;
import com.opensymphony.xwork2.ActionContext;

@Controller
public class FindBookAction {
	@Resource
	BookService service;

	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String execute() {
		ActionContext ctx = ActionContext.getContext();

		id = id.replace("book", "");
		Book b = service.find(Integer.parseInt(id));

		ctx.put("book", b);
		return "success";
	}
}