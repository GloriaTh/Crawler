package com.crawler.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Type;
import com.crawler.dao.TypeDao;

@Repository
@SuppressWarnings("unchecked")
public class TypeDaoImpl implements TypeDao {
	@Resource
	SessionFactory factory;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		factory.getCurrentSession().delete(
				factory.getCurrentSession().get(Type.class, id));

	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Type find(int id) {
		return (Type) factory.getCurrentSession().get(Type.class, id);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<Type> list() {
		return factory.getCurrentSession().createQuery("from Type").list();
	}

	@Override
	public void save(Type type) {
		factory.getCurrentSession().persist(type);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Type type) {
		factory.getCurrentSession().merge(type);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		Query query = factory.getCurrentSession().createQuery(
				"delete from Type where 1=1");
		query.executeUpdate();
	}
}
