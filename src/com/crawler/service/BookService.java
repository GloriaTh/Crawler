package com.crawler.service;

import java.util.List;

import com.crawler.bean.Book;

public interface BookService {
	public void save(Book book);

	public void update(Book book);

	public Book find(int id);

	public void delete(int id);

	public List<Book> list();

	public void clear();

	public void Moredelete(int[] idis);

	public List<Book> pageList(int index, int rowperpage);

	public String MoreAdd(String[] bookNames, String[] authors,
			String[] styles, String[] monopolys, String[] introductions,
			String[] urls);

	public List<Book> indexList(int index);

}