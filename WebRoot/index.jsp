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
	background-size: 100% 100%;
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

.spinner>div {
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

@-webkit-keyframes stretchdelay { 0%, 40%, 100% {
	-webkit-transform: scaleY(0.4)
}20%{-webkit-transform:scaleY(1.0)}}
@keyframes stretchdelay { 0%, 40%, 100% {
	transform: scaleY(0.4);
	-webkit-transform: scaleY(0.4);
}20%{transform:scaleY(1.0);  
-webkit-transform:scaleY
(1.0);}
}
</style>
		<script type="text/javascript" language="javascript"
			src="/js/jquery.js"></script>
		<script type="text/javascript" src="/js/jquery-ui.js"></script>
		<script type="text/javascript" src="/js/easy-ui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="/js/jquery.fancybox-1.3.1.pack.js"></script>
		<script type="text/javascript" src="/js/jquery.jqplot.js"></script>
		<script type="text/javascript">
$.messager.defaults = { ok: "是", cancel: "否" ,width:300};
$(document).ready(function() {
songwait = 0;
songindex = 0;
function LoadSong(){
    if ($('#tt').tabs('exists', "歌曲列表")){
		$('#tt').tabs('select', "歌曲列表");
		} else {
		$('#tt').tabs('add',{
		    title:"歌曲列表",
			closable:true,
			href:'/MusicData.jsp',
			onLoad:function(){
		    $.ajax({
			    url: "${pageContext.request.contextPath}/song/GetSongAction.action?index=0&wait=0",
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
			                    +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
			             )
		         });
		         altRows("alternatecolor");
		         songindex=$("#alternatecolor tr").length-1;
		         $("#Songspinner").attr("style","visibility:hidden");
		         $("#songCrawler").text("开始获取");
		         $("#songCrawler").removeAttr("disabled");
		   }
		});
			  
	function getData(count){
    $.ajax({
	    url: "${pageContext.request.contextPath}/song/FiveSingAction.action?index="+songindex+"&wait="+count,
	    type: "POST",
	    success: function(data) {
	         if(data=='"wait"'){
	            setTimeout(function(){}, 2000);
	            $("#songCrawler").text("继续获取");
		        $("#songCrawler").removeAttr("disabled");
		        $("#Songspinner").attr("style","visibility:visible");
	         }else if(data=='""')
	         {
	         setTimeout(function(){getData(0)}, 5000);
	         
	         }else if(data=='"over"'){
	            $("#songCrawler").text("继续获取");
		        $("#songCrawler").removeAttr("disabled");
		        $("#Songspinner").attr("style","visibility:visible");
		        alert("歌曲获取结束");
	         }else{
	             var obj = eval("("+data+")"); 
	             $.each(obj, function(index, value){
	             
	              if($("#songCrawler").text()=="等待中"){
	                  $("#songCrawler").text("暂停获取");
	                  $("#songCrawler").removeAttr("disabled");
	              }
	                 
	               $("#SongT").append(
	                 "<tr align='center' id="+value.songId+" style='cursor: pointer'><td><input class='Songselete' type='checkbox' value='"+value.songId+"'></td>"
			           +"<td class='SongChange'>"+value.songName+"</td>"
			              +"<td class='SongChange'>"+value.singer+"</td>"
			                +"<td class='SongChange'>"+value.type+"</td>"
			                  +"<td class='SongChange'>"+value.style+"</td>"
			                    +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
                      )
		         });
		         songindex=$("#alternatecolor tr").length-1;
		         altRows("alternatecolor");
				 setTimeout(function(){getData(0)}, 2000);
	         }
	    }
	});
}

$("#songCrawler").live("click", function() {
    if($("#songCrawler").text()=="开始获取"){
        $("#songCrawler").text("等待中");
        $("#songCrawler").attr("disabled","disabled");
        $("#Songspinner").attr("style","visibility:visible");
        songwait=1;
        getData(2);
    }else if($("#songCrawler").text()=="暂停获取"){
        songwait=0;
        getData(1);
        $("#songCrawler").text("暂停中");
        $("#songCrawler").attr("disabled","disabled");
        $("#Songspinner").attr("style","visibility:hidden");
    }else if($("#songCrawler").text()=="继续获取"){
        songwait=1;
        $("#Songspinner").attr("style","visibility:visible");
        getData(2);
        $("#songCrawler").text("等待中");
        $("#songCrawler").attr("disabled","disabled");
    }
});

$(".SongChange").live("click", function() {
        var id = $(this).parent().attr("id");
        id=id.substring(0,id.length-4);
        $.fancybox({
            width:600,
			height:350,
            href: "/song/FindSongAction?id="+id,
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
                window.load= altRows('alternateAddSong');
                
                $("#DeleteSongRows").live("click", function() {
				    if($("input[class='AddSongselete']:checkbox:checked").size()==0){
					        alert("未选中任意一行,请点击选择框进行选择");
					}else{
				        $.messager.confirm('是否删除', '你确定要删除吗?', function(r){
							if (r){
							    $("input[class='AddSongselete']:checkbox:checked").each(function(i){
								    $(this).parent().parent().remove();     
								});
								$(".AddSongcount").each(function(index, value){
								    $(this).text(index+1);
								});
								$("#AddSongselete").attr("checked", false);
								alert("删除成功");
							}
						});
					}
				});
				
				$("#AddSongall").live("click", function() {
				    if(this.checked){    
				        $(".AddSongselete").attr("checked", true);   
				    }else{
				        $(".AddSongselete").attr("checked", false); 
				    }  
				});
                
                 function AddSong(){
                   var styles = "";
                   $("input[textboxname='style']").attr("name","style");
                   $.each($("input[name='style']"), function(index, value){
                       if(value.getAttribute('value')==null){
                           styles+="-";
                       }else{
                           styles+=value.getAttribute('value')+",";
                       }
                   })
				    $.ajax({
		            url: "${pageContext.request.contextPath}/song/AddSongAction.action?styles="+styles,
		            type: "POST",
		            data:$('#AddSongform').serialize(),
		            async:false,
		            success: function(data) {
		            var obj = eval("("+data+")"); 
			          if(obj!=""){
				             alert(obj);
			          }else{
			            alert("添加成功!");
			            $('#tt').tabs('close','添加歌曲');
			            $('#tt').tabs('select','歌曲列表');
			            if(songwait == 0){
			                $.ajax({
							    url: "${pageContext.request.contextPath}/song/GetSongAction.action?index="+songindex+"&wait="+songwait,
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
							                    +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
							             )
						         });
						         altRows("alternatecolor");
						         songindex=$("#alternatecolor tr").length-1;
						   }
						});
			            }
			            }
	                  }
		          });
			   }
				   
                   $("#type1").combobox({
			            method: 'get',
			            url: "${pageContext.request.contextPath}/song/GetTypeAction.action",
			            panelHeight:'auto',
			            valueField: 'typeName',
			            textField: 'typeName',
			            onLoadSuccess: function () { //加载完成后,设置选中第一项
			                var val = $(this).combobox("getData");
			                for (var item in val[0]) {
			                    if (item == "typeName") {
			                        $(this).combobox("select", val[0][item]);
			                    }
			                }
			            },
			            filter: function (q, row) {
			                var ret = false;
			                //textField
			                if (row[$(this).combobox('options').textField].indexOf(q) >= 0) {
			                    ret = true;
			                }
			                return ret;
			            },
			            onSelect: function (q, row) {
			                $("#style1Td").empty();
			                $("#style1Td").append(
			                    '<input type="text" name="style" maxlength="150"/>'
			                );
			                $(this).parent().next().find("input").combobox({
					            method: 'get',
					            url: "${pageContext.request.contextPath}/song/GetStyleAction.action?type="+$(this).combobox("getValue"),
					            valueField: 'styleName',
					            textField: 'styleName',
					            multiple:true,
						      	panelHeight:'auto',
					            separator : "-",
					            required:true,
					            missingMessage:'请选择风格',
					        });
			            },
			        });
			        
			        $('#MoreAddSong').click(function(){
				        if($('#MoreAddSongform').form('validate')){
				          	AddSong();
				        }else{
				            alert("有未填写数据或格式不正确");
				        }
				    });
				    
			        $("#AddSongRows").live("click", function() {
				            AddSongindex= 0;
				            AddSongnumber = 0;
					        $.fancybox({
					            width:385,
								height:80,
					            href: "/AddSongRows.jsp",
					            onClosed:function(){
						        for(AddSongnumber;AddSongnumber>0;AddSongnumber--){
					               var song = "songName"+AddSongindex;
								   var sing = "singer"+AddSongindex;
								   var type = "type"+AddSongindex;
								   var style = "style"+AddSongindex;
								   var url = "url"+AddSongindex;
								   
								   $("#"+type).combobox({
							            method: 'get',
							            url: "${pageContext.request.contextPath}/song/GetTypeAction.action",
							            panelHeight:'auto',
							            valueField: 'typeName',
							            textField: 'typeName',
							            onLoadSuccess: function () { //加载完成后,设置选中第一项
							                var val = $(this).combobox("getData");
							                for (var item in val[0]) {
							                    if (item == "typeName") {
							                        $(this).combobox("select", val[0][item]);
							                    }
							                }
							            },
							            onSelect: function (q, row) {
							                $(this).parent().next().empty();
							                $(this).parent().next().append(
							                    '<input type="text" name="style" maxlength="150"/>'
							                );
							                $(this).parent().next().find("input").combobox({
									            method: 'get',
									            url: "${pageContext.request.contextPath}/song/GetStyleAction.action?type="+$(this).combobox("getValue"),
									            valueField: 'styleName',
									            textField: 'styleName',
									            multiple:true,
										      	panelHeight:'auto',
									            separator : "-",
									            required:true,
									            missingMessage:'请选择风格',
									        });
							            },
							        });
							        
					                   $('#'+song).validatebox({
										    required: true,
										    missingMessage:'请输入歌名'
										});
										
										$('#'+sing).validatebox({
										    required: true,
										    missingMessage:'请输入歌手'
										});
										
										$('#'+url).validatebox({
										    required: true,
										    missingMessage:'请输入链接'
										});
										
					                   AddSongindex++;
						            }
						            altRows('alternateAddSong');
						        }
					       });
						});
			        
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
	             alert("删除成功");
	        }
      }
});
}

