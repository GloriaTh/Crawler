package com.crawler.action.book;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.BookService;
import com.crawler.utils.GeneralMethod;

@Controller
public class DeleteBookAction {
	@Resource
	BookService service;

	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void execute() {
		try {
			String[] Ids = id.split(",");
			int[] Idis = new int[Ids.length];
			for (int i = 0; i < Ids.length; i++) {
				Ids[i] = Ids[i].replace("book", "");
				Idis[i] = Integer.parseInt(Ids[i]);
			}

			service.Moredelete(Idis);
		} catch (Exception e) {
			e.printStackTrace();
			GeneralMethod.BackMessage("发生错误");
		}
	}
}