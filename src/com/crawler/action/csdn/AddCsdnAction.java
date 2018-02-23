package com.crawler.action.csdn;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.CsdnService;
import com.crawler.utils.GeneralMethod;

@Controller
public class AddCsdnAction {
	@Resource
	CsdnService service;

	private String title;
	private String author;
	private String style;
	private String count;
	private String introduction;
	private String url;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void execute() {
		try {
			String[] titles = title.split(",");
			String[] authors = author.split(",");
			String[] styles = style.split(",");
			String[] counts = count.split(",");
			String[] introductions = introduction.split(",");
			String[] urls = url.split(",");

			for (int i = 0; i < titles.length; i++) {
				if (titles[i] == null || "".equals(titles[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行标题未填写,请填写标题");
					return;
				}
				titles[i] = titles[i].trim();
			}

			for (int i = 0; i < authors.length; i++) {
				if (authors[i] == null || "".equals(authors[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行作者未填写，请填写作者");
					return;
				}
				authors[i] = authors[i].trim();
			}

			for (int i = 0; i < styles.length; i++) {
				if (styles[i] == null || "".equals(styles[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行类型未选择,请选择一个类型");
					return;
				}
				styles[i] = styles[i].trim();
			}

			for (int i = 0; i < counts.length; i++) {
				if (counts[i] == null || "".equals(counts[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行授权状态未填写，请填写授权状态");
					return;
				}
				counts[i] = counts[i].trim();
			}

			for (int i = 0; i < introductions.length; i++) {
				if (introductions[i] == null
						|| "".equals(introductions[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行授简介未填写，请填写简介");
					return;
				}
				introductions[i] = introductions[i].trim();
			}

			for (int i = 0; i < urls.length; i++) {
				if (urls[i] == null || "".equals(urls[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行链接未填写，请填写链接");
					return;
				}
				urls[i] = urls[i].trim();
			}

			String result = service.MoreAdd(titles, authors, styles,
					counts, introductions, urls);

			GeneralMethod.BackMessage(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}