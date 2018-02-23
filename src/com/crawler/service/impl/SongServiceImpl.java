package com.crawler.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.crawler.bean.Song;
import com.crawler.bean.SongEx;
import com.crawler.bean.Style;
import com.crawler.bean.Type;
import com.crawler.dao.SongDao;
import com.crawler.dao.StyleDao;
import com.crawler.dao.TypeDao;
import com.crawler.service.SongService;

@Service
@Transactional
public class SongServiceImpl implements SongService {
	@Resource
	SongDao dao;
	@Resource
	StyleDao styledao;
	@Resource
	TypeDao typedao;

	@Transactional(propagation = Propagation.REQUIRED)
	public void delete(int id) {
		dao.delete(id);
	}

	@Override
	public Song find(int id) {
		return dao.find(id);
	}

	@Override
	public List<Song> list() {
		return dao.list();
	}

	@Override
	public void save(Song song) {
		dao.save(song);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void update(Song song) {
		dao.update(song);
	}

	@Override
	public List<SongEx> pageList(int rowperpage) {
		List<Song> list = dao.findByPage(rowperpage);

		List<SongEx> maplist = new ArrayList<SongEx>();

		for (Song s : list) {
			SongEx ex = new SongEx();
			ex.setSongName(s.getSongName());
			ex.setSinger(s.getSinger());

			maplist.add(ex);
		}

		return maplist;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void clear() {
		dao.clear();
	}

	@Override
	public List<SongEx> pageList(int index, int rowperpage) {
		List<Song> list = dao.findByPage(index, rowperpage);

		List<SongEx> maplist = new ArrayList<SongEx>();

		for (Song s : list) {
			SongEx ex = new SongEx();
			ex.setSongId(s.getSongId()+"song");
			ex.setSongName(s.getSongName());
			ex.setSinger(s.getSinger());
			ex.setType(s.getType());
			ex.setStyle(s.getStyle());
			ex.setUrl(s.getUrl());

			maplist.add(ex);
		}

		return maplist;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public void Moredelete(int[] idis) {
		for (int id : idis) {
			delete(id);
		}
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public String MoreAdd(String[] songName, String[] singer, String[] type,
			String[] style, String[] url) {
		try {
			int size = songName.length;
			for (int i = 0; i < size; i++) {
				Song s = new Song();
				s.setSongName(songName[i]);
				s.setSinger(singer[i]);
				s.setType(type[i]);
				s.setStyle(style[i].replaceAll(",", "-"));
				s.setUrl(url[i]);
				dao.save(s);
			}
		} catch (Exception e) {
			System.out.println("url已存在");
			e.printStackTrace();
		}
		return "";
	}

	@Override
	public List<Style> findByType(String type) {
		return styledao.findByType(type);
	}

	@Override
	public List<Type> typeList() {
		return typedao.list();
	}

	@Override
	public List<Song> indexList(int index) {
		return dao.indexList(index);
	}
}