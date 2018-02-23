package com.crawler.action.csdn;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Style;
import com.crawler.service.CsdnService;
import com.crawler.utils.GeneralMethod;

@Controller
public class GetCsdnStyleAction {
	@Resource
	CsdnService service;

	public void execute() {
		List<Style> list = service.findByType("Csdn");
		GeneralMethod.BackList(list);
	}
}