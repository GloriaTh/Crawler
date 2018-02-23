package com.crawler.dao;

import java.util.List;

import com.crawler.bean.Book;

public interface BookDao {
	public void save(Book book);

	public void update(Book book);

	public Book find(int id);

	public void delete(int id);

	public List<Book> list();

	public List<Book> findByPage(int rowperpage);

	public void clear();

	public List<Book> findByPage(int index, int rowperpage);

	public List<Book> indexList(int index);
}
