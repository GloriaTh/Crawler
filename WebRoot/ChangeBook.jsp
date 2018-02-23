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
	<script type="text/javascript" src="/js/jquery.js"></script>
	<script type="text/javascript" src="/js/easy-ui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="/js/jquery.fancybox-1.3.1.pack.js"></script>
	<script type="text/javascript">
$(document).ready(function() {
	function add(){ 
      $.ajax({
            url: "${pageContext.request.contextPath}/book/ChangeBookAction.action?id="+"${requestScope.book.bookId}",
            type: "POST",
            data:$('#AddBookform').serialize(),
            async:false,  
            success: function(data) {
            if(data!=""){
	             var obj = eval("("+data+")"); 
	             alert(obj);
            }else{
                $("#${requestScope.book.bookId}"+"book",parent.document).children().eq(1).html($('#bookName').val());
                $("#${requestScope.book.bookId}"+"book",parent.document).children().eq(2).html($('#author').val());
                $("#${requestScope.book.bookId}"+"book",parent.document).children().eq(3).html($('#style').combobox('getValue'));
                $("#${requestScope.book.bookId}"+"book",parent.document).children().eq(4).html($('#monopoly').val());
                $("#${requestScope.book.bookId}"+"book",parent.document).children().eq(5).html($('#introduction').val());
                $("#${requestScope.book.bookId}"+"book",parent.document).children().eq(6).children().attr("href",$('#url').val());
                $("#${requestScope.book.bookId}"+"book",parent.document).children().eq(6).children().html($('#url').val());
                
                $("#${requestScope.book.bookId}"+"books",parent.document).children().eq(1).html($('#bookName').val());
                $("#${requestScope.book.bookId}"+"books",parent.document).children().eq(2).html($('#author').val());
                $("#${requestScope.book.bookId}"+"books",parent.document).children().eq(3).html($('#style').combobox('getValue'));
                $("#${requestScope.book.bookId}"+"books",parent.document).children().eq(4).children().attr("href",$('#url').val());
                $("#${requestScope.book.bookId}"+"books",parent.document).children().eq(4).children().html($('#url').val());
	            alert("修改成功");
	            parent.$.fancybox.close();
            }
         }
    });
}

$("#style").combobox("select", "${requestScope.book.style}");
$("#monopoly").combobox("select", "${requestScope.book.monopoly}");


$('#button').click(function(){
        if($('#AddBookform').form('validate')){
	        add();
        }else{
            alert("有未填写数据或格式不正确");
        }
    });
	
});
   </script>
	<body>
		<div id="AddBookd">
		<form id="AddBookform">
			<table class="altrowstable" id="alternateAddBook" width="100%" border="1">
				<tbody id="AddBookjtable" align="center">
					<tr>
						<td>
							书名
						</td>
						<td>
							<input class="easyui-validatebox textbox" value="${requestScope.book.bookName}" data-options="missingMessage:'请输入书名',required:true" id="bookName" name="bookName" style="width: 200px"/>
					    </td>
					</tr>
					<tr>
						<td>
							作者
						</td>
						<td>
							<input class="easyui-validatebox textbox" value="${requestScope.book.author}" data-options="missingMessage:'请输入作者',required:true" id="author" name="author" style="width: 200px"/>
						</td>
					</tr>
					<tr>
						<td>
							类型
						</td>
						<td>
							<select class="easyui-combobox" value="${requestScope.book.style}" name="style" id="style" style="width: 200px">
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
						    <select class="easyui-combobox" name="monopoly" id="monopoly" style="width: 200px">
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
						    <textarea style="word-break:break-all" class="easyui-validatebox" data-options="missingMessage:'请输入简介',required:true" id="introduction" name="introduction" rows="8" cols="60">${requestScope.book.introduction}</textarea>
						</td>
					</tr>
					<tr>
						<td>
							链接
						</td>
						<td>
							<input class="easyui-validatebox textbox" value="${requestScope.book.url}" data-options="missingMessage:'请输入链接',required:true" id="url" name="url" style="width: 400px"/>
						</td>
					</tr>
				</tbody>
				<tr align="center">
					<td colspan="2">
					    <a id="button" class="button button-primary button-pill button-tiny">修改</a>
					</td>
				</tr>
			</table>
		</form>
		</div>
	</body>
</html>