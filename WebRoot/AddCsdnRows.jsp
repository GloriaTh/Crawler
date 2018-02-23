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
	function change(){
	    var number = $('#rowNumer').val();
	    var index =$("#AddCsdnjtable tr:last td", parent.document).eq(2).children().attr("id");
	    var count =$(".AddCsdncount", parent.document).size();
	    if(index==undefined){
	        index="title1";
	    }
	    index = index.substring(5, index.length);
	    index++;
	    parent.AddCsdnindex=index;
	    parent.AddCsdnnumber=number;
	    for(number;number>0;number--){
	    count++;
	    var title = "title"+index;
	    var csdnauthor = "csdnauthor"+index;
	    var csdnstyle = "csdnstyle"+index;
	    var csdncount = "csdncount"+index;
	    var csdnintroduction = "csdnintroduction"+index;
	    var url = "csdnurl"+index;
        $("#AddCsdnjtable", parent.document).append(
           "<tr><td><input class='AddCsdnselete' type='checkbox'></td>"+
              "<td class='AddCsdncount'>"+count+"</td>"+
                "<td><input id='"+title+"' maxlength='60' class='textbox' name='title' style='width: 80%'/></td>"+
                  "<td><input id='"+csdnauthor+"' maxlength='15' class='easyui-validatebox textbox' name='author' style='width: 100px'/></td>"+
		            "<td><select name='style' id='"+csdnstyle+"' style='width: 100px'></select></td>"+
		              "<td><input id='"+csdncount+"' maxlength='6' class='easyui-validatebox textbox' name='count' style='width: 60px'/></td>"+
		                "<td><input id='"+csdnintroduction+"' maxlength='150' class='easyui-validatebox textbox' name='introduction' style='width: 80%'/></td>"+
		                  "<td><input id='"+url+"' maxlength='150' class='easyui-validatebox textbox' name='url' style='width: 80%'/></td></tr>"
               );
         index++;
	    }
		parent.$.fancybox.close();
}
        
$('#button').click(function(){
        if($('#form').form('validate')){
            change(); 
        }else{
            alert("有未填写数据或格式不正确");
        }
    });
	
	$.extend($.fn.validatebox.defaults.rules, {
		    Number: {
		        validator: function (value) {  
		            return value<=50;  
		        },  
		        message: '请输入小于等于50的数字'  
		    }
		});
	
   });
</script>
	<body>
		<div align="center">
			<font id="message" color="red"></font>
			<form id="form">
				<table>
					<tr>
						<td>
							添加行数:
						</td>
						<td>
							<input onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="2" class="easyui-validatebox textbox" data-options="missingMessage:'请勿一次添加过多行数',required:true,validType:'Number'"
							   id="rowNumer" type="text"/>
						</td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<input type="button" id="button" class="button button-primary button-pill button-tiny" value="添加"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>