package com.crawler.action.song;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Type;
import com.crawler.service.SongService;
import com.crawler.utils.GeneralMethod;

@Controller
public class GetTypeAction {
	@Resource
	SongService service;

	public void execute() {
		List<Type> list = service.typeList();
		GeneralMethod.BackList(list);
	}
}