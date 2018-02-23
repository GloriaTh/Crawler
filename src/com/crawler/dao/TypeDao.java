package com.crawler.dao;

import java.util.List;

import com.crawler.bean.Type;

public interface TypeDao {
	public void save(Type type);

	public void update(Type type);

	public Type find(int id);

	public void delete(int id);

	public List<Type> list();

	public void clear();
}
