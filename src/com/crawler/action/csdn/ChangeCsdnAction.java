package com.crawler.action.csdn;

import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Csdn;
import com.crawler.service.CsdnService;
import com.crawler.utils.GeneralMethod;

@Controller
public class ChangeCsdnAction {
	@Resource
	CsdnService service;

	private String id;
	private String title;
	private String author;
	private String style;
	private String count;
	private String introduction;
	private String url;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

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
			if (!Pattern.compile("^[1-9]\\d*$").matcher(String.valueOf(id))
					.matches()) {
				GeneralMethod.BackMessage("编号不正确或为空");
				return;
			} else if (title == null || "".equals(title.trim())) {
				GeneralMethod.BackMessage("标题名不能为空");
				return;
			} else if (author == null || "".equals(author.trim())) {
				GeneralMethod.BackMessage("作者不能为空");
				return;
			} else if (style == null || "".equals(style.trim())) {
				GeneralMethod.BackMessage("类型不能为空");
				return;
			} else if (count == null || "".equals(count.trim())) {
				GeneralMethod.BackMessage("阅览次数不能为空");
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

			id = id.replace("csdn", "");

			Csdn c = service.find(Integer.parseInt(id));
			c.setTitle(title);
			c.setAuthor(author);
			c.setStyle(style);
			c.setCount(count);
			c.setIntroduction(introduction);
			c.setUrl(url);

			service.update(c);
		} catch (Exception e) {
			e.printStackTrace();
			GeneralMethod.BackMessage("发生错误");
		}
	}
}