package com.crawler.action.csdn;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Csdn;
import com.crawler.bean.CsdnEx;
import com.crawler.service.CsdnService;
import com.crawler.utils.GeneralMethod;

@Controller
public class GetCsdnAction {
	@Resource
	CsdnService service;

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
		List<Csdn> list;
		List<CsdnEx> exlist = new ArrayList<CsdnEx>();
		if (wait == 0) {
			list = service.indexList(index);
			for (Csdn cs : list) {
				CsdnEx ex = new CsdnEx();
				ex.setCsdnId(cs.getCsdnId()+"csdn");
				ex.setTitle(cs.getTitle());
				ex.setAuthor(cs.getAuthor());
				ex.setStyle(cs.getStyle());
				ex.setCount(cs.getCount());
				ex.setIntroduction(cs.getIntroduction());
				ex.setUrl(cs.getUrl());
				exlist.add(ex);
			}
		} else {
			list = service.list();
			for (Csdn cs : list) {
				CsdnEx ex = new CsdnEx();
				ex.setCsdnId(cs.getCsdnId()+"csdn");
				ex.setTitle(cs.getTitle());
				ex.setAuthor(cs.getAuthor());
				ex.setStyle(cs.getStyle());
				ex.setCount(cs.getCount());
				ex.setIntroduction(cs.getIntroduction());
				ex.setUrl(cs.getUrl());
				exlist.add(ex);
			}
		}
		GeneralMethod.BackList(exlist);
	}
}
