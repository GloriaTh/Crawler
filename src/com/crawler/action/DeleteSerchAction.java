package com.crawler.action;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.CrawlerService;
import com.crawler.utils.GeneralMethod;

@Controller
public class DeleteSerchAction {
	@Resource
	CrawlerService service;

	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void execute() {
		try {
			String[] ids = id.split(",");

			service.Moredelete(ids);
		} catch (Exception e) {
			e.printStackTrace();
			GeneralMethod.BackMessage("发生错误");
		}
	}
}