<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
		<link href="<%=request.getContextPath() %>/lib/css/default/easyui.css" type="text/css" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/lib/css/icon.css" type="text/css" rel="stylesheet">
		
		<script src="<%=request.getContextPath() %>/lib/js/jquery.min.js"></script>
		<script src="<%=request.getContextPath() %>/lib/js/jquery.easyui.min.js"></script>
		<script src="<%=request.getContextPath() %>/lib/js/easyui-lang-zh_CN.js"></script>
	</head>
<body>
<div id="tb">
		权限名：<input class="easyui-textbox" id="clazzid" ><br/>
		父节点：<select name="exam" id="exam" class="easyui-combobox" panelHeight="auto">
					<option value="1">管理员维护</option>
					<option value="5">试题管理</option>
					<option value="11">考生管理</option>
				  </select><br/>
		权限级别：<input class="easyui-textbox" id="level"><br/>
		<a href="javascript:add()" class="easyui-linkbutton">添加</a>
	</div>
	<table id="myTable" toolbar="#tb"></table>
</body>
<script type="text/javascript">

	$(function(){
	    $("input",$("#level").next("span")).click(function(){
	    	$.ajax({
				url:"sss.do",
				success:function(msg){
					$("#level").textbox('setValue',msg+1);
				}
			});
	    });
	})
	function add(){
		$.ajax({
			url:"adds.do",
			data:{"p_name":$("#clazzid").val(),"p_method":$("#username").val(),"level_p":$("#exam").val(),"level":$("#level").val()},
			success:function(msg){
				if(msg=="success"){
					$.messager.alert("信息提示", "添加成功", "info");
					location.reload();
				}else{
					$.messager.alert("信息提示", "添加失败", "info");
				}
			}
		});
	}
</script>
</html>