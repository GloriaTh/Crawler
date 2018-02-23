package com.crawler.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.WebSite;
import com.crawler.dao.BookDao;
import com.crawler.dao.CrawlerDao;
import com.crawler.dao.CsdnDao;
import com.crawler.dao.SongDao;
import com.crawler.service.CrawlerService;

@Service
@Transactional
public class CrawlerServiceImpl implements CrawlerService {
	@Resource
	CrawlerDao dao;
	@Resource
	SongDao songdao;
	@Resource
	BookDao bookdao;
	@Resource
	CsdnDao csdndao;

	@Override
	public List<WebSite> webList() {
		return dao.webList();
	}

	public List<Object[]> serch(String string, int type) {
		List<Object[]> list;
		if (type == 1) {
			list = dao.serch(string, "名称");
			return list;
		} else if (type == 2) {
			list = dao.serch(string, "作者");
			return list;
		} else if (type == 3) {
			list = dao.serch(string, "类型");
			return list;
		} else if (type == 4) {
			list = dao.serch(string, "链接");
			return list;
		}
		return null;
	}

	@Override
	public void Moredelete(String[] ids) {
		for (String id : ids) {
			if (id.indexOf("songs") != -1) {
				id = id.replace("songs", "");
				songdao.delete(Integer.parseInt(id));
			} else if (id.indexOf("books") != -1) {
				id = id.replace("books", "");
				bookdao.delete(Integer.parseInt(id));
			} else if (id.indexOf("csdns") != -1) {
				id = id.replace("csdns", "");
				csdndao.delete(Integer.parseInt(id));
			}
		}
	}
}
