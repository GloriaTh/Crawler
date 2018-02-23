package com.crawler.action.book;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Book;
import com.crawler.bean.BookEx;
import com.crawler.service.BookService;
import com.crawler.utils.GeneralMethod;

@Controller
public class GetBookAction {
	@Resource
	BookService service;

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
		List<Book> list;
		List<BookEx> exlist = new ArrayList<BookEx>();
		if (wait == 0) {
			list = service.indexList(index);
			for (Book b : list) {
				BookEx ex = new BookEx();
				ex.setBookId(b.getBookId() + "book");
				ex.setBookName(b.getBookName());
				ex.setAuthor(b.getAuthor());
				ex.setStyle(b.getStyle());
				ex.setMonopoly(b.getMonopoly());
				if (b.getIntroduction().length() <= 12) {
					ex.setIntroduction(b.getIntroduction());
				} else {
					ex.setIntroduction(b.getIntroduction().substring(0, 12)
							+ "...");
				}
				ex.setUrl(b.getUrl());
				exlist.add(ex);
			}
		} else {
			list = service.list();
			for (Book b : list) {
				BookEx ex = new BookEx();
				ex.setBookId(b.getBookId() + "book");
				ex.setBookName(b.getBookName());
				ex.setAuthor(b.getAuthor());
				ex.setStyle(b.getStyle());
				ex.setMonopoly(b.getMonopoly());
				if (b.getIntroduction().length() <= 12) {
					ex.setIntroduction(b.getIntroduction());
				} else {
					ex.setIntroduction(b.getIntroduction().substring(0, 12)
							+ "...");
				}
				ex.setUrl(b.getUrl());
				exlist.add(ex);
			}
		}
		GeneralMethod.BackList(exlist);
	}
}
