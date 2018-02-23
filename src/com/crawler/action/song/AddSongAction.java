package com.crawler.action.song;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import com.crawler.service.SongService;
import com.crawler.utils.GeneralMethod;

@Controller
public class AddSongAction {
	@Resource
	SongService service;

	private String songName;
	private String singer;
	private String type;
	private String styles;
	private String url;

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

	public String getStyles() {
		return styles;
	}

	public void setStyles(String styles) {
		this.styles = styles;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void execute() {
		try {
			String[] songNames = songName.split(",");
			String[] singers = singer.split(",");
			String[] types = type.split(",");
			styles = styles.substring(1, styles.length() - 1);
			String[] styleS = styles.split(",-");
			String[] urls = url.split(",");

			for (int i = 0; i < songNames.length; i++) {
				if (songNames[i] == null || "".equals(songNames[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行歌名未填写,请填写歌名");
					return;
				}
				songNames[i] = songNames[i].trim();
			}

			for (int i = 0; i < singers.length; i++) {
				if (singers[i] == null || "".equals(singers[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行歌手未填写，请填写歌手");
					return;
				}
				singers[i] = singers[i].trim();
			}

			for (int i = 0; i < types.length; i++) {
				if (types[i] == null || "".equals(types[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行类型未选择,请选择一个类型");
					return;
				}
				types[i] = types[i].trim();
			}

			for (int i = 0; i < styleS.length; i++) {
				if (styleS[i] == null || "".equals(styleS[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行风格未填写，请填写风格");
					return;
				}
				styleS[i] = styleS[i].trim();
			}

			for (int i = 0; i < urls.length; i++) {
				if (urls[i] == null || "".equals(urls[i].trim())) {
					i += 1;
					GeneralMethod.BackMessage("第" + i + "行链接未填写，请填写链接");
					return;
				}
				urls[i] = urls[i].trim();
			}

			String result = service.MoreAdd(songNames, singers, types, styleS,
					urls);

			GeneralMethod.BackMessage(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}