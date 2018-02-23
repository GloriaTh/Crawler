package com.crawler.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Url;
import com.crawler.dao.UrlDao;

@Repository
@SuppressWarnings("unchecked")
public class UrlDaoImpl implements UrlDao {
	@Resource
	SessionFactory factory;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		factory.getCurrentSession().delete(
				factory.getCurrentSession().get(Url.class, id));

	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Url find(int id) {
		return (Url) factory.getCurrentSession().get(Url.class, id);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<Url> list() {
		return factory.getCurrentSession().createQuery("from Url").list();
	}

	@Override
	public void save(Url url) {
		factory.getCurrentSession().persist(url);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Url url) {
		factory.getCurrentSession().merge(url);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		Query query = factory.getCurrentSession().createQuery(
				"delete from Url where 1=1");
		query.executeUpdate();
	}

	@Override
	public Url findByUrl(String s) {
		return (Url) factory.getCurrentSession().createQuery(
				"from url where Url = ?").setParameter(0, s).uniqueResult();
	}
}
