package com.crawler.action.csdn;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Csdn;
import com.crawler.service.CsdnService;
import com.opensymphony.xwork2.ActionContext;

@Controller
public class FindCsdnAction {
	@Resource
	CsdnService service;

	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String execute() {
		ActionContext ctx = ActionContext.getContext();

		id = id.replace("csdn", "");
		Csdn c = service.find(Integer.parseInt(id));

		ctx.put("csdn", c);
		return "success";
	}
}