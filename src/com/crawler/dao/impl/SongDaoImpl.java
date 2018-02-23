package com.crawler.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Song;
import com.crawler.dao.SongDao;

@Repository
@SuppressWarnings("unchecked")
public class SongDaoImpl implements SongDao {
	@Resource
	SessionFactory factory;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		factory.getCurrentSession().delete(
				factory.getCurrentSession().get(Song.class, id));

	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public Song find(int id) {
		return (Song) factory.getCurrentSession().get(Song.class, id);
	}

	@Transactional(propagation = Propagation.NOT_SUPPORTED)
	public List<Song> list() {
		return factory.getCurrentSession().createQuery("from Song").list();
	}

	@Override
	public void save(Song song) {
		factory.getCurrentSession().persist(song);

	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Song song) {
		factory.getCurrentSession().merge(song);

	}

	@Override
	public List<Song> findByPage(int rowperpage) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Song s")//
				.setFirstResult(1)// 开始值
				.setMaxResults(rowperpage)// +值
				.list();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		Query query = factory.getCurrentSession().createQuery(
				"delete from Song where 1=1");
		query.executeUpdate();
	}

	@Override
	public List<Song> findByPage(int index, int rowperpage) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Song s")//
				.setFirstResult(index)// 开始值
				.setMaxResults(rowperpage)// +值
				.list();
	}

	@Override
	public List<Song> indexList(int index) {
		return factory.getCurrentSession().createQuery(// 分页查询
				"from Song s")//
				.setFirstResult(index)// 开始值
				.setMaxResults(
						factory.getCurrentSession().createQuery("from Song")
								.list().size())// +值
				.list();
	}
}
