<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>数据展示</title>
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

.oddrowcolor {
	background-color: #d4e3e5;
}

.evenrowcolor {
	background-color: #c3dde0;
}


.spinner {
  margin: 100px auto;
  width: 50px;
  height: 60px;
  text-align: center;
  font-size: 10px;
}
 
.spinner > div {
  background-color: #67CF22;
  height: 100%;
  width: 6px;
  display: inline-block;
   
  -webkit-animation: stretchdelay 1.2s infinite ease-in-out;
  animation: stretchdelay 1.2s infinite ease-in-out;
}
 
.spinner .rect2 {
  -webkit-animation-delay: -1.1s;
  animation-delay: -1.1s;
}
 
.spinner .rect3 {
  -webkit-animation-delay: -1.0s;
  animation-delay: -1.0s;
}
 
.spinner .rect4 {
  -webkit-animation-delay: -0.9s;
  animation-delay: -0.9s;
}
 
.spinner .rect5 {
  -webkit-animation-delay: -0.8s;
  animation-delay: -0.8s;
}
 
@-webkit-keyframes stretchdelay {
  0%, 40%, 100% { -webkit-transform: scaleY(0.4) } 
  20% { -webkit-transform: scaleY(1.0) }
}
 
@keyframes stretchdelay {
  0%, 40%, 100% {
    transform: scaleY(0.4);
    -webkit-transform: scaleY(0.4);
  }  20% {
    transform: scaleY(1.0);
    -webkit-transform: scaleY(1.0);
  }
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
wait  =0;
index =0;

name = "";
sing = "";
type = "";
style = "";
url = "";
function getData(){
    $.ajax({
	    url: "${pageContext.request.contextPath}/song/FiveSingAction.action?index="+index+"&wait="+wait,
	    type: "POST",
	    success: function(data) {
	         if(data=='"over"'){
	                wait=2;
	                stop();
	                alert("搜索结束");
	                $("#Control").text("开始");
		            $("#Control").removeAttr("disabled");
		            $(".spinner").attr("style","visibility:hidden");
	         }else if(data=='"wait"'){
	            wait = 0;
	            $("#Control").text("开始");
		        $("#Control").removeAttr("disabled");
		        $(".spinner").attr("style","visibility:hidden");
	         }else{
	             var obj = eval("("+data+")"); 
	             $.each(obj, function(index, value){
	                 if(value.songName=="!!!" && value.singer=="!!!"){
	                     alert("发生错误");
	                     return;
	                 }
	                 
	              if($("#Control").text()=="等待中"){
	                  $("#Control").text("暂停");
	                  $("#Control").removeAttr("disabled");
	              }
	                 
	               $("#SongT").append(
	                 "<tr align='center' id="+value.songId+" style='cursor: pointer'><td><input class='Songselete' type='checkbox' value='"+value.songId+"'></td>"
			           +"<td class='SongChange'>"+value.songName+"</td>"
			              +"<td class='SongChange'>"+value.singer+"</td>"
			                +"<td class='SongChange'>"+value.type+"</td>"
			                  +"<td class='SongChange'>"+value.style+"</td>"
			                    +"<td class='SongChange'><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
                      )
		         });
		         index=$("#alternatecolor tr").length-1;
		         altRows("alternatecolor");
				 getData();
	         }
	    }
	});
}

$.ajax({
    url: "${pageContext.request.contextPath}/song/GetSongAction.action",
    type: "POST",
    success: function(data) {
        var obj = eval("("+data+")"); 
        
        $.each(obj, function(index, value){
	        $("#SongT").append(
	        "<tr align='center' id="+value.songId+" style='cursor: pointer'><td><input class='Songselete' type='checkbox' value='"+value.songId+"'></td>"
	           +"<td class='SongChange'>"+value.songName+"</td>"
	              +"<td class='SongChange'>"+value.singer+"</td>"
	                +"<td class='SongChange'>"+value.type+"</td>"
	                  +"<td class='SongChange'>"+value.style+"</td>"
	                    +"<td class='SongChange'><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
	             )
         });
         altRows("alternatecolor");
         index=$("#alternatecolor tr").length-1;
    }
});

function stop(){
    $.ajax({
	    url: "${pageContext.request.contextPath}/song/FiveSingAction.action?index="+index+"&wait="+wait,
	    type: "POST",
	    success: function(data) {
	    }
	});
}

$("#Control").live("click", function() {
    if($("#Control").text()=="开始"){
        $("#Control").text("等待中");
        $("#Control").attr("disabled","disabled");
        $(".spinner").attr("style","visibility:visible");
        getData();
    }else if($("#Control").text()=="暂停"){
        wait = 1;
        $("#Control").text("暂停中");
        $("#Control").attr("disabled","disabled");
    }
});

$(".SongChange").live("click", function() {
        var id = $(this).parent().attr("id");
        $.fancybox({
            width:600,
			height:250,
            href: "/crawler/FindSongAction?id="+id,
        });
});

$("#Songall").live("click", function() {
    if(this.checked){    
        $(".Songselete").attr("checked", true);   
    }else{
        $(".Songselete").attr("checked", false); 
    }  
});

$("#addSong").live("click", function() {
        if ($('#tt').tabs('exists', "添加歌曲")){
			$('#tt').tabs('select', "添加歌曲");
		} else {
			$('#tt').tabs('add',{
			    title:"添加歌曲",
				closable:true,
				href:'/AddSong.jsp',
				onLoad:function(){
                   window.load= altRows('alternateSong');
			    }
            })
        }
});

function delSong(id){
      $.ajax({
            url: "${pageContext.request.contextPath}/song/DeleteSongAction.action?id="+id,
            type: "POST",
            async:false,
            success: function(data) {
            if(data!=""){
		       alert(data);
	        }else{
	           index=$("#alternatecolor tr").length-1;
	           alert("删除成功");
	           $("#Songall").attr("checked", false);
	        }
	      }
	});
}

$("#DeleteSong").live("click", function() {
      if($("input[class='Songselete']:checkbox:checked").size()==0){
          alert("未选中员工数据,请点击选择框进行选择");
      }else{
        $.messager.confirm('是否删除', '你确定要删除吗?', function(r){
			if (r){
				var index=0;
				var seleteId = "";
			    $("input[class='Songselete']:checkbox:checked").each(function(i){
				    if($(this).val()!=0){
				       seleteId+=$(this).val()+",";
				       var s =$(this).val()
				       $("#"+s).remove();
				       index++;
				     }
				});
				delSong(seleteId);
			}
		});
   }
});

$("#DeleteAll").live("click", function() {
    $.ajax({
            url: "${pageContext.request.contextPath}/song/DeleteAllAction.action",
            type: "POST",
            async:false,
            success: function(data) {
            if(data=='"success"'){
               index=1;
               $("#SongT").remove();
               alert("删除成功");
            }
      }
});
});

$('#Mana').accordion({
    onSelect:function(title, index)
    {
        alert('选择了第'+(index+1)+'个面板');
    }
});

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
    window.load= altRows('alternatecolor');
});
  	</script>
