<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>表格-工具栏</title>
<link href="lib/css/default/easyui.css" type="text/css" rel="stylesheet">
<link href="lib/css/icon.css" type="text/css" rel="stylesheet">

<script src="lib/js/jquery.min.js"></script>
<script src="lib/js/jquery.easyui.min.js"></script>
<script src="lib/js/easyui-lang-zh_CN.js"></script>
</head>

<body>
	<!-- 工具栏 -->
	<div id="tb">
		<div style="margin-bottom: 5px">
			<a class="easyui-linkbutton" iconCls="icon-add" plain="true">成绩列表</a>

		</div>
		<div>
			<input class="easyui-textbox" id="qContentSearch"> 
			<select id="province" name="province" class="cascade_drop_down">
				<option value="score" >考试分数</option>
				<option value="name"  selected="selected">考试名称</option>
         
			</select> <a href="javascript:searchStuScore()" class="easyui-linkbutton"
				iconCls="icon-search">查询</a>


		</div>

	</div>
	<table id="myTable" toolbar="#tb"></table>




</body>
<script>
//根据条件查找学生成绩
	function searchStuScore() {
	
		var options=$("#province option:selected"); 
		if(options.text()=="考试名称") {
		$('#myTable').datagrid("load", {
			examName : $("#qContentSearch").val()
		})
	} else  if(options.text()=="考试分数"){
		$('#myTable').datagrid("load", {
			examScore : $("#qContentSearch").val()
		})
		
	}

	}

	$(function() {

		//加载数据
		loadScore();
	})
	function loadScore() {
		//表格的配置信息
		$('#myTable').datagrid({
			title : '成绩列表', //表格名称
			iconCls : 'icon-save', //图标
			height : 'auto', //表格高度，可指定高度，可自动
			border : true, //表格是否显示边框
			url : 'searchStuScore.do', //获取表格数据时请求的地址
			method : 'post', //表格数据获取方式,请求地址是上面定义的url
			fitColumns : true, //True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动。
			columns : [ [ {
				field : 'stuId',
				title : '学生id',
				width : 15,

				hidden : false
			}, {
				field : 'examName',
				title : '考试名',
				width : 80

			}, {
				field : 'examTime',
				title : '考试时间',
				width : 40

			}, {
				field : 'examScore',
				title : '分数',
				sortable : true, //排序字段
				width : 10

			},
			{
				field: 'examStatu',
				title: '是否考试',
				width: 10,
				 formatter:function(val,row,index){
					
						if (val==1)
						{
							return  "已考"
							}
						else {
							return "未考"
						}
						
						
						
			} 

			}

			] ],
			pagination : true, //如果表格需要支持分页，必须设置该选项为true
			pageSize : 50, //表格中每页显示的行数
			pageList : [ 50, 100, 150 ],

			striped : true, //奇偶行是否使用不同的颜色
			remoteSort : false, //是否从服务器排序数
			sortName : 'examTime', //按照ID列的值排序
			sortOrder : 'desc', //使用倒序排序 */
			idField : 'scoId',
			loadMsg : '数据正在努力加载，请稍后...', //加载数据时显示提示信息
			frozenColumns : [ [ //固定在表格左侧的复选框
			{
				field : 'ck',
				checkbox : false
			}, ] ]

		})

	}
</script>
</html>