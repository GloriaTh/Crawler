package com.crawler.action.song;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.SongEx;
import com.crawler.service.SongService;
import com.crawler.utils.GeneralMethod;

@Controller
public class FiveSingAction {
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

	public void execute() throws InterruptedException {
		ProcessorAction p = ProcessorAction.getInstance();
		if (wait == 1) {
			p.rest();
			GeneralMethod.BackMessage("wait");
			return;
		} else if (p.isAlive() == false) {
			p.start();
		}else if (wait == 2) {
			p.restart();
			GeneralMethod.BackMessage("");
			return;
		}else if (p.over()) {
			p.rest(); 
			p.over = false;
			GeneralMethod.BackMessage("over");
			return;
		}

		int rowperpage = 100;
		List<SongEx> list = service.pageList(index, rowperpage);
		if (list.isEmpty()) {
			GeneralMethod.BackMessage("");
		} else {
			GeneralMethod.BackList(list);
		}

	}
}
