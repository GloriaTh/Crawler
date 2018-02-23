package com.crawler.service;

import java.util.List;

import com.crawler.bean.WebSite;

public interface CrawlerService {
	public List<WebSite> webList();

	public List<Object[]> serch(String string, int i);

	public void Moredelete(String[] ids);

	
}
