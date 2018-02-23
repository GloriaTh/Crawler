package com.crawler.action.csdn;

import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;
import us.codecraft.webmagic.scheduler.FileCacheQueueScheduler;

import com.crawler.bean.Csdn;
import com.crawler.service.CsdnService;

@SuppressWarnings("deprecation")
public class CasnCrawlerAction extends Thread implements PageProcessor {
	private static CasnCrawlerAction instance = new CasnCrawlerAction();
	static boolean flag = true;
	static boolean over = false;
	static int count = 0;
	private static String file = ServletActionContext.getRequest().getRealPath(
			"/");
	private static Spider s;

	private CasnCrawlerAction() {
	}

	public static CasnCrawlerAction getInstance() {
		return instance;
	}

	private Site site = Site.me().setRetryTimes(3).setSleepTime(100);
	ApplicationContext cxt = new ClassPathXmlApplicationContext("beans.xml");
	CsdnService service = (CsdnService) cxt.getBean("csdnServiceImpl");

	public static final String URL_LIST = "http://b\\.faloo\\.com/l/0/0/\\w+/0/0/0/\\d+.html";
	public static final String URL_BOOK = "http://b\\.faloo\\.com/\\w+/\\d+.html";

	public void process(Page page) {
		page.addTargetRequests(page.getHtml().xpath(
				"//div[@class=\"page_nav\"]").links().all());
		// 3
		List<String> title = page.getHtml().xpath(
				"//h3[@class=\"tracking-ad\"]").all();
		//
		List<String> author = page.getHtml().xpath("//a[@class=\"nickname\"]")
				.all();
		//
		List<String> style = page.getHtml().xpath(
				"//div[@class=\"blog_list_b_l\"]").all();
		List<String> count = page.getHtml().xpath("//em").all();
		//
		List<String> introduction = page.getHtml().xpath(
				"//div[@class=\"blog_list_c\"]").all();
		//
		List<String> url = page.getHtml().xpath("//h3[@class=\"tracking-ad\"]")
				.links().all();
		for (int i = 0; i < title.size(); i++) {
			if (service.hava(url.get(i))) {
				Csdn c = service.find(url.get(i));
				c.setCount(getText(count.get(i)));
				service.update(c);
			} else {
				Csdn c = new Csdn();
				c.setTitle(getText3(title.get(i)));
				c.setAuthor(getText(author.get(i)));
				if (style.get(i).indexOf("<a") < 0) {
					c.setStyle("无");
				} else {
					c.setStyle(getText4(style.get(i)));
				}
				c.setCount(getText(count.get(i)));
				c.setIntroduction(getText1(introduction.get(i)));
				c.setUrl(url.get(i));
				service.save(c);
			}
		}
	}

	public Site getSite() {
		return site;
	}

	public void run() {
		while (true) {
			if (flag) {
				s = Spider.create(new CasnCrawlerAction()).addUrl(
						"http://blog.csdn.net/?&page=1").setScheduler(
						new FileCacheQueueScheduler(file)).thread(10);
				s.run();
				count++;
				if (count >= 2) {
					flag=false;
					over = true;
					count = 0;
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
		// s = Spider.create(new CasnCrawlerAction()).addUrl(
		// "http://blog.csdn.net/?&page=1").thread(20);
		// s.run();
	}

	public static String getText(String ele) {
		String result = ele.substring(ele.indexOf(">") + 1, ele.indexOf("<",
				ele.indexOf(">")));
		return result;

	}

	public static String getText1(String ele) {
		String result = ele.substring(ele.indexOf(">") + 1, ele.indexOf("<",
				ele.indexOf(">")));
		result = result.replaceAll("\n", "");
		return result;
	}

	public static String getText2(String ele) {
		String result = ele.substring(ele.indexOf(">") + 1, ele.indexOf("</a>",
				2));
		result = result.replaceAll("<br>", "");
		return result;

	}

	public static String getText3(String ele) {
		String result = ele.substring(ele.indexOf("_blank") + 8, ele.indexOf(
				"<", ele.indexOf("_blank")));
		return result;

	}

	public static String getText4(String ele) {
		String result = ele
				.substring(ele.indexOf("<a"), ele.indexOf("</a>", 2));
		result = result.substring(result.indexOf(">") + 1, result.length());
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
