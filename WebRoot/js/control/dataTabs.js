	thisp = "";
	page = "";
			function addEmp(title){
			if ($('#tt').tabs('exists', title)){
				$('#tt').tabs('select', title);
			} else {
				$('#tt').tabs('add',{
					title:title,
					closable:true,
					href:'/JSP/Emp/EmpAllInfo.jsp',
					onLoad:function(){
					      var load = function load(a){
					      $.ajax({
					            url: "${pageContext.request.contextPath}/emp/EmpAllInfoAction.action?thispage="+a,
					            dataType: "JSON",
					            type: "POST",
					            async:false,
					            success: function(data) {
					                var obj = eval("("+data+")"); 
					                $("#table tr:not(:first)").remove();
					                thisp = obj.thispage;
					                page = obj.countrow;
					                
					               $.each(obj.list, function(index, value){
					                 $("#table").append(
					                   "<tr align='center'><td><input class='selete' type='checkbox' value='"+value.emp_id+"'>"+"</td><td>"+value.emp_id+"</td><td>"+value.emp_name+"</td>" +
									        "<td>"+value.emp_gender+"</td>"+
									           "<td>"+value.emp_birth+"</td>"+
									           "<td>"+value.isteach+"</td>"+
									           "<td>"+value.issci+"</td>"+
									           "<td>"+value.dept_id+"</td>"+
									           "<td>"+value.zc_id+"</td>"+
									           "<td>"+value.zw_id+"</td><td><a class='fancybox' href='/emp/FindEmpDecAction?id="+value.emp_id+"'>"+
									          	    "查看简历"+"</a></td><td><a class='fancybox' href='/emp/FindEmpAction?id="+value.emp_id+"'>"+
									          	    "修改"+"</a></td></tr>"
					                 );
					               });
					                 prepage();
					            }
					        });
					        }
					        
					              
					      var  prepage = function prepage(){
					           $("#ppEmp").pagination({
										total:page,
										pageNumber:thisp,
										pageSize:5,
										pageList:[5,10],
										layout:['list','sep','first','prev','links','next','last','sep'],
										loading:false,
										showPageList:true,
										showRefresh:true,
										displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
										buttons: [{
											iconCls:'icon-add',
											handler:function(){
											    $("#add").fancybox().trigger('click');
											}
										},{
											iconCls:'icon-cancel',
											handler:function(){
											    $("input:checkbox:checked").each(function(i){  
												    if($(this).val()!=0){
												       del($(this).val());
												     }
												}); 
												load(thisp);
												$('#ppEmp').pagination('select');
											}
										}],
										onSelectPage:function(pageNumber, pageSize){
										    load(pageNumber);
										},
									});
					      }
					        
					function del(id){
					      $.ajax({
					            url: "${pageContext.request.contextPath}/emp/DeleteEmpAction.action?id="+id,
					            dataType: "JSON", 
					            type: "POST",
					            async:false,
					            success: function() {
					               
					            }
					});
					}        
					        
					        //第一次启动时载入
					        window.load= load(1);
					        
					$("#del").live("click", function() {
					        var id =  $(this).attr("name");
					        del(id);
					});
		
					$("#all").click(function(){
					    if(this.checked){    
					        $(".selete").attr("checked", true);   
					    }else{
					        $(".selete").attr("checked", false); 
					    }  
					});  
		
					$(".fancybox").fancybox({});
										           
				      }   
			});
			}
		}