$("#deleteSong").live("click", function() {
      if($("input[class='Songselete']:checkbox:checked").size()==0){
          alert("未选中员工数据,请点击选择框进行选择");
      }else{
        $.messager.confirm('是否删除', '你确定要删除吗?', function(r){
			if (r){
				var seleteId = "";
			    $("input[class='Songselete']:checkbox:checked").each(function(i){
				    if($(this).val()!=0){
				       var temp = $(this).val();
				       temp=temp.substring(0,temp.length-4);
				       seleteId+=temp+",";
				       $(this).parent().parent().remove();
				     }
				});
				delSong(seleteId);
			}
		});
   }
});

$("#deleteSongAll").live("click", function() {
$.messager.confirm('是否清空所有歌曲数据', '你确定要清空吗?', function(r){
			if (r){
				$.ajax({
		            url: "${pageContext.request.contextPath}/song/DeleteAllAction.action",
		            type: "POST",
		            async:false,
		            success: function(data) {
		            if(data=='"success"'){
		               songindex=1;
		               $("#SongT").empty();
		               alert("清空成功");
		            }
			      }
				});
			}
		});
});
		}
       })
	 }
}

bookwait =0;
bookindex =0;
function LoadBook(){
    if ($('#tt').tabs('exists', "小说列表")){
			$('#tt').tabs('select', "小说列表");
		} else {
			$('#tt').tabs('add',{
			    title:"小说列表",
				closable:true,
				href:'/BookData.jsp',
				onLoad:function(){
			     $.ajax({
					    url: "${pageContext.request.contextPath}/book/GetBookAction.action",
					    type: "POST",
					    success: function(data) {
				        var obj = eval("("+data+")"); 
				        $.each(obj, function(index, value){
					        $("#BookT").append(
					        "<tr align='center' id="+value.bookId+" style='cursor: pointer'><td><input class='Bookselete' type='checkbox' value='"+value.bookId+"'></td>"
					           +"<td class='BookChange'>"+value.bookName+"</td>"
					              +"<td class='BookChange'>"+value.author+"</td>"
					                +"<td class='BookChange'>"+value.introduction+"</td>"
					                  +"<td class='BookChange'>"+value.style+"</td>"
					                    +"<td class='BookChange'>"+value.monopoly+"</td>"
					                      +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
					             )
				         });
				         altRows("alternateBook");
				         bookindex=$("#alternateBook tr").length-1;
				         $("#Bookspinner").attr("style","visibility:hidden");
				         $("#bookCrawler").text("开始获取");
				         $("#bookCrawler").removeAttr("disabled");
				   }
				});
				
					function getBookData(count){
					    $.ajax({
						    url: "${pageContext.request.contextPath}/book/BookCrawlerAction.action?index="+bookindex+"&wait="+count,
						    type: "POST",
						    success: function(data) {
						         if(data=='"wait"'){
						            $("#bookCrawler").text("继续获取");
							        $("#bookCrawler").removeAttr("disabled");
							        $("#Bookspinner").attr("style","visibility:hidden");
						         }else if(data=='""')
						         {
						         setTimeout(function(){getBookData(0)}, 5000);
						         
						         }else if(data=='"over"'){
						            $("#bookCrawler").text("开始获取");
							        $("#bookCrawler").removeAttr("disabled");
							        $("#Bookspinner").attr("style","visibility:hidden");
							        alert("小说获取结束");
						         }else{
						             var obj = eval("("+data+")"); 
						             $.each(obj, function(index, value){
						             
						              if($("#bookCrawler").text()=="等待中"){
						                  $("#bookCrawler").text("暂停获取");
						                  $("#bookCrawler").removeAttr("disabled");
						              }
						                 
						               $("#BookT").append(
									        "<tr align='center' id="+value.bookId+" style='cursor: pointer'><td><input class='Bookselete' type='checkbox' value='"+value.bookId+"'></td>"
									           +"<td class='BookChange'>"+value.bookName+"</td>"
									              +"<td class='BookChange'>"+value.author+"</td>"
									                +"<td class='BookChange'>"+value.introduction+"</td>"
									                  +"<td class='BookChange'>"+value.style+"</td>"
									                    +"<td class='BookChange'>"+value.monopoly+"</td>"
									                      +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
									             )
							         });
							         bookindex=$("#alternateBook tr").length-1;
							         altRows("alternateBook");
									 setTimeout(function(){getBookData(0)}, 2000);
						         }
						    }
						});
					}
				
					$("#bookCrawler").live("click", function() {
					    if($("#bookCrawler").text()=="开始获取"){
					        $("#bookCrawler").text("等待中");
					        $("#bookCrawler").attr("disabled","disabled");
					        $("#Bookspinner").attr("style","visibility:visible");
					        bookwait=1;
					        getBookData(2);
					    }else if($("#bookCrawler").text()=="暂停获取"){
					        bookwait=0;
					        getBookData(1);
					        $("#bookCrawler").text("暂停中");
					        $("#bookCrawler").attr("disabled","disabled");
					    }else if($("#bookCrawler").text()=="继续获取"){
					        $("#Bookspinner").attr("style","visibility:visible");
					        bookwait=1;
					        getBookData(2);
					        $("#bookCrawler").text("等待中");
					        $("#bookCrawler").attr("disabled","disabled");
					    }
					});
					
					$(".BookChange").live("click", function() {
					        var id = $(this).parent().attr("id");
					        id=id.substring(0,id.length-4);
					        $.fancybox({
					            width:500,
								height:360,
					            href: "/book/FindBookAction?id="+id,
					        });
					});
					
					$("#Bookall").live("click", function() {
					    if(this.checked){    
					        $(".Bookselete").attr("checked", true);   
					    }else{
					        $(".Bookselete").attr("checked", false); 
					    }  
					});
					
					$("#addBook").live("click", function() {
				        if ($('#tt').tabs('exists', "添加小说")){
							$('#tt').tabs('select', "添加小说");
						} else {
							$('#tt').tabs('add',{
							    title:"添加小说",
								closable:true,
								href:'/AddBook.jsp',
								onLoad:function(){
				                window.load= altRows('alternateAddBook');
				                var length = ($(window).height()- $("#alternateAddBook").height())/3;
				                $("#alternateAddBook").attr("style","position: relative;top: "+length);
				                $('#tt').tabs('getTab',"添加小说").css("background-color","#d4e3e5");
				                
				                function AddBook(){
								    $.ajax({
						            url: "${pageContext.request.contextPath}/book/AddBookAction.action",
						            type: "POST",
						            data:$('#AddBookform').serialize(),
						            async:false,
						            success: function(data) {
						            var obj = eval("("+data+")"); 
							          if(obj!=""){
								             alert(obj);
							          }else{
							            alert("添加成功!");
							            $('#tt').tabs('close','添加小说');
							            $('#tt').tabs('select','小说列表');
							            if(bookwait == 0){
							            $.ajax({
										    url: "${pageContext.request.contextPath}/book/GetBookAction.action",
										    type: "POST",
										    success: function(data) {
									        var obj = eval("("+data+")"); 
									        $.each(obj, function(index, value){
										        $("#BookT").append(
										        "<tr align='center' id="+value.bookId+" style='cursor: pointer'><td><input class='Bookselete' type='checkbox' value='"+value.bookId+"'></td>"
										           +"<td class='BookChange'>"+value.bookName+"</td>"
										              +"<td class='BookChange'>"+value.author+"</td>"
										                +"<td class='BookChange'>"+value.introduction+"</td>"
										                  +"<td class='BookChange'>"+value.style+"</td>"
										                    +"<td class='BookChange'>"+value.monopoly+"</td>"
										                      +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
										             )
									         });
									         altRows("alternateBook");
									         bookindex=$("#alternateBook tr").length-1;
									   }
									});
							            }
							            }
					                  }
						          });
							   }
							        
							        $('#MoreAddBook').click(function(){
								        if($('#MoreAddBookform').form('validate')){
								          	AddBook();
								        }else{
								            alert("有未填写数据或格式不正确");
								        }
								    });
							    }
				            })
				        }
				});
				
				function delBook(id){
				      $.ajax({
				            url: "${pageContext.request.contextPath}/book/DeleteBookAction.action?id="+id,
				            type: "POST",
				            async:false,
				            success: function(data) {
				            if(data!=""){
						         alert(data);
					        }else{
					             alert("删除成功");
					        }
				      }
				});
				}
				
				$("#deleteBook").live("click", function() {
				      if($("input[class='Bookselete']:checkbox:checked").size()==0){
				          alert("未选中员工数据,请点击选择框进行选择");
				      }else{
				        $.messager.confirm('是否删除', '你确定要删除吗?', function(r){
							if (r){
								var seleteId = "";
							    $("input[class='Bookselete']:checkbox:checked").each(function(i){
								    if($(this).val()!=0){
								       var temp = $(this).val();
								       temp=temp.substring(0,temp.length-4);
								       seleteId+=temp+",";
								       $(this).parent().parent().remove();
								     }
								});
								delBook(seleteId);
							}
						});
				   }
				});
				
				$("#deleteBookAll").live("click", function() {
				$.messager.confirm('是否清空所有小说数据', '你确定要清空吗?', function(r){
							if (r){
								$.ajax({
						            url: "${pageContext.request.contextPath}/book/DeleteBookAllAction.action",
						            type: "POST",
						            async:false,
						            success: function(data) {
						            if(data=='"success"'){
						               bookindex=1;
						               $("#BookT").empty();
						               alert("清空成功");
						            }
							      }
								});
							}
						});
				});
				
				}
		     })
		 }
}

