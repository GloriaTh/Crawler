package com.crawler.action.song;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;
import us.codecraft.webmagic.scheduler.FileCacheQueueScheduler;

import com.crawler.bean.Song;
import com.crawler.service.SongService;

@SuppressWarnings("deprecation")
public class ProcessorAction extends Thread implements PageProcessor {
	private static ProcessorAction instance = new ProcessorAction();
	static boolean flag = true;
	static boolean over = false;
	static int count = 0;
	private static String file = ServletActionContext.getRequest().getRealPath(
			"/");
	private static Spider s;

	private ProcessorAction() {
	}

	public static ProcessorAction getInstance() {
		return instance;
	}

	private Site site = Site.me().setRetryTimes(3).setSleepTime(100);
	ApplicationContext cxt = new ClassPathXmlApplicationContext("beans.xml");
	SongService service = (SongService) cxt.getBean("songServiceImpl");

	public static final String URL_LIST = "/gd/gdList\\?&type=\\d+&page=\\d+";
	public static final String URL_SONGL = "http://5sing\\.kugou\\.com/\\w+/dj/\\w+\\.html";
	public static final String URL_SONG = "http://5sing\\.kugou\\.com/\\w+/\\d+\\.html";
	public static final String URL_SONGF = "http://5sing\\.kugou\\.com/fc/\\d+\\.html";
	public static final String URL_SONGY = "http://5sing\\.kugou\\.com/yc/\\d+\\.html";
	public static final String URL_SONGB = "http://5sing\\.kugou\\.com/bz/\\d+\\.html";

	public void process(Page page) {
		if (page.getUrl().regex(URL_LIST).match()) {
			page.addTargetRequests(page.getHtml().xpath("//ul[@class=\"fix\"]")
					.links().regex(URL_SONGL).all());
			page
					.addTargetRequests(page.getHtml().xpath(
							"//span[@class=\"pagecon\"]").links().regex(
							URL_LIST).all());
			// 文章页
		} else if (page.getUrl().regex(URL_SONGL).match()) {
			page
					.addTargetRequests(page.getHtml().xpath(
							"//span[@class=\"s_title\"]").links().regex(
							URL_SONG).all());
		} else if (page.getUrl().regex(URL_SONGF).match()) {
			Song s = new Song();
			s.setSongName(getText(page.getHtml().xpath("//h1").toString()));
			s.setSinger(getText3(page.getHtml().xpath(
					"//h3[@class=\"user_name\"]").toString()));
			s.setType("翻唱");
			s.setStyle(getText2(page.getHtml().xpath(
					"//li[@class=\"view_info_row\"]").toString()));
			s.setUrl(page.getUrl().toString());
			service.save(s);
		} else if (page.getUrl().regex(URL_SONGY).match()) {
			Song s = new Song();
			s.setSongName(getText(page.getHtml().xpath("//h1").toString()));
			s.setSinger(getText3(page.getHtml().xpath(
					"//h3[@class=\"user_name\"]").toString()));
			s.setType("原创");
			s.setStyle(getText2(page.getHtml().xpath(
					"//li[@class=\"view_info_row\"]").toString()));
			s.setUrl(page.getUrl().toString());
			service.save(s);
		} else if (page.getUrl().regex(URL_SONGB).match()) {
			Song s = new Song();
			s.setSongName(getText(page.getHtml().xpath("//h1").toString()));
			s.setSinger(getText3(page.getHtml().xpath(
					"//h3[@class=\"user_name\"]").toString()));
			s.setType("伴奏");
			s.setStyle("伴奏");
			s.setUrl(page.getUrl().toString());
			service.save(s);
		}
	}

	public Site getSite() {
		return site;
	}

	public void run() {
		while (true) {
			if (flag) {
				s = Spider.create(new ProcessorAction()).addUrl(
						"http://5sing.kugou.com/gd/gdList?&type=0&page=1")
						.setScheduler(new FileCacheQueueScheduler(file))
						.thread(10);
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

	}

	public static String getText(String ele) {
		String result = ele
				.substring(ele.indexOf(">") + 1, ele.indexOf("<", 2));
		return result;

	}

	public static String getText2(String ele) {
		String result = ele.substring(ele.indexOf("</em>") + 5, ele
				.indexOf("</li>"));
		result = result.replaceAll("amp;", "");
		result = result.replaceAll("&nbsp;", "-");
		if (result.substring(result.length() - 2, result.length() - 1).equals(
				"-")) {
			result = result.substring(0, result.length() - 2);
		} else {
			result = result.substring(0, result.length() - 1);
		}

		return result;
	}

	public static String getText3(String ele) {
		String result = ele.substring(ele.indexOf("_blank") + 9, ele.indexOf(
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