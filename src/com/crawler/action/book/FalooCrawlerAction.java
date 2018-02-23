package com.crawler.action.book;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;
import us.codecraft.webmagic.scheduler.FileCacheQueueScheduler;

import com.crawler.bean.Book;
import com.crawler.service.BookService;

@SuppressWarnings("deprecation")
public class FalooCrawlerAction extends Thread implements PageProcessor {
	private static FalooCrawlerAction instance = new FalooCrawlerAction();
	static boolean flag = true;
	static int count = 0;
	static boolean over = false;
	private static String file = ServletActionContext.getRequest().getRealPath(
			"/");
	private static Spider s;

	private FalooCrawlerAction() {
	}

	public static FalooCrawlerAction getInstance() {
		return instance;
	}

	private Site site = Site.me().setRetryTimes(3).setSleepTime(100);
	ApplicationContext cxt = new ClassPathXmlApplicationContext("beans.xml");
	BookService service = (BookService) cxt.getBean("bookServiceImpl");

	public static final String URL_LIST = "http://b\\.faloo\\.com/l/0/0/\\w+/0/0/0/\\d+.html";
	public static final String URL_BOOK = "http://b\\.faloo\\.com/\\w+/\\d+.html";

	public void process(Page page) {
		if (page.getUrl().regex(URL_LIST).match()) {
			page.addTargetRequests(page.getHtml()
					.xpath("//a[@class=\"a_16b\"]").links().regex(URL_BOOK)
					.all());
			page.addTargetRequests(page.getHtml().xpath(
					"//table[@id=\"PageListBTop\"]").links().regex(URL_LIST)
					.all());
			// 文章页
		} else if (page.getUrl().regex(URL_BOOK).match()) {
			Book b = new Book();
			b.setBookName(getText(page.getHtml()
					.xpath("//h1[@class=\"a_24b\"]").toString()));
			b.setAuthor(getText3(page.getHtml().xpath(
					"//div[@class=\"ni_10\"]//a").toString()));
			b.setIntroduction(getText2(page.getHtml().xpath(
					"//a[@class=\"a_666\"]").toString()));
			b.setStyle(getText(page.getHtml().xpath(
					"//div[@id=\"con_tab11_box2\"]//a").toString()));
			b.setMonopoly(getText1(page.getHtml().xpath(
					"//td[@class=\"a_666\"]").all().get(2)));
			b.setUrl(page.getUrl().toString());
			service.save(b);
		}
	}

	public Site getSite() {
		return site;
	}

	public void run() {
		while (true) {
			if (flag) {
				s = Spider.create(new FalooCrawlerAction()).setScheduler(
						new FileCacheQueueScheduler(file)).thread(10);
				for (char i = 'a'; i <= 'z'; i++) {
					s.addUrl("http://b.faloo.com/l/0/0/" + i + "/0/0/0/1.html");
				}
				s.run();
				count++;
				if(count >=2){
					flag=false;
					over = true;
					count=0;
				}
			}
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) throws InterruptedException {
	}

	public static String getText(String ele) {
		String result = ele
				.substring(ele.indexOf(">") + 1, ele.indexOf("<", 2));
		return result;

	}

	public static String getText1(String ele) {
		String result;
		if (ele.contains("span")) {
			result = ele.substring(ele.indexOf("hong") + 6, ele
					.indexOf("<", 35));
		} else {
			result = ele.substring(ele.indexOf(">") + 1, ele.indexOf("<", 2))
					.split("：")[1];
		}
		return result;
	}

	public static String getText2(String ele) {
		String result = ele.substring(ele.indexOf(">") + 1, ele.indexOf("</a>",
				2));
		result = result.replaceAll("<br>", "\r");
		return result;
	}

	public static String getText3(String ele) {
		String result = ele.substring(ele.indexOf("_blank") + 8, ele.indexOf(
				"<", 24));
		return result;

	}

	public void rest() {
		flag = false;
		count--;
		s.stop();
	}

	public void restart() {
		flag = true;
	}

	public boolean over() {
		return over;
	}
}