csdnwait =0;
csdnindex =0;
function LoadCsdn(){
    if ($('#tt').tabs('exists', "CSDN")){
			$('#tt').tabs('select', "CSDN");
		} else {
			$('#tt').tabs('add',{
			    title:"CSDN",
				closable:true,
				href:'/CsdnData.jsp',
				onLoad:function(){
			     $.ajax({
					    url: "${pageContext.request.contextPath}/csdn/GetCsdnAction.action",
					    type: "POST",
					    success: function(data) {
				        var obj = eval("("+data+")"); 
				        $.each(obj, function(index, value){
					        $("#CsdnT").append(
					        "<tr align='center' id="+value.csdnId+" style='cursor: pointer'><td><input class='Csdnselete' type='checkbox' value='"+value.csdnId+"'></td>"
					           +"<td class='CsdnChange'>"+value.title+"</td>"
					              +"<td class='CsdnChange'>"+value.author+"</td>"
					                +"<td class='CsdnChange'>"+value.style+"</td>"
					                  +"<td class='CsdnChange'>"+value.count+"</td>"
					                    +"<td class='CsdnChange'>"+value.introduction+"</td>"
					                      +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
					             )
				         });
				         altRows("alternateCsdn");
				         csdnindex=$("#alternateCsdn tr").length-1;
				         $("#Csdnspinner").attr("style","visibility:hidden");
				         $("#csdnCrawler").text("开始获取");
				         $("#csdnCrawler").removeAttr("disabled");
				   }
				});
				
					function getCsdnData(count){
					    $.ajax({
						    url: "${pageContext.request.contextPath}/csdn/CsdnAction.action?index="+csdnindex+"&wait="+count,
						    type: "POST",
						    success: function(data) {
						         if(data=='"wait"'){
						            $("#csdnCrawler").text("继续获取");
							        $("#csdnCrawler").removeAttr("disabled");
							        $("#Csdnspinner").attr("style","visibility:hidden");
						         }else if(data=='""'){
						             setTimeout(function(){getCsdnData(0)}, 5000);
						         }else if(data=='"over"'){
						            $("#csdnCrawler").text("开始获取");
							        $("#csdnCrawler").removeAttr("disabled");
							        $("#Csdnspinner").attr("style","visibility:hidden");
							        alert("Csdn获取结束");
						         }else{
						             var obj = eval("("+data+")"); 
						             $.each(obj, function(index, value){
						             
						              if($("#csdnCrawler").text()=="等待中"){
						                  $("#csdnCrawler").text("暂停获取");
						                  $("#csdnCrawler").removeAttr("disabled");
						              }
						                 
						               $("#CsdnT").append(
									        "<tr align='center' id="+value.csdnId+" style='cursor: pointer'><td><input class='Csdnselete' type='checkbox' value='"+value.csdnId+"'></td>"
									           +"<td class='CsdnChange'>"+value.title+"</td>"
									              +"<td class='CsdnChange'>"+value.author+"</td>"
									                +"<td class='CsdnChange'>"+value.style+"</td>"
									                  +"<td class='CsdnChange'>"+value.count+"</td>"
									                    +"<td class='CsdnChange'>"+value.introduction+"</td>"
									                      +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
									             )
							         });
							         csdnindex=$("#alternateCsdn tr").length-1;
							         altRows("alternateCsdn");
									 setTimeout(function(){getCsdnData(0)}, 2000);
						         }
						    }
						});
					}
				
					$("#csdnCrawler").live("click", function() {
					    if($("#csdnCrawler").text()=="开始获取"){
					        $("#csdnCrawler").text("等待中");
					        $("#csdnCrawler").attr("disabled","disabled");
					        $("#Csdnspinner").attr("style","visibility:visible");
					        csdnwait=1;
					        getCsdnData(2);
					    }else if($("#csdnCrawler").text()=="暂停获取"){
					        csdnwait=0;
					        getCsdnData(1);
					        $("#csdnCrawler").text("暂停中");
					        $("#csdnCrawler").attr("disabled","disabled");
					    }else if($("#csdnCrawler").text()=="继续获取"){
					        $("#Csdnspinner").attr("style","visibility:visible");
					        csdnwait=1;
					        getCsdnData(2);
					        $("#csdnCrawler").text("等待中");
					        $("#csdnCrawler").attr("disabled","disabled");
					    }
					});
					
					$(".CsdnChange").live("click", function() {
					        var id = $(this).parent().attr("id");
				            id=id.substring(0,id.length-4);
					        $.fancybox({
					            width:700,
								height:250,
					            href: "/csdn/FindCsdnAction?id="+id,
					        });
					});
					
					$("#Csdnall").live("click", function() {
					    if(this.checked){    
					        $(".Csdnselete").attr("checked", true);   
					    }else{
					        $(".Csdnselete").attr("checked", false); 
					    }  
					});
					
					$("#addCsdn").live("click", function() {
				        if ($('#tt').tabs('exists', "添加帖子")){
							$('#tt').tabs('select', "添加帖子");
						} else {
							$('#tt').tabs('add',{
							    title:"添加帖子",
								closable:true,
								href:'/AddCsdn.jsp',
								onLoad:function(){
				                window.load= altRows('alternateAddCsdn');
				                
				                $("#DeleteCsdnRows").live("click", function() {
								    if($("input[class='AddCsdnselete']:checkbox:checked").size()==0){
									        alert("未选中任意一行,请点击选择框进行选择");
									}else{
								        $.messager.confirm('是否删除', '你确定要删除吗?', function(r){
											if (r){
											    $("input[class='AddSCsdnselete']:checkbox:checked").each(function(i){
												    $(this).parent().parent().remove();     
												});
												$(".AddCsdncount").each(function(index, value){
												    $(this).text(index+1);
												});
												$("#AddCsdnselete").attr("checked", false);
												alert("删除成功");
											}
										});
									}
								});
								
								$("#AddCsdnall").live("click", function() {
								    if(this.checked){    
								        $(".AddCsdnselete").attr("checked", true);   
								    }else{
								        $(".AddCsdnselete").attr("checked", false); 
								    }  
								});
				                
				                 $('#MoreAddCsdn').click(function(){
						            if($('#MoreAddCsdnform').form('validate')){
							          	AddCsdn();
							        }else{
							            alert("有未填写数据或格式不正确");
							        }
							    });
				                
				                $("#style1").combobox({
						            method: 'get',
						            url: "${pageContext.request.contextPath}/csdn/GetCsdnStyleAction.action",
						            valueField: 'styleName',
						            textField: 'styleName',
						            onLoadSuccess: function () { //加载完成后,设置选中第一项
						                var val = $(this).combobox("getData");
						                for (var item in val[0]) {
						                    if (item == "styleName") {
						                        $(this).combobox("select", val[0][item]);
						                    }
						                }
						            },
						        });
				                
				                function AddCsdn(){
								    $.ajax({
						            url: "${pageContext.request.contextPath}/csdn/AddCsdnAction.action",
						            type: "POST",
						            data:$('#MoreAddCsdnform').serialize(),
						            async:false,
						            success: function(data) {
						            var obj = eval("("+data+")"); 
							          if(obj!=""){
								             alert(obj);
							          }else{
							            alert("添加成功!");
							            $('#tt').tabs('close','添加帖子');
							            $('#tt').tabs('select','CSDN');
							            if(csdnwait == 0){
							            $.ajax({
										    url: "${pageContext.request.contextPath}/csdn/GetCsdnAction.action",
										    type: "POST",
										    success: function(data) {
									        var obj = eval("("+data+")"); 
									        $.each(obj, function(index, value){
										        $("#CsdnT").append(
										        "<tr align='center' id="+value.csdnId+" style='cursor: pointer'><td><input class='Csdnselete' type='checkbox' value='"+value.csdnId+"'></td>"
										           +"<td class='CsdnChange'>"+value.title+"</td>"
										              +"<td class='CsdnChange'>"+value.author+"</td>"
										                +"<td class='CsdnChange'>"+value.style+"</td>"
										                  +"<td class='CsdnChange'>"+value.count+"</td>"
										                    +"<td class='CsdnChange'>"+value.introduction+"</td>"
										                      +"<td><a href="+value.url+" target='blank'>"+value.url+"</a></td></tr>"
										             )
									         });
									         altRows("alternateCsdn");
									         csdnindex=$("#alternateCsdn tr").length-1;
									   }
									});
							            }
							            }
					                  }
						          });
							   }
							        
							        $("#AddCsdnRows").live("click", function() {
								            AddCsdnindex= 0;
								            AddCsdnnumber = 0;
									        $.fancybox({
									            width:385,
												height:80,
									            href: "/AddCsdnRows.jsp",
									            onClosed:function(){
										        for(AddCsdnnumber;AddCsdnnumber>0;AddCsdnnumber--){
									               var title = "title"+AddCsdnindex;
												   var author = "csdnauthor"+AddCsdnindex;
												   var style = "csdnstyle"+AddCsdnindex;
												   var count = "csdncount"+AddCsdnindex;
												   var introduction = "csdnintroduction"+AddCsdnindex;
												   var url = "csdnurl"+AddCsdnindex;
												   
												   $("#"+style).combobox({
											            method: 'get',
											            url: "${pageContext.request.contextPath}/csdn/GetCsdnStyleAction.action",
											            valueField: 'styleName',
											            textField: 'styleName',
											            onLoadSuccess: function () { //加载完成后,设置选中第一项
											                var val = $(this).combobox("getData");
											                for (var item in val[0]) {
											                    if (item == "styleName") {
											                        $(this).combobox("select", val[0][item]);
											                    }
											                }
											            },
											        });
												   
									                   $('#'+title).validatebox({
														    required: true,
														    missingMessage:'请输入标题'
														});
														
														$('#'+author).validatebox({
														    required: true,
														    missingMessage:'请输入作者'
														});
														
														$('#'+count).validatebox({
														    required: true,
														    missingMessage:'请输入阅览数'
														});
														
														$('#'+introduction).validatebox({
														    required: true,
														    missingMessage:'请输入简介'
														});
														
														$('#'+url).validatebox({
														    required: true,
														    missingMessage:'请输入链接'
														});
														
									                   AddCsdnindex++;
										            }
										            altRows('alternateAddCsdn');
										        }
									       });
										});
							    }
				            })
				        }
				});
				
				function delCsdn(id){
				      $.ajax({
				            url: "${pageContext.request.contextPath}/csdn/DeleteCsdnAction.action?id="+id,
				            type: "POST",
				            async:false,
				            success: function(data) {
				            if(data!=""){
						         alert(data);
					        }else{
					             alert("删除成功");
					        }
				      }
				});
				}
				
				$("#deleteCsdn").live("click", function() {
				      if($("input[class='Csdnselete']:checkbox:checked").size()==0){
				          alert("未选中帖子数据,请点击选择框进行选择");
				      }else{
				        $.messager.confirm('是否删除', '你确定要删除吗?', function(r){
							if (r){
								var seleteId = "";
							    $("input[class='Csdnselete']:checkbox:checked").each(function(i){
								    if($(this).val()!=0){
								       var temp = $(this).val();
								       temp=temp.substring(0,temp.length-4);
								       seleteId+=temp+",";
								       $(this).parent().parent().remove();
								     }
								});
								delCsdn(seleteId);
							}
						});
				   }
				});
				
				$("#deleteCsdnAll").live("click", function() {
				$.messager.confirm('是否清空所有帖子数据', '你确定要清空吗?', function(r){
							if (r){
								$.ajax({
						            url: "${pageContext.request.contextPath}/csdn/DeleteCsdnAllAction.action",
						            type: "POST",
						            async:false,
						            success: function(data) {
						            if(data=='"success"'){
						               csdnindex=1;
						               $("#CsdnT").empty();
						               alert("清空成功");
						            }
							      }
								});
							}
						});
				});
				
				}
		     })
		 }
}

