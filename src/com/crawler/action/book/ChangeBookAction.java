package com.crawler.action.book;

import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Book;
import com.crawler.service.BookService;
import com.crawler.utils.GeneralMethod;

@Controller
public class ChangeBookAction {
	@Resource
	BookService service;

	private String id;
	private String bookName;
	private String author;
	private String style;
	private String monopoly;
	private String introduction;
	private String url;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

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
			if (!Pattern.compile("^[1-9]\\d*$").matcher(String.valueOf(id))
					.matches()) {
				GeneralMethod.BackMessage("编号不正确或为空");
				return;
			} else if (bookName == null || "".equals(bookName.trim())) {
				GeneralMethod.BackMessage("书名不能为空");
				return;
			} else if (author == null || "".equals(author.trim())) {
				GeneralMethod.BackMessage("作者不能为空");
				return;
			} else if (style == null || "".equals(style.trim())) {
				GeneralMethod.BackMessage("类型不能为空");
				return;
			} else if (monopoly == null || "".equals(monopoly.trim())) {
				GeneralMethod.BackMessage("授权状态不能为空");
				return;
			} else if (introduction == null || "".equals(introduction.trim())) {
				GeneralMethod.BackMessage("简介不能为空");
				return;
			} else if (url == null || "".equals(url.trim())) {
				GeneralMethod.BackMessage("链接不能为空");
				return;
			}
			// else if (!Pattern.compile("^[\u4e00-\u9fa5]*").matcher(url)
			// .matches()) {
			// GeneralMethod.BackMessage("链接格式不正确");
			// return;
			// }
			id = id.replace("book", "");

			Book b = service.find(Integer.parseInt(id));
			b.setBookName(bookName);
			b.setAuthor(author);
			b.setStyle(style);
			b.setMonopoly(monopoly);
			b.setIntroduction(introduction);
			b.setUrl(url);

			service.update(b);
		} catch (Exception e) {
			e.printStackTrace();
			GeneralMethod.BackMessage("发生错误");
		}
	}
}