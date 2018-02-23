package com.crawler.action;

import org.springframework.stereotype.Controller;

import com.crawler.action.book.FalooCrawlerAction;
import com.crawler.action.csdn.CasnCrawlerAction;
import com.crawler.action.song.ProcessorAction;

@Controller
public class StopAllAction {

	public void execute() throws InterruptedException {
		ProcessorAction p = ProcessorAction.getInstance();
		if (p.isAlive() == true) {
			p.rest();
		}
		FalooCrawlerAction f = FalooCrawlerAction.getInstance();
		if (f.isAlive() == true) {
			f.rest();
		}
		CasnCrawlerAction c = CasnCrawlerAction.getInstance();
		if (c.isAlive() == true) {
			c.rest();
		}
		System.out.println("成功停止所有程序");
	}
}