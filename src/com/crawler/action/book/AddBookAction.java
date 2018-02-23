package com.crawler.action.book;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.BookService;
import com.crawler.utils.GeneralMethod;

@Controller
public class AddBookAction {
	@Resource
	BookService service;

	private String bookName;
	private String author;
	private String style;
	private String monopoly;
	private String introduction;
	private String url;

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
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

	public String getMonopoly() {
		return monopoly;
	}

	public void setMonopoly(String monopoly) {
		this.monopoly = monopoly;
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
			String[] bookNames = bookName.split(",");
			String[] authors = author.split(",");
			String[] styles = style.split(",");
			String[] monopolys = monopoly.split(",");
			String[] introductions = introduction.split(",");
			String[] urls = url.split(",");

			for (int i = 0; i < bookNames.length; i++) {
				if (bookNames[i] == null || "".equals(bookNames[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行书名未填写,请填写书名");
					return;
				}
				bookNames[i] = bookNames[i].trim();
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

			for (int i = 0; i < monopolys.length; i++) {
				if (monopolys[i] == null || "".equals(monopolys[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行授权状态未填写，请填写授权状态");
					return;
				}
				monopolys[i] = monopolys[i].trim();
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

			String result = service.MoreAdd(bookNames, authors, styles,
					monopolys, introductions, urls);

			GeneralMethod.BackMessage(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}