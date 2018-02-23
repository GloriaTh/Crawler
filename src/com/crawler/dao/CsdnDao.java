package com.crawler.dao;

import java.util.List;

import com.crawler.bean.Csdn;

public interface CsdnDao {
	public void save(Csdn csdn);

	public void update(Csdn csdn);

	public Csdn find(int id);

	public void delete(int id);

	public List<Csdn> list();

	public List<Csdn> findByPage(int rowperpage);

	public void clear();

	public List<Csdn> findByPage(int index, int rowperpage);

	public List<Csdn> indexList(int index);

	public boolean hava(String url);

	public Csdn find(String url);
}
