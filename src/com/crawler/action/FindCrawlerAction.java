package com.crawler.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.BookService;
import com.crawler.service.CrawlerService;
import com.crawler.service.CsdnService;
import com.crawler.service.SongService;
import com.opensymphony.xwork2.ActionContext;

@Controller
public class FindCrawlerAction {
	@Resource
	CrawlerService service;
	@Resource
	SongService songservice;
	@Resource
	BookService bookservice;
	@Resource
	CsdnService csdnservice;

	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String execute() {
		ActionContext ctx = ActionContext.getContext();

		if (id.indexOf("songs") != -1) {
			id = id.replace("songs", "");
			ctx.put("song", songservice.find(Integer.parseInt(id)));
			return "song";
		} else if (id.indexOf("books") != -1) {
			id = id.replace("books", "");
			ctx.put("book", bookservice.find(Integer.parseInt(id)));
			return "book";
		} else if (id.indexOf("csdns") != -1) {
			id = id.replace("csdns", "");
			ctx.put("csdn", csdnservice.find(Integer.parseInt(id)));
			return "csdn";
		} else {
			return "error";
		}
	}
}