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
	$(document).ready(function() {
	function add(){
           $.ajax({
            url: "${pageContext.request.contextPath}/crawler/AddSongAction.action",
            type: "POST",
            data:$('#AddSongform').serialize(),
            async:false,
            success: function(data) {
            if(data!=""){
                 var obj = eval("("+data+")"); 
	             alert(obj);
            }else{
	            parent.$.fancybox.close();
            }
        }
   });
}
        
$('#button').click(function(){
        if($('#AddSongform').form('validate')){
	        add();
        }else{
            alert("有未填写数据或格式不正确");
        }
    });
    
  });
   </script>
	<body>
		<div style="position: relative; width: 100%;">
		<form id="MoreAddCsdnform">
			<table class="altrowstable" id="alternateAddCsdn" width="100%" height="0" border="1">
				<tbody id="AddCsdnjtable" align="center">
					<tr>
					    <th>
							<input id="AddCsdnall" type="checkbox" value="0">
						</th>
						<th>
							行数
						</th>
						<th>
							标题
						</th>
						<th>
							作者
						</th>
						<th>
							类型
						</th>
						<th>
							阅览数
						</th>
						<th>
							简介
						</th>
						<th>
							链接
						</th>
					</tr>
					<tr>
					    <td>
							<input class='AddCsdnselete' type='checkbox'>
						</td>
						<td class='AddCsdncount'>
							1
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入标题',required:true" id="title1" name="title" class="title" style="width: 80%"/>
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入作者',required:true" id="author1" name="author" class="author" style="width: 100px"/>
						</td>
						<td>
							<select class="easyui-combobox" name="style" id="style1" style="width: 100px;">
							</select>
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入阅览数',required:true" id="count1" name="count" class="count"  style="width: 60px;" maxlength="6"/>
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入简介',required:true" id="introduction1" name="introduction" class="introduction" style="width: 80%"/>
						</td>
						<td>
							<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入链接',required:true" id="url1" name="url" style="width: 80%"/>
						</td>
					</tr>
				</tbody>
				<tr>
				    <td align="center" colspan="8">
			         	<a id="MoreAddCsdn" class="button button-pill button-tiny">添加</a>
			         	<a id="AddCsdnRows" class="button button-primary button-pill button-tiny">添加行数</a>
			         	<a id="DeleteCsdnRows" class="button button-caution button-pill button-tiny">删除选定行</a>
				    </td>
				</tr>
			</table>
		</form>
		</div>
	</body>
</html>