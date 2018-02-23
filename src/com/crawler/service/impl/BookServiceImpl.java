package com.crawler.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Book;
import com.crawler.dao.BookDao;
import com.crawler.service.BookService;

@Service
@Transactional
public class BookServiceImpl implements BookService {
	@Resource
	BookDao dao;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		dao.delete(id);
	}

	@Override
	public Book find(int id) {
		return dao.find(id);
	}

	@Override
	public List<Book> list() {
		return dao.list();
	}

	@Override
	public void save(Book book) {
		dao.save(book);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Book book) {
		dao.update(book);
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
	public List<Book> pageList(int index, int rowperpage) {
		return dao.findByPage(index, rowperpage);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public String MoreAdd(String[] bookNames, String[] authors,
			String[] styles, String[] monopolys, String[] introductions,
			String[] urls) {
		try {
			int size = bookNames.length;
			for (int i = 0; i < size; i++) {
				Book b = new Book();
				b.setBookName(bookNames[i]);
				b.setAuthor(authors[i]);
				b.setStyle(styles[i]);
				b.setMonopoly(monopolys[i]);
				b.setIntroduction(introductions[i]);
				b.setUrl(urls[i]);
				dao.save(b);
			}
		} catch (Exception e) {
			System.out.println("url已存在");
			e.printStackTrace();
		}
		return "";
	}

	@Override
	public List<Book> indexList(int index) {
		return dao.indexList(index);
	}
}