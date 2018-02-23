package com.crawler.action.song;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Song;
import com.crawler.service.SongService;
import com.opensymphony.xwork2.ActionContext;

@Controller
public class FindSongAction {
	@Resource
	SongService service;

	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String execute() {
		ActionContext ctx = ActionContext.getContext();

		id = id.replace("song", "");
		Song s = service.find(Integer.parseInt(id));

		ctx.put("song", s);
		return "success";
	}
}