function Serch(){
    if ($('#tt').tabs('exists', "搜索")){
			$('#tt').tabs('select', "搜索");
		} else {
			$('#tt').tabs('add',{
			    title:"搜索",
				closable:true,
				href:'/Serch.jsp',
				onLoad:function(){
				    $("#ss").live("click", function() {
					    $.ajax({
				            url: "${pageContext.request.contextPath}/crawler/SerchAction.action",
				            type: "POST",
				            data:$('#SerchF').serialize(),
				            async:false,
				            success: function(data) {
				            var obj = eval("("+data+")"); 
				                $('#tt').tabs('close', "搜索");
				                $('#tt').tabs('add',{
							    title:"搜索",
								closable:true,
								href:'/SerchData.jsp',
								onLoad:function(){
								    $.each(obj, function(index, value){
								      $("#SerchT").append(
								        "<tr align='center' id="+value[0]+" style='cursor: pointer'><td><input class='Serchselete' type='checkbox' value='"+value[0]+"'></td>"
								          +"<td class='SerchChange'>"+value[1]+"</td>"
								            +"<td class='SerchChange'>"+value[2]+"</td>"
								              +"<td class='SerchChange'>"+value[3]+"</td>"
								                +"<td><a href="+value[4]+" target='blank'>"+value[4]+"</a></td></tr>"
								         )
							         });
							         $(".spinner").attr("style","visibility:hidden");
							         altRows("alternateSerch");
							         
							         $(".SerchChange").live("click", function() {
									        var id = $(this).parent().attr("id");
									        $.fancybox({
									            width:500,
												height:360,
									            href: "/crawler/FindCrawlerAction?id="+id,
									        });
									});
									
									$("#Serchall").live("click", function() {
									    if(this.checked){    
									        $(".Serchselete").attr("checked", true);   
									    }else{
									        $(".Serchselete").attr("checked", false); 
									    }  
									});
									
									function delSerch(id){
									      $.ajax({
									            url: "${pageContext.request.contextPath}/crawler/DeleteSerchAction.action?id="+id,
									            type: "POST",
									            async:false,
									            success: function(data) {
									            if(data!=""){
											         alert(data);
										        }else{
										             alert("删除成功");
										        }
									      }
									});
									}
									
									$("#deleteSerch").live("click", function() {
									      if($("input[class='Serchselete']:checkbox:checked").size()==0){
									          alert("未选中数据,请点击选择框进行选择");
									      }else{
									        $.messager.confirm('是否删除', '你确定要删除吗?', function(r){
												if (r){
													var seleteId = "";
												    $("input[class='Serchselete']:checkbox:checked").each(function(i){
													    if($(this).val()!=0){
													       var temp = $(this).val();
													       seleteId+=temp+",";
													       temp=temp.substring(0,temp.length-1);
													       $(this).parent().parent().remove();
													       $("#"+temp).remove();
													     }
													});
													delSerch(seleteId);
												}
											});
									   }
									});
									
							         }
								});
							}
				      });
				});
				}
			});
	     }
	 }
	 

