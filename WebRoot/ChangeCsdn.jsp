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
            url: "${pageContext.request.contextPath}/csdn/ChangeCsdnAction.action?id="+"${requestScope.csdn.csdnId}",
            type: "POST",
            data:$('#AddCsdnform').serialize(),
            async:false,  
            success: function(data) {
            if(data!=""){
	             var obj = eval("("+data+")"); 
	             alert(obj);
            }else{
                $("#${requestScope.csdn.csdnId}"+"csdn",parent.document).children().eq(1).html($('#title').val());
                $("#${requestScope.csdn.csdnId}"+"csdn",parent.document).children().eq(2).html($('#author').val());
                $("#${requestScope.csdn.csdnId}"+"csdn",parent.document).children().eq(3).html($('#style').combobox('getValue'));
                $("#${requestScope.csdn.csdnId}"+"csdn",parent.document).children().eq(4).html($('#count').val());
                $("#${requestScope.csdn.csdnId}"+"csdn",parent.document).children().eq(5).html($('#introduction').val());
                $("#${requestScope.csdn.csdnId}"+"csdn",parent.document).children().eq(6).children().attr("href",$('#url').val());
                $("#${requestScope.csdn.csdnId}"+"csdn",parent.document).children().eq(6).children().html($('#url').val());
                
                $("#${requestScope.csdn.csdnId}"+"csdns",parent.document).children().eq(1).html($('#title').val());
                $("#${requestScope.csdn.csdnId}"+"csdns",parent.document).children().eq(2).html($('#author').val());
                $("#${requestScope.csdn.csdnId}"+"csdns",parent.document).children().eq(3).html($('#style').combobox('getValue'));
                $("#${requestScope.csdn.csdnId}"+"csdns",parent.document).children().eq(4).children().attr("href",$('#url').val());
                $("#${requestScope.csdn.csdnId}"+"csdns",parent.document).children().eq(4).children().html($('#url').val());
	            alert("修改成功");
	            parent.$.fancybox.close();
            }
         }
    });
}

$("#style").combobox({
          method: 'get',
          url: "${pageContext.request.contextPath}/csdn/GetCsdnStyleAction.action",
          valueField: 'styleName',
          textField: 'styleName',
      });
$("#style").combobox("select", "${requestScope.csdn.style}");

$('#button').click(function(){
        if($('#AddCsdnform').form('validate')){
	        add();
        }else{
            alert("有未填写数据或格式不正确");
        }
    });
	
});
   </script>
	<body>
		<div id="AddCsdnd">
		<form id="AddCsdnform">
			<table class="altrowstable" id="alternateAddCsdn" width="100%" border="1">
				<tbody id="AddCsdnjtable" align="center">
					<tr>
						<td>
							标题
						</td>
						<td>
							<input class="easyui-validatebox textbox" value="${requestScope.csdn.title}" data-options="missingMessage:'请输入标题',required:true" id="title" name="title" style="width: 400px"/>
					    </td>
					</tr>
					<tr>
						<td>
							作者
						</td>
						<td>
							<input class="easyui-validatebox textbox" value="${requestScope.csdn.author}" data-options="missingMessage:'请输入作者',required:true" id="author" name="author" style="width: 200px"/>
						</td>
					</tr>
					<tr>
						<td>
							类型
						</td>
						<td>
							<select class="easyui-combobox" value="${requestScope.csdn.style}" name="style" id="style" style="width: 100px">
							</select>
						</td>
					</tr>
					<tr>
						<td>
							阅览数
						</td>
						<td>
						    <input class="easyui-validatebox textbox" value="${requestScope.csdn.count}" data-options="missingMessage:'请输入阅览数',required:true" id="count" name="count" style="width: 100px"/>
						</td>
					</tr>
					<tr>
						<td>
							简介
						</td>
						<td>
						    <input class="easyui-validatebox textbox" value="${requestScope.csdn.introduction}" data-options="missingMessage:'请输入简介',required:true" id="introduction" name="introduction" style="width: 90%"></input>
						</td>
					</tr>
					<tr>
						<td>
							链接
						</td>
						<td>
							<input class="easyui-validatebox textbox" value="${requestScope.csdn.url}" data-options="missingMessage:'请输入链接',required:true" id="url" name="url" style="width: 80%"/>
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