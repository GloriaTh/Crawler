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
	    var index =$("#AddSongjtable tr:last td", parent.document).eq(2).children().attr("id");
	    var count =$(".AddSongcount", parent.document).size();
	    if(index==undefined){
	        index="songName1";
	    }
	    index = index.substring(8, index.length);
	    index++;
	    parent.AddSongindex=index;
	    parent.AddSongnumber=number;
	    for(number;number>0;number--){
	    count++;
	    var song = "songName"+index;
	    var sing = "singer"+index;
	    var type = "type"+index;
	    var style = "style"+index;
	    var url = "url"+index;
        $("#AddSongjtable", parent.document).append(
           "<tr><td><input class='AddSongselete' type='checkbox'></td>"+
              "<td class='AddSongcount'>"+count+"</td>"+
                "<td><input id='"+song+"' maxlength='150' class='  textbox' name='songName'/></td>"+
                  "<td><input id='"+sing+"' maxlength='150' class='easyui-validatebox textbox' name='singer'/></td>"+
		            "<td><select name='type' id='"+type+"' style='width: 60px'></select></td>"+
		              "<td id='"+style+"Td'><input id='"+style+"' name='style'/></td>"+
		                "<td><input id='"+url+"' maxlength='250' class='easyui-validatebox textbox' name='url'/></td></tr>"
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