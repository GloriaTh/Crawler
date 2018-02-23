package com.crawler.dao;

import java.util.List;

import com.crawler.bean.Url;

public interface UrlDao {
	public void save(Url url);

	public void update(Url url);

	public Url find(int id);

	public void delete(int id);

	public List<Url> list();

	public void clear();

	public Url findByUrl(String s);
}
