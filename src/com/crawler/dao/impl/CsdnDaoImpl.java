package com.crawler.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Csdn;
import com.crawler.dao.CsdnDao;

@Repository
@SuppressWarnings("unchecked")
public class CsdnDaoImpl implements CsdnDao {
	@Resource
	SessionFactory factory;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		factory.getCurrentSession().delete(
				factory.getCurrentSession().get(Csdn.class, id));

	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Csdn find(int id) {
		return (Csdn) factory.getCurrentSession().get(Csdn.class, id);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<Csdn> list() {
		return factory.getCurrentSession().createQuery("from Csdn").list();
	}

	@Override
	public void save(Csdn csdn) {
		factory.getCurrentSession().persist(csdn);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Csdn csdn) {
		factory.getCurrentSession().merge(csdn);

	}

	@Override
	public List<Csdn> findByPage(int rowperpage) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Csdn s")//
				.setFirstResult(1)// 开始值
				.setMaxResults(rowperpage)// +值
				.list();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		Query query = factory.getCurrentSession().createQuery(
				"delete from Csdn where 1=1");
		query.executeUpdate();
	}

	@Override
	public List<Csdn> findByPage(int index, int rowperpage) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Csdn s")//
				.setFirstResult(index)// 开始值
				.setMaxResults(rowperpage)// +值
				.list();
	}

	@Override
	public List<Csdn> indexList(int index) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Csdn")//
				.setFirstResult(index)// 开始值
				.setMaxResults(
						factory.getCurrentSession().createQuery("from Csdn")
								.list().size())// +值
				.list();
	}

	@Override
	public boolean hava(String url) {
		if (factory.getCurrentSession().createQuery(// 分页查询
				"from Csdn s where url = ?")//
				.setParameter(0, url).uniqueResult() == null) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public Csdn find(String url) {
		return (Csdn) factory.getCurrentSession().createQuery(
				"from Csdn s where url = ?")//
				.setParameter(0, url).uniqueResult();
	}

}
