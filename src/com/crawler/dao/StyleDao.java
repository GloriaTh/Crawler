package com.crawler.dao;

import java.util.List;

import com.crawler.bean.Song;
import com.crawler.bean.Style;

public interface StyleDao {
	public void save(Style style);

	public void update(Style style);

	public Style find(int id);

	public void delete(int id);

	public List<Song> list();

	public void clear();

	public List<Style> findByType(String Type);
}
