package com.crawler.utils;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;

public class GeneralMethod {
	public static void BackMessage(String message) {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/html;charset=utf-8");

			PrintWriter out = response.getWriter();
			Gson gson = new Gson();
			String json = gson.toJson(message);
			out.write(json);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	public static void BackMap(Map map) {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/html;charset=utf-8");

			PrintWriter out = response.getWriter();
			Gson gson = new Gson();
			String json = gson.toJson(map);
			out.write(json);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@SuppressWarnings("unchecked")
	public static void BackList(List list) {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setContentType("text/html;charset=utf-8");

			PrintWriter out = response.getWriter();
			Gson gson = new Gson();
			String json = gson.toJson(list);
			out.write(json);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