$("#SerchO").live("click", function() {
    $('#tt').tabs('close', "搜索");
    Serch();
});

$('#Mana').accordion({
    onSelect:function(title, index)
    {
        if(index=="0"){
			    LoadSong();
        }
        if(index=="1"){
	          LoadBook();
		 }
		 if(index=="2"){
	          LoadCsdn();
		 }
		 if(index=="3"){
	          Serch();
		 }
    }
});

$(window).unload(function(){
    $.ajax({
	    url: "${pageContext.request.contextPath}/crawler/StopAllAction.action",
	    type: "POST",
    });
});

//页面刷新时调用
$(window).on('beforeunload', function(event) {
    $.ajax({
	    url: "${pageContext.request.contextPath}/crawler/StopAllAction.action",
	    type: "POST",
    });
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
    window.load= LoadSong();
});
  	</script>
		<body class="easyui-layout" style="width: 100%; height: 100%">
			<div id="west" data-options="region:'west'" title='导航栏'
				style="width: 200px;">
				<div class="easyui-accordion" id="Mana"
					data-options="fit:true,border:false">
					<div title="歌曲" id="SongMana">
						<ul style="padding: 0">
							<li>
								<button style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-primary"
									id="songCrawler" disabled="disabled">
									加载已获取数据中
								</button>
							</li>
							<li>
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-primary"
									id="addSong">添加歌曲</a>
							</li>
							<li style="margin-top: 2px;">
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-caution"
									id="deleteSong">删除歌曲</a>
							</li>
							<li style="margin-top: 2px;">
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-caution"
									id="deleteSongAll">歌曲清空</a>
							</li>
						</ul>
					</div>
					<div title="小说">
						<ul style="padding: 0">
							<li>
								<button style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-primary"
									id="bookCrawler" disabled="disabled">
									加载已获取数据中
								</button>
							</li>
							<li>
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-primary"
									id="addBook">添加小说</a>
							</li>
							<li style="margin-top: 2px;">
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-caution"
									id="deleteBook">删除小说</a>
							</li>
							<li style="margin-top: 2px;">
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-caution"
									id="deleteBookAll">小说清空</a>
							</li>
						</ul>
					</div>
					<div title="Csdn">
						<ul style="padding: 0">
							<li>
								<button style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-primary"
									id="csdnCrawler" disabled="disabled">
									加载已获取数据中
								</button>
							</li>
							<li>
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-primary"
									id="addCsdn">添加帖子</a>
							</li>
							<li style="margin-top: 2px;">
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-caution"
									id="deleteCsdn">删除帖子</a>
							</li>
							<li style="margin-top: 2px;">
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-caution"
									id="deleteCsdnAll">帖子清空</a>
							</li>
						</ul>
					</div>
					<div title="搜索">
						<ul style="padding: 0">
							<li>
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-primary"
									id="SerchO">重新搜索</a>
							</li>
							<li style="margin-top: 2px;">
								<a style="width: 100%"
									class="button button-small button-glow button-border button-rounded button-caution"
									id="deleteSerch">删除选中数据</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div id="center" data-options="region:'center'"
				style="overflow: hidden;">
				<div id="tt" class="easyui-tabs" style="width: 100%; height: 100%;">
				</div>
			</div>
		</body>
</html>
