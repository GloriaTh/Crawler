package com.crawler.utils;

import us.codecraft.webmagic.Page;
import us.codecraft.webmagic.Site;
import us.codecraft.webmagic.Spider;
import us.codecraft.webmagic.processor.PageProcessor;

public class MusicCrawler extends Thread implements PageProcessor {
	private static MusicCrawler instance = new MusicCrawler();
	static boolean flag = true;
	static boolean over = false;
	static int count = 0;
	private static Spider s;

	private MusicCrawler() {
	}

	public static MusicCrawler getInstance() {
		return instance;
	}

	private Site site = Site.me().setRetryTimes(3).setSleepTime(100);
	public static final String URL_LIST = "/discover/playlist/\\?order=hot&cat=\\w+";
	public static final String URL_SHEET = "/playlist\\?id=\\d+";
	public static final String URL_SONG = "/song\\?id=\\d+";

	public void process(Page page) {
		System.out.println(page.getUrl());
		if (page.getUrl().regex(URL_LIST).match()
				|| page.getUrl().toString().equals(
						"http://music.163.com/#/discover/playlist")) {
			System.out.println(page.getHtml().xpath("//p[@class=\"dec\"]")
					.links().toString());
			page.addTargetRequests(page.getHtml().xpath("//a[@class=\"tit\"]")
					.links().regex(URL_SHEET).all());
			page.addTargetRequests(page.getHtml().xpath("//a[@class=\"zpgi\"]")
					.links().regex(URL_LIST).all());
		} else if (page.getUrl().regex(URL_SHEET).match()) {
			System.out.println(page.getHtml().xpath("//span[@class=\"txt\"]/a")
					.links().toString());
			page.addTargetRequests(page.getHtml().xpath(
					"//span[@class=\"txt\"]/a").links().regex(URL_SONG).all());
		} else if (page.getUrl().regex(URL_SONG).match()) {
			String songName = page.getHtml().xpath("//em[@class=\"f-ff2\"]")
					.toString();
			String songUrl = page.getUrl().toString();
			System.out.println(songName + ":" + songUrl);
		}
	}

	public Site getSite() {
		return site;
	}

	public static void main(String[] args) {
		MusicCrawler n = new MusicCrawler();
		n.run();
	}

	public void run() {
		s = Spider.create(new MusicCrawler()).addUrl(
				"http://music.163.com/#/discover/playlist").thread(10);
		s.run();
	}
}