package com.crawler.service;

import java.util.List;

import com.crawler.bean.Csdn;
import com.crawler.bean.Style;

public interface CsdnService {
	public void save(Csdn csdn);

	public void update(Csdn csdn);

	public Csdn find(int id);

	public void delete(int id);

	public List<Csdn> list();

	public void clear();

	public void Moredelete(int[] idis);

	public List<Csdn> pageList(int index, int rowperpage);

	public String MoreAdd(String[] titles, String[] authors, String[] styles,
			String[] counts, String[] introductions, String[] urls);

	public List<Style> findByType(String string);

	public List<Csdn> indexList(int index);

	public boolean hava(String string);

	public Csdn find(String string);

}