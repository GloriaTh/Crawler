package com.crawler.action.song;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.SongService;
import com.crawler.utils.GeneralMethod;

@Controller
public class DeleteAllAction {
	@Resource
	SongService service;

	public void execute() {
		service.clear();
		GeneralMethod.BackMessage("success");
	}
}