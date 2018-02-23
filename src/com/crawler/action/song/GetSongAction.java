package com.crawler.action.song;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Song;
import com.crawler.bean.SongEx;
import com.crawler.service.SongService;
import com.crawler.utils.GeneralMethod;

@Controller
public class GetSongAction {
	@Resource
	SongService service;

	private int index;
	private int wait;

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getWait() {
		return wait;
	}

	public void setWait(int wait) {
		this.wait = wait;
	}

	public void execute() {
		List<SongEx> exlist = new ArrayList<SongEx>();
		if (wait == 0) {
			List<Song> list = service.indexList(index-1);
			for (Song s : list) {
				SongEx ex = new SongEx();
				ex.setSongId(s.getSongId()+"song");
				ex.setSongName(s.getSongName());
				ex.setSinger(s.getSinger());
				ex.setType(s.getType());
				ex.setStyle(s.getStyle());
				ex.setUrl(s.getUrl());
				exlist.add(ex);
			}
		} else {
			List<Song> list = service.list();
			for (Song s : list) {
				SongEx ex = new SongEx();
				ex.setSongId(s.getSongId()+"song");
				ex.setSongName(s.getSongName());
				ex.setSinger(s.getSinger());
				ex.setType(s.getType());
				ex.setStyle(s.getStyle());
				ex.setUrl(s.getUrl());
				exlist.add(ex);
			}
		}
		GeneralMethod.BackList(exlist);
	}
}