<body>
	<h2>Basic ComboBox</h2>
	<p>Type in ComboBox to try auto complete.</p>
	<div style="margin:20px 0"></div>
	
	<select class="easyui-combobox" name="state" style="width:200px;">
		<option value="AL">Alabama</option>
		<option value="AK">Alaska</option>
		<option value="AZ">Arizona</option>
		<option value="AR">Arkansas</option>
		<option value="CA">California</option>
		<option value="CO">Colorado</option>
		<option value="CT">Connecticut</option>
		<option value="DE">Delaware</option>
		<option value="FL">Florida</option>
		<option value="GA">Georgia</option>
		<option value="HI">Hawaii</option>
		<option value="ID">Idaho</option>
		<option value="IL">Illinois</option>
		<option value="IN">Indiana</option>
		<option value="IA">Iowa</option>
		<option value="KS">Kansas</option>
		<option value="KY">Kentucky</option>
		<option value="LA">Louisiana</option>
		<option value="ME">Maine</option>
		<option value="MD">Maryland</option>
		<option value="MA">Massachusetts</option>
		<option value="MI">Michigan</option>
		<option value="MN">Minnesota</option>
		<option value="MS">Mississippi</option>
		<option value="MO">Missouri</option>
		<option value="MT">Montana</option>
		<option value="NE">Nebraska</option>
		<option value="NV">Nevada</option>
		<option value="NH">New Hampshire</option>
		<option value="NJ">New Jersey</option>
		<option value="NM">New Mexico</option>
		<option value="NY">New York</option>
		<option value="NC">North Carolina</option>
		<option value="ND">North Dakota</option>
		<option value="OH" selected>Ohio</option>
		<option value="OK">Oklahoma</option>
		<option value="OR">Oregon</option>
		<option value="PA">Pennsylvania</option>
		<option value="RI">Rhode Island</option>
		<option value="SC">South Carolina</option>
		<option value="SD">South Dakota</option>
		<option value="TN">Tennessee</option>
		<option value="TX">Texas</option>
		<option value="UT">Utah</option>
		<option value="VT">Vermont</option>
		<option value="VA">Virginia</option>
		<option value="WA">Washington</option>
		<option value="WV">West Virginia</option>
		<option value="WI">Wisconsin</option>
		<option value="WY">Wyoming</option>
	</select>
 
</body>
</html>
