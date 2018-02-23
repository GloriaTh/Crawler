package com.crawler.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Song;
import com.crawler.bean.Style;
import com.crawler.dao.StyleDao;

@Repository
@SuppressWarnings("unchecked")
public class StyleDaoImpl implements StyleDao {
	@Resource
	SessionFactory factory;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		factory.getCurrentSession().delete(
				factory.getCurrentSession().get(Style.class, id));

	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Style find(int id) {
		return (Style) factory.getCurrentSession().get(Style.class, id);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<Song> list() {
		return factory.getCurrentSession().createQuery("from Song").list();
	}

	@Override
	public void save(Style style) {
		factory.getCurrentSession().persist(style);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Style style) {
		factory.getCurrentSession().merge(style);

	}

	@Override
	public List<Style> findByType(String type) {
		return factory.getCurrentSession().createQuery(
				"from Style s where type = ?").setParameter(0, type).list();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		Query query = factory.getCurrentSession().createQuery(
				"delete from Song where 1=1");
		query.executeUpdate();
	}
}