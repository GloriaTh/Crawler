package com.crawler.action.csdn;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.CsdnService;
import com.crawler.utils.GeneralMethod;

@Controller
public class DeleteCsdnAllAction {
	@Resource
	CsdnService service;

	public void execute() {
		service.clear();
		GeneralMethod.BackMessage("success");
	}
}