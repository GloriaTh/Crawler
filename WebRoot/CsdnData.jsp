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
    font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;  
    color: #4f6b72;  
}  
  
a {  
    color: #c75f3e;  
}  
  
#mytable {  
    width: 700px;  
    padding: 0;  
    margin: 0;  
}  
  
caption {  
    padding: 0 0 5px 0;  
    width: 700px;      
    font: italic 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;  
    text-align: right;  
}  
  
th {  
    font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;  
    color: #4f6b72;  
    border-left: 1px solid #C1DAD7;  
    border-right: 1px solid #C1DAD7;  
    border-bottom: 1px solid #C1DAD7;  
    border-top: 1px solid #C1DAD7;  
    letter-spacing: 2px;  
    text-transform: uppercase;  
    text-align: center;  
    padding: 6px 6px 6px 12px;  
    background: #CAE8EA url(images/bg_header.jpg) no-repeat;  
}  
  
th.nobg {  
    border-top: 0;  
    border-left: 0;  
    border-right: 1px solid #C1DAD7;  
    background: none;  
}  
  
td {  
    border-left: 1px solid #C1DAD7; 
    border-right: 1px solid #C1DAD7;  
    border-top: 1px solid #C1DAD7;  
    border-bottom: 1px solid #C1DAD7;  
    background: #fff;  
    padding: 6px 6px 6px 12px;  
    color: #4f6b72;  
}  
  
  
td.alt {  
    background: #F5FAFA;  
    color: #797268;  
}  
  
th.spec {  
    border-left: 1px solid #C1DAD7;  
    border-top: 0;  
    background: #fff url(images/bullet1.gif) no-repeat;  
    font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;  
}  
  
th.specalt {  
    border-left: 1px solid #C1DAD7;  
    border-top: 0;  
    background: #f5fafa url(images/bullet2.gif) no-repeat;  
    font: bold 10px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;  
    color: #797268;  
}  
	</style>
		<script type="text/javascript" language="javascript"
			src="/js/jquery.js"></script>
		<script type="text/javascript" src="/js/jquery-ui.js"></script>
		<script type="text/javascript" src="/js/easy-ui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="/js/jquery.fancybox-1.3.1.pack.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
   });
</script>
	<body>
		<div title="小说列表" style="padding: 10px;">
						<table class="altrowstable" id="alternateCsdn" width="100%">
							<tbody>
								<tr align='center'>
									<td>
										<input id="Csdnall" type="checkbox" value="0">
									</td>
									<td>
										标题
									</td>
									<td>
										作者
									</td>
									<td>
										主题
									</td>
									<td>
										阅览数
									</td>
									<td>
										简介
									</td>
									<td>
										链接
									</td>
								</tr>
							</tbody>
							<tbody id="CsdnT">
							</tbody>
							<tr>
								<td colspan="7">
									<div id="Csdnspinner" class="spinner">
										<div class="rect1"></div>
										<div class="rect2"></div>
										<div class="rect3"></div>
										<div class="rect4"></div>
										<div class="rect5"></div>
									</div>
								</td>
							</tr>
						</table>
					</div>
	</body>
</html>