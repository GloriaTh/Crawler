package com.crawler.dao;

import java.util.List;

import com.crawler.bean.WebSite;

public interface CrawlerDao {
	public List<WebSite> webList();

	public List<Object[]> serch(String string, String string2);

}
