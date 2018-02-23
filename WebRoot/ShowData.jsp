<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>数据展示</title>
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

.oddrowcolor {
	background-color: #d4e3e5;
}

.evenrowcolor {
	background-color: #c3dde0;
}
</style>
		<script type="text/javascript" src="/js/jquery.js"></script>
		<script type="text/javascript" src="/js/easy-ui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="/js/jquery.fancybox-1.3.1.pack.js"></script>
		<script type="text/javascript">
$(document).ready(function() {
page = 1;
function getData(){
    $.ajax({
	    url: "${pageContext.request.contextPath}/crawler/SaveDataAction.action?page="+page,
	    type: "POST",
	    success: function(data) {
	         if(data=='""'){
	             alert("搜索结束");
	         }
	         else{
	             var obj = eval("("+data+")"); 
	             $.each(obj, function(index, value){
                   $("#alternatecolor").append(
	                 "<tr align='center'><td>"+value.songName+"</td>"
				         +"<td>"+value.singer+"</td></tr>" 
                      )
		         });
		         page+=1;
		         altRows("alternatecolor");
		         getData();
	         }
	    }
	});
}

window.load= getData();

function altRows(id){
	if(document.getElementsByTagName){  
		
		var table = document.getElementById(id);  
		var rows = table.getElementsByTagName("tr"); 
		 
		for(i = 0; i < rows.length; i++){          
			if(i % 2 == 0){
				rows[i].className = "evenrowcolor";
			}else{
				rows[i].className = "oddrowcolor";
			}      
		}
	}
}

window.onload=function(){
	altRows('alternatecolor');
}
});
  	</script>
		<body>
			<table class="altrowstable" id="alternatecolor" width="100%">
			   <tr align='center'>
			       <td>歌名</td>
			       <td>歌手</td>
			   </tr>
			</table>
		</body>
</html>
