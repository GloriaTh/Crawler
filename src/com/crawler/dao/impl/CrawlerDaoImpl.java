package com.crawler.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.crawler.bean.WebSite;
import com.crawler.dao.CrawlerDao;

@Repository
@SuppressWarnings("unchecked")
public class CrawlerDaoImpl implements CrawlerDao {
	@Resource
	SessionFactory factory;

	@Override
	public List<WebSite> webList() {
		return factory.getCurrentSession().createQuery("from WebSite").list();
	}

	@Override
	public List<Object[]> serch(String string, String string2) {
		List<Object[]> list = new ArrayList<Object[]>();
		List<Object[]> listT = new ArrayList<Object[]>();
		if (string2 == "名称") {
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select songId,songName,singer,style,url from Song where songName like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "songs";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select bookId,bookName,author,style,url from Book where bookName like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "books";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select csdnId,title,author,style,url from Csdn where title like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "csdns";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
		} else if (string2 == "作者") {
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select songId,songName,singer,style,url from Song where singer like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "songs";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select bookId,bookName,author,style,url from Book where author like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "books";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select csdnId,title,author,style,url from Csdn where author like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "csdns";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
		} else if (string2 == "类型") {
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select songId,songName,singer,style,url from Song where style like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "songs";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select bookId,bookName,author,style,url from Book where style like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "books";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select csdnId,title,author,style,url from Csdn where style like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "csdns";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
		} else if (string2 == "链接") {
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select songId,songName,singer,style,url from Song where url like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "songs";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select bookId,bookName,author,style,url from Book where url like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "books";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
			listT = factory
					.getCurrentSession()
					.createQuery(
							"select csdnId,title,author,style,url from Csdn where url like ?")
					.setParameter(0, "%" + string + "%").list();
			for (int i = 0; i < listT.size(); i++) {
				listT.get(i)[0] = listT.get(i)[0] + "csdns";
				listT.set(i, listT.get(i));
			}
			list.addAll(listT);
		}
		return list;
	}

}
