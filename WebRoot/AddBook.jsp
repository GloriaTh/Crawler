<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<link rel="stylesheet" type="text/css" href="/js/main.css" />
	<link rel="stylesheet" type="text/css" href="/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="/css/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/js/fancybox.css" />
	<link rel="stylesheet" type="text/css" href="/css/button.css" />
	<style type="text/css">
body {
	font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica,
		sans-serif;
	color: #4f6b72;
	background: url(/css/images/1464916307322_1.png) no-repeat center center;
	background-size:100% 100%;
}

table.altrowstable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-width: 1px;
	border-color: #a9c6c9;
	border-collapse: collapse;
}

table.altrowstable th {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}

table.altrowstable td {
	border-width: 1px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}
</style>
	<script type="text/javascript" src="/js/jquery.js"></script>
	<script type="text/javascript" src="/js/easy-ui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="/js/jquery.fancybox-1.3.1.pack.js"></script>
	<script type="text/javascript">
   </script>
	<body>
		<div id="AddBookd" style="width: 100%;height: 100%;" >
		<form id="AddBookform">
			<table class="altrowstable" id="alternateAddBook" width="100%" height="60%" border="1">
				<tbody id="AddBookjtable" align="center">
					<tr>
						<td>
							书名
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入书名',required:true" id="bookName" name="bookName"/>
					    </td>
					</tr>
					<tr>
						<td>
							作者
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入作者',required:true" id="author" name="author"/>
						</td>
					</tr>
					<tr>
						<td>
							类型
						</td>
						<td>
						    <select class="easyui-combobox" name="style" id="style" style="width: 100px">
							   <option value="玄幻奇幻">玄幻奇幻</option>
							   <option value="武侠仙侠">武侠仙侠</option>
							   <option value="同人小说">同人小说</option>
							   <option value="都市言情">都市言情</option>
							   <option value="青春校园">青春校园</option>
							   <option value="军事历史">军事历史</option>
							   <option value="科幻网游">科幻网游</option>
							   <option value="恐怖灵异">恐怖灵异</option>
							   <option value="轻小说">轻小说</option>
							   <option value="女生小说">女生小说</option>
							   <option value="短篇其他">短篇其他</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							授权状态
						</td>
						<td>
						    <select class="easyui-combobox" name="monopoly" id="monopoly" style="width: 100px">
						       <option value="驻站作品">驻站作品</option>
							   <option value="授权作品">授权作品</option>
							   <option value="专属作品">专属作品</option>
							   <option value="A级签约">A级签约</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							简介
						</td>
						<td>
						    <textarea class="easyui-validatebox" id="introduction" name="introduction" rows="8" cols="100"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							链接
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入链接',required:true" id="url" name="url"/>
						</td>
					</tr>
				</tbody>
				<tr>
				    <td align="center" colspan="7">
			         	<a id="MoreAddBook" class="button button-pill button-tiny">添加</a>
				    </td>
				</tr>
			</table>
		</form>
		</div>
	</body>
</html>