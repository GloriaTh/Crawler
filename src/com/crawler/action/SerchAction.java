package com.crawler.action;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.CrawlerService;
import com.crawler.utils.GeneralMethod;

@Controller
public class SerchAction {
	@Resource
	CrawlerService service;

	private int type;
	private String word;

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public void execute() {
		List<Object[]> list;
		if (type == 1) {
			list = service.serch(word, 1);
			GeneralMethod.BackList(list);
		} else if (type == 2) {
			list = service.serch(word, 2);
			GeneralMethod.BackList(list);
		} else if (type == 3) {
			list = service.serch(word, 3);
			GeneralMethod.BackList(list);
		} else if (type == 4) {
			list = service.serch(word, 4);
			GeneralMethod.BackList(list);
		}
	}
}
