package com.crawler.utils;

public class SaveSongPipeline{
//	@Resource
//	CrawlerService service;
//
//	public void process(ResultItems resultItems, Task task) {
//		System.out.println("get page: " + resultItems.getRequest().getUrl());
//		// 遍历所有结果，输出到控制台，上面例子中的"author"、"name"、"readme"都是一个key，其结果则是对应的value
//		boolean flag = true;
//		List<Song> list = new ArrayList<Song>();
//		Song song = new Song();
//		for (Map.Entry<String, Object> entry : resultItems.getAll().entrySet()) {
//			if (flag) {
//				song.setSongName(entry.getValue().toString());
//				flag = false;
//			} else {
//				song.setSinger(entry.getValue().toString());
//				list.add(song);
//				flag = true;
//				song = new Song();
//			}
//		}
//		for (Song s : list) {
//			service.save(s);
//		}
//	}
public static void main(String[] args) {
	System.out.println(9%3);
}
}
