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
            url: "${pageContext.request.contextPath}/song/ChangeSongAction.action?id="+"${requestScope.song.songId}",
            type: "POST",
            data:$('#form').serialize(),
            async:false,  
            success: function(data) {
            if(data!=""){
	             var obj = eval("("+data+")"); 
	             alert(obj);
            }else{
                $("#${requestScope.song.songId}"+"song",parent.document).children().eq(1).html($('#songName').val());
                $("#${requestScope.song.songId}"+"song",parent.document).children().eq(2).html($('#singer').val());
                $("#${requestScope.song.songId}"+"song",parent.document).children().eq(3).html($('#type').combobox('getValue'));
                var styletemp = "";
                $.each($('#style').combobox('getValues'), function(i, n){
                    styletemp += n+"-";
				});
				styletemp=styletemp.substring(0,styletemp.length-1);
                $("#${requestScope.song.songId}"+"song",parent.document).children().eq(4).html(styletemp);
                $("#${requestScope.song.songId}"+"song",parent.document).children().eq(5).children().attr("href",$('#url').val());
                $("#${requestScope.song.songId}"+"song",parent.document).children().eq(5).children().html($('#url').val());
                
                $("#${requestScope.song.songId}"+"songs",parent.document).children().eq(1).html($('#songName').val());
                $("#${requestScope.song.songId}"+"songs",parent.document).children().eq(2).html($('#singer').val());
                $("#${requestScope.song.songId}"+"songs",parent.document).children().eq(3).html(styletemp);
                $("#${requestScope.song.songId}"+"songs",parent.document).children().eq(4).children().attr("href",$('#url').val());
                $("#${requestScope.song.songId}"+"songs",parent.document).children().eq(4).children().html($('#url').val());
	            alert("修改成功");
	            parent.$.fancybox.close();
            }
         }
    });
}

var count=0;
$("#type").combobox({
          method: 'get',
          url: "${pageContext.request.contextPath}/song/GetTypeAction.action",
          panelHeight:'auto',
          valueField: 'typeName',
          textField: 'typeName',
          onLoadSuccess: function (q, row) {
            $(this).combobox("select", "${requestScope.song.type}");
          },
          onSelect: function (q, row) {
	          $("#style").combobox({
		            method: 'get',
		            url: "${pageContext.request.contextPath}/song/GetStyleAction.action?type="+$("#type").combobox("getValue"),
		            valueField: 'styleName',
		            textField: 'styleName',
		            multiple:true,
		            separator : "-",
		            required:true,
		            missingMessage:'请选择风格',
		        });
		        if(count==0){
		            var aaa = "${requestScope.song.style}".split("-");
		            $.each( aaa, function(i, n){
		                $("#style").combobox("select", n.trim());
		                count++;
					});
		        }
          },
      });
      
$('#button').click(function(){
        if($('#form').form('validate')){
	        add();
        }else{
            alert("有未填写数据或格式不正确");
        }
    });
	
});
</script>
	<body>
		<div align="center">
			<form id="form">
				<table width="100%" align="center">
				    <tbody id="AddSongtable" align="center">
						<tr>
							<td>
								歌名:
							</td>
							<td>
								<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入歌名',required:true" type="text" id="songName" name="songName"
							 	value="${requestScope.song.songName}" style="width: 80%;" maxlength="150"/>
							</td>
						</tr>
						<tr>
							<td>
								歌手:
							</td>
							<td>
								<input class="easyui-validatebox textbox" data-options="missingMessage:'请输入歌手',required:true" type="text" id="singer" name="singer"
									value="${requestScope.song.singer}" style="width: 80%;" maxlength="150"/>
							</td>
						</tr>
						<tr>
							<td>
								类型:
							</td>
							<td>
								<select id="type" name="type" style="width: 60;">
								</select>
							</td>
						</tr>
						<tr>
							<td>
								风格:
							</td>
							<td>
							    <input type="text" id="style" name="style" style="width: 80%;" maxlength="150"/>
							</td>
						</tr>
						<tr>
							<td>
								链接:
							</td>
							<td>
							    <input class="easyui-validatebox textbox" data-options="missingMessage:'请输入链接',required:true" id="url" name="url" value="${requestScope.song.url}" style="width: 80%;" maxlength="250"/>
							</td>
						</tr>
						<tr align="center">
							<td colspan="2">
							    <a id="button" class="button button-primary button-pill button-tiny">修改</a>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</body>
</html>
