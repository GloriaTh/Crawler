package com.crawler.service;

import java.util.List;

import com.crawler.bean.Song;
import com.crawler.bean.SongEx;
import com.crawler.bean.Style;
import com.crawler.bean.Type;

public interface SongService {
	public void save(Song song);

	public void update(Song song);

	public Song find(int id);

	public void delete(int id);

	public List<Song> list();

	public List<SongEx> pageList(int rowperpage);

	public void clear();

	public List<SongEx> pageList(int index, int rowperpage);

	public void Moredelete(int[] idis);

	public String MoreAdd(String[] songName, String[] singer, String[] type,
			String[] style, String[] url);

	public List<Style> findByType(String type);
	
	public List<Type> typeList();

	public List<Song> indexList(int index);
}