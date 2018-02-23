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
public class BookCrawlerAction {
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

	public void execute() throws InterruptedException {
		FalooCrawlerAction f = FalooCrawlerAction.getInstance();
		if (wait == 1) {
			f.rest();
			GeneralMethod.BackMessage("wait");
			return;
		} else if (f.isAlive() == false) {
			f.start();
		} else if (wait == 2) {
			f.restart();
			GeneralMethod.BackMessage("");
			return;
		}else if (f.over()) {
			f.rest();
			f.over = false;
			GeneralMethod.BackMessage("over");
			return;
		}

		int rowperpage = 100;
		List<Book> list = service.pageList(index, rowperpage);
		List<BookEx> exlist = new ArrayList<BookEx>();
		if (list.isEmpty()) {
			GeneralMethod.BackMessage("");
		} else {
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
			GeneralMethod.BackList(exlist);
		}

	}
}
