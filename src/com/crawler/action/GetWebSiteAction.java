package com.crawler.action;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.WebSite;
import com.crawler.service.CrawlerService;
import com.crawler.utils.GeneralMethod;

@Controller
public class GetWebSiteAction {
	@Resource
	CrawlerService service;

	public void execute() {
		List<WebSite> list = service.webList();
		GeneralMethod.BackList(list);
	}
}
