package com.crawler.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Book;
import com.crawler.dao.BookDao;

@Repository
@SuppressWarnings("unchecked")
public class BookDaoImpl implements BookDao {
	@Resource
	SessionFactory factory;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		factory.getCurrentSession().delete(
				factory.getCurrentSession().get(Book.class, id));

	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Book find(int id) {
		return (Book) factory.getCurrentSession().get(Book.class, id);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<Book> list() {
		return factory.getCurrentSession().createQuery("from Book").list();
	}

	@Override
	public void save(Book book) {
		factory.getCurrentSession().persist(book);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Book book) {
		factory.getCurrentSession().merge(book);

	}

	@Override
	public List<Book> findByPage(int rowperpage) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Song s")//
				.setFirstResult(1)// 开始值
				.setMaxResults(rowperpage)// +值
				.list();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		Query query = factory.getCurrentSession().createQuery(
				"delete from Book where 1=1");
		query.executeUpdate();
	}

	@Override
	public List<Book> findByPage(int index, int rowperpage) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Book s")//
				.setFirstResult(index)// 开始值
				.setMaxResults(rowperpage)// +值
				.list();
	}

	@Override
	public List<Book> indexList(int index) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Book")//
				.setFirstResult(index)// 开始值
				.setMaxResults(
						factory.getCurrentSession().createQuery("from Book")
								.list().size())// +值
				.list();
	}
}
