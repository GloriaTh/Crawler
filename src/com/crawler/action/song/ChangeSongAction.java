package com.crawler.action.song;

import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.bean.Song;
import com.crawler.service.SongService;
import com.crawler.utils.GeneralMethod;

@Controller
public class ChangeSongAction {
	@Resource
	SongService service;

	private String id;
	private String songName;
	private String singer;
	private String type;
	private String style;
	private String url;
	private String test;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getSongName() {
		return songName;
	}

	public void setSongName(String songName) {
		this.songName = songName;
	}

	public String getSinger() {
		return singer;
	}

	public void setSinger(String singer) {
		this.singer = singer;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTest() {
		return test;
	}

	public void setTest(String test) {
		this.test = test;
	}

	public void execute() {
		try {
			if (!Pattern.compile("^[1-9]\\d*$").matcher(String.valueOf(id))
					.matches()) {
				GeneralMethod.BackMessage("编号不正确或为空");
				return;
			} else if (singer == null || "".equals(singer.trim())) {
				GeneralMethod.BackMessage("歌名不能为空");
				return;
			} else if (singer == null || "".equals(singer.trim())) {
				GeneralMethod.BackMessage("歌手不能为空");
				return;
			} else if (type == null || "".equals(type.trim())) {
				GeneralMethod.BackMessage("类型不能为空");
				return;
			} else if (type == null || "".equals(style.trim())) {
				GeneralMethod.BackMessage("风格不能为空");
				return;
			} else if (url == null || "".equals(url.trim())) {
				GeneralMethod.BackMessage("链接不能为空");
				return;
			}

			id = id.replace("song", "");
			style = style.replaceAll(",", "-");
			// else if (!Pattern.compile("^[\u4e00-\u9fa5]*").matcher(url)
			// .matches()) {
			// GeneralMethod.BackMessage("链接格式不正确");
			// return;
			// }

			Song s = service.find(Integer.parseInt(id));
			s.setSongName(songName);
			s.setSinger(singer);
			s.setType(type);
			s.setStyle(style);
			s.setUrl(url);

			service.update(s);
		} catch (Exception e) {
			e.printStackTrace();
			GeneralMethod.BackMessage("发生错误");
		}
	}
}