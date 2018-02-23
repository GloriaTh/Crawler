package com.crawler.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Csdn;
import com.crawler.bean.Style;
import com.crawler.dao.CsdnDao;
import com.crawler.dao.StyleDao;
import com.crawler.service.CsdnService;

@Service
@Transactional
public class CsdnServiceImpl implements CsdnService {
	@Resource
	CsdnDao dao;
	@Resource
	StyleDao styledao;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		dao.delete(id);
	}

	@Override
	public Csdn find(int id) {
		return dao.find(id);
	}

	@Override
	public List<Csdn> list() {
		return dao.list();
	}

	@Override
	public void save(Csdn csdn) {
		dao.save(csdn);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Csdn csdn) {
		dao.update(csdn);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		dao.clear();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void Moredelete(int[] idis) {
		for (int id : idis) {
			delete(id);
		}
	}

	@Override
	public List<Csdn> pageList(int index, int rowperpage) {
		return dao.findByPage(index, rowperpage);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public String MoreAdd(String[] titles, String[] authors, String[] styles,
			String[] counts, String[] introductions, String[] urls) {
		try {
			int size = titles.length;
			for (int i = 0; i < size; i++) {
				Csdn c = new Csdn();
				c.setTitle(titles[i]);
				c.setAuthor(authors[i]);
				c.setStyle(styles[i]);
				c.setCount(counts[i]);
				c.setIntroduction(introductions[i]);
				c.setUrl(urls[i]);
				dao.save(c);
			}
		} catch (Exception e) {
			System.out.println("url已存在");
			e.printStackTrace();
		}
		return "";
	}

	@Override
	public List<Style> findByType(String string) {
		return styledao.findByType(string);
	}

	@Override
	public List<Csdn> indexList(int index) {
		return dao.indexList(index);
	}

	@Override
	public boolean hava(String url) {
		return dao.hava(url);
	}

	@Override
	public Csdn find(String url) {
		return dao.find(url);
	}
}
