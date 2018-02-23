package com.crawler.action.song;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Style;
import com.crawler.service.SongService;
import com.crawler.utils.GeneralMethod;

@Controller
public class GetStyleAction {
	@Resource
	SongService service;

	private String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void execute() {
		List<Style> list = service.findByType(type);
		GeneralMethod.BackList(list);
	}
}