<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Crawler系统</title>
		<link rel="stylesheet" type="text/css" href="/js/main.css" />
		<link rel="stylesheet" type="text/css" href="/css/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="/css/icon.css">
		<link rel="stylesheet" type="text/css" href="/css/button.css">
		<link rel="stylesheet" type="text/css" href="/js/fancybox.css" />
		<style type="text/css">
body {
	font: normal 11px auto "Trebuchet MS", Verdana, Arial, Helvetica,
		sans-serif;
	color: #4f6b72;
	background: url(/css/images/1464916307322_1.png) no-repeat center center
		;
	-moz-background-size: cover;
	-ms-background-size: cover;
	-webkit-background-size: cover;
	background-size: cover;
}

h1 {
	color: #fff;
	font-weight: 100;
	font-size: 40px;
	margin: 0 auto;
	padding-bottom: 20px;
	border-bottom: 2px solid rgba(255, 255, 255, .2);
	max-width: 620px;
	line-height: 1.25;
}

h3 {
	color: rgba(255, 255, 255, .8);
	font-size: 16px;
	margin-bottom: 45px;
	margin-top: 25px;
	font-weight: 400;
}

.styled-select select {
	background: transparent;
	width: 268px;
	padding: 5px;
	font-size: 16px;
	border: 1px solid #ccc;
	height: 34px;
	-webkit-appearance: none; /*for chrome*/
}

.styled-select {
	height: 34px;
	overflow: hidden;
	background: url(/css/images/201203021104209592.jpg) no-repeat right
		#FFFAFA;
}
</style>
		<script type="text/javascript" language="javascript"
			src="/js/jquery.js"></script>
		<script type="text/javascript" src="/js/jquery-ui.js"></script>
		<script type="text/javascript" src="/js/easy-ui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="/js/jquery.fancybox-1.3.1.pack.js"></script>
		<script type="text/javascript" src="/js/jquery.jqplot.js"></script>
		<script type="text/javascript">
$(document).ready(function() {
     $.ajax({
	    url: "${pageContext.request.contextPath}/crawler/GetWebSiteAction.action",
	    type: "POST",
	    success: function(data) {
	        var obj = eval("("+data+")"); 
	             $.each(obj, function(index, value){
	                 $("#WebSite").append(
                        "<option value='"+value.webSiteName+"'>"+value.webSiteName+"</option>"
                     )
		         });
	    }
	});

   $("#show").click( function () {
       if($("#WebSite").val()=="www.luoo.net"){
           location.href="/ShowData.jsp";
       }else if($("#WebSite").val()=="5sing.kugou.com"){
           location.href="/fiveSingData.jsp";
       }
   })
});
  	</script>
		<body>
			<div class="styled-select" align="center"
				style="margin: 0 auto; padding-top: 250">
				<form id="SerchF">
					<select name="type" style="width: 110; height: 40px; padding: 9px 7px; font: 16px arial; border: 1px solid #b8b8b8; border-bottom: 1px solid #ccc; border-right: 0; vertical-align: top; outline: none; box-shadow: none;">
					    <option value="1">标题/名称</option>
					    <option value="2">作者/歌手</option>
					    <option value="3">类型</option>
					    <option value="4">链接</option>
					</select>
					<input name="word" class="text"
						style="width: 480; height: 40px; padding: 9px 7px; font: 16px arial; border: 1px solid #b8b8b8; border-bottom: 1px solid #ccc; border-right: 0; vertical-align: top; outline: none; box-shadow: none;" />
				    <a
						class="button button-glow button-rounded button-raised button-primary"
						id="ss">搜索</a>
				</form>
			</div>
		</body>
</html>
