<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
		<meta charset="UTF-8">
		<title>表格-工具栏</title>
		<link href="<%=request.getContextPath() %>/lib/css/default/easyui.css" type="text/css" rel="stylesheet">
		<link href="<%=request.getContextPath() %>/lib/css/icon.css" type="text/css" rel="stylesheet">
				<script src="<%=request.getContextPath() %>/lib/js/jquery.js"></script>
		<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js">	</script>	
		<script src="<%=request.getContextPath() %>/lib/js/jquery.min.js"></script>
		<script src="<%=request.getContextPath() %>/lib/js/jquery.easyui.min.js"></script>
		<script src="<%=request.getContextPath() %>/lib/js/easyui-lang-zh_CN.js"></script>
	</head>

	<body>
	<!-- 工具栏 -->
	<div id="tb">
		<div style="margin-bottom:5px">
				<a href="javascript:addExam()" class="easyui-linkbutton" iconCls="icon-add" plain="true">分配考试</a>
				<a href="javascript:updateWin()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
				<a href="javascript:delBat()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">删除</a>
		</div>
		<div>
			试卷名：<input class="easyui-textbox" id="qContentSearch">
			<a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search">查询</a>
		</div>

	</div>
	<table id="myTable"  toolbar="#tb"></table>
	
	
	<!-- 点击分配考试时弹窗 -->
	<div id="qWin" title="新增" class="easyui-window" style="width:500px;height:300px;padding:30px 30px;">
	<form id="myForm" method="post">
	
		<div style="margin-bottom:20px">
			<span>考试名称:</span>
			<input class="easyui-textbox" id="examName" name="examName" style="width:80%;height:32px" readOnly="true" >
			<span style="color:red">*</span>
		</div>
				<div style="margin-bottom:20px">
			<span>试卷id:</span>
			<input class="easyui-textbox" id="paperId" name="paperName" style="width:80%;height:32px" readOnly="true">
			<span style="color:red">*</span>
		</div>
	  	<div style="margin-bottom:20px">
			<span>考试总分:</span>
			<input class="easyui-textbox" id="examscore" name="examscore"style="width:80%;height:32px" readOnly="true">
			<span style="color:red">*</span>
		</div>
		
	
	 
	   <div style="margin-bottom:20px">
			<span>考试时间:</span>
			<input class="easyui-textbox" id="time" name="Time"style="width:80%;height:32px" readOnly="true"  >
			<span style="color:red">*</span>
		</div> 
       
		  <div style="margin-bottom:20px">
			<span>截至时间:</span>
			<input class="easyui-datebox" id="examTime" name="examTime"style="width:80%;height:32px"  >
			<span style="color:red">*</span>
		</div> 
		<div style="margin-bottom:20px">
			<a href="javascript:save()" class="easyui-linkbutton" iconCls="icon-search" style="width:80%;height:32px">保存</a>
		</div>
		
		</form>	
	
	</div>
	<!-- 点击修改时弹窗 -->
	<div id="qWins" title="修改" class="easyui-window" style="width:500px;height:300px;padding:30px 30px;">
	<form id="myForm" method="post">
	
		<div style="margin-bottom:20px">
			<span>考试名称:</span>
			<input class="easyui-textbox" id="examName2" name="examName" style="width:80%;height:32px"  readOnly="true">
			<span style="color:red">*</span>
		</div>
		<div style="margin-bottom:20px">
			<span>试卷id:</span>
			<input class="easyui-textbox" id="paperId2" name="paperName" style="width:80%;height:32px" readOnly="true">
			<span style="color:red">*</span>
		</div>
		
		  <div style="margin-bottom:20px">
			<span>截至时间:</span>
			<input class="easyui-datebox" id="examTime2" name="examTime"style="width:80%;height:32px"  >
			<span style="color:red">*</span>
		</div> 
		<div style="margin-bottom:20px">
			<a href="javascript:updateExam()" class="easyui-linkbutton" iconCls="icon-search" style="width:80%;height:32px">保存</a>
		</div>
		
		</form>	
	
	</div>
	</body>
	<script>
	//添加考试
	function addExam(){
		//打开弹窗
		var row =$('#myTable').datagrid("getSelected");
		var paperId=row.paperId;
		var paperName=row.paperName;
		var allscore=row.allscore;
		var time=row.paperTime;
	
    	$("#examscore").val(allscore);
		$("#examscore").textbox("setText",allscore);
		$("#time").val(time);
		$("#time").textbox("setText",time);
		$("#examName").val(paperName);
		$("#examName").textbox("setText",paperName);
		$("#paperId").val(paperId);
		$("#paperId").textbox("setText",paperId);
	
		$("#qWin").window("open");
		
	}
	//删除考试

	function delBat(){
		var row = $('#myTable').datagrid("getSelected");
		var paperId=row.paperId;
		 $.ajax({
			 type: "post",
			 url: "delBat.do",
			   data: {"paperId":paperId},
			   success: function(msg){
				   if(msg=="success"){
					  alert("更新成功");
					 
				   }else{
					   alert("更新失败");
				   }
			   }
			 });
		

	}
	//打开修改窗口
	function updateWin(){
		//将选中信息加载到窗口中
		var row =$('#myTable').datagrid("getSelected");
		var paperId=row.paperId;
		var paperName=row.paperName;
		var allscore=row.allscore;
		var time=row.paperTime;
	
		$("#examName2").val(paperName);
		$("#examName2").textbox("setText",paperName);
    	$("#examScore2").val(allscore);
		$("#examScore2").textbox("setText",allscore);
		$("#paperId2").val(paperId);
		$("#paperId2").textbox("setText",paperId);
	
		$("#qWins").window("open");
		
		
	}
	//修改考试
	function updateExam() {
		 $.ajax({
			 type: "post",
			 url: "updateExam.do",
			   data: {"examTime":$("#examTime2").val(),"paperId":$("#paperId2").val()},
			   success: function(msg){
				   if(msg=="success"){
					  alert("更新成功");
					  loadExam();
				   }else{
					   alert("更新失败");
				   }
			   }
			 });
	}
	//保存考试

	function save(){
		
		 if($("#examTime").val()==null || $("#examTime").val()=="") {
	        	alert("未填写截至时间")
	        }else {
			 $.ajax({
				 type: "post",
				 url: "<%=request.getContextPath()%>/saveExam1.do",
				   data: {"examStatu":"0","examName":$("#examName").val(),"examTime":$("#examTime").val(),"paperId":$("#paperId").val()},
				   success: function(msg){
					   if(msg=="success"){
						  alert("更新成功");
					   }else{
						   alert("更新失败");
					   }
				   }
				 });
	        }
	}

	//根据试卷名查询
	function search(){
		$('#myTable').datagrid("load",{paperName:$("#qContentSearch").val()})
	}
	
	$(function(){
		//关闭窗口
		$("#qWin").window("close");
		$("#qWins").window("close");
		//加载数据
		loadPaper();
	})
	//改变时间格式
	function formatterdate(val, row) {
		if (val != null) {
		var date = new Date(val);
		return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
		+ date.getDate();
		}
		}
	function loadPaper() {
		//表格的配置信息
		$('#myTable').datagrid({
			title: '试卷', //表格名称
			iconCls: 'icon-save', //图标
			height: 'auto', //表格高度，可指定高度，可自动
			border: true, //表格是否显示边框
			url: 'searchPaper.do', //获取表格数据时请求的地址
			method: 'post', //表格数据获取方式,请求地址是上面定义的url
			fitColumns: true, //True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动。
			columns: [
				[{
					field: 'paperId',
					title: '试卷id',
					width: 10,
					//排序字段
					hidden: false
				},
				{
					field: 'paperName',
					title: '试卷名称',
					width: 50

				},
				{
					field: 'allscore',
					title: '考试总分',
					width: 50
			
					
					

				},
				{
					field: 'paperTime',
					title: '考试时间',
					
					width: 10
			

				},
				{
					field: 'createTime',
					title: '创建时间',
					width: 10,
					sortable: true,
					formatter : formatterdate
					// formatter:function(val,row,index){
					//		console.log(val)
						//	console.log(row)
					//		console.log(index)
					//		return row.paperName;
				//} 

				}

			]
			],
			pagination: true, //如果表格需要支持分页，必须设置该选项为true
			pageSize: 5, //表格中每页显示的行数
			pageList: [5, 15, 20],

			striped: true, //奇偶行是否使用不同的颜色
			remoteSort: false, //是否从服务器排序数
			sortName: 'createTime', //按照ID列的值排序
			sortOrder: 'dsec', //使用倒序排序 */
			idField: 'id',
			loadMsg: '数据正在努力加载，请稍后...', //加载数据时显示提示信息
		    singleSelect: true, //只能选中一条
			frozenColumns: [
				[ //固定在表格左侧的复选框
					{
						field: 'ck',
						checkbox: true
					},
				]
			]

		})

	}
	
	</script>
</html>