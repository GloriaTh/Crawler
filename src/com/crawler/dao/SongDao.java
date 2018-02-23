package com.crawler.dao;

import java.util.List;

import com.crawler.bean.Song;

public interface SongDao {
	public void save(Song song);

	public void update(Song song);

	public Song find(int id);

	public void delete(int id);

	public List<Song> list();

	public List<Song> findByPage(int rowperpage);

	public void clear();

	public List<Song> findByPage(int index, int rowperpage);

	public List<Song> indexList(int index);
}
