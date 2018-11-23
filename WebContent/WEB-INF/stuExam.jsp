<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>表格-工具栏</title>
<link href="<%=request.getContextPath()%>/lib/css/default/easyui.css"
	type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/lib/css/icon.css"
	type="text/css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/lib/js/jquery.js"></script>
<script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js">
	
</script>
<script src="<%=request.getContextPath()%>/lib/js/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/lib/js/jquery.easyui.min.js"></script>
<script src="<%=request.getContextPath()%>/lib/js/easyui-lang-zh_CN.js"></script>
</head>

<body>
	<!-- 工具栏 -->
	<div id="tb">
		<div>
			试卷名：<input class="easyui-textbox" id="qContentSearch"> <a
				href="javascript:search()" class="easyui-linkbutton"
				iconCls="icon-search">查询</a> &nbsp;&nbsp;<a
				href="javascript:search1()" class="easyui-linkbutton"
				iconCls="icon-search">已考</a> &nbsp;&nbsp;<a
				href="javascript:search0()" class="easyui-linkbutton"
				iconCls="icon-search">未考</a>
		</div>

	</div>
	<table id="myTable" toolbar="#tb"></table>
	</div>
</body>
<script>
	//查询
	function search() {
		$('#myTable').datagrid("load", {
			examName : $("#qContentSearch").val()
		})
	}
	function search0() {
		$('#myTable').datagrid("load", {
			examStatu : 0
		})
	}
	function search1() {
		$('#myTable').datagrid("load", {
			examStatu : 1
		})
	}

	$(function() {

		loadExam();
	})
	function formatterdate(val, row) {
		if (val != null) {
			var date = new Date(val);
			return date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
					+ date.getDate();
		}
	}
	function loadExam() {
		//表格的配置信息
		$('#myTable').datagrid({
			title : '考试查询', //表格名称
			iconCls : 'icon-save', //图标
			height : 'auto', //表格高度，可指定高度，可自动
			border : true, //表格是否显示边框
			url : 'searchStuExam.do', //获取表格数据时请求的地址
			method : 'post', //表格数据获取方式,请求地址是上面定义的url
			fitColumns : true, //True 就会自动扩大或缩小列的尺寸以适应表格的宽度并且防止水平滚动。
			columns : [ [ {
				field : 'id',
				title : '考试id',
				width : 10,
				sortable : true, //排序字段
				hidden : false
			}, {
				field : 'examName',
				title : '考试名称',
				width : 30

			}, {
				field : 'examTime',
				title : '截至时间',
				width : 50,
				formatter : formatterdate

			}, {
				field : 'examScore',
				title : '考试分数',
				width : 10

			}, {
				field : 'examStatu',
				title : '是否考试',
				width : 10,
				formatter : function(val, row, index) {

					if (val == 1) {
						return "已考"
					} else {
						return "未考"
					}
				}
			}

			] ],
			pagination : true, //如果表格需要支持分页，必须设置该选项为true
			pageSize : 5, //表格中每页显示的行数
			pageList : [ 5, 15, 20 ],

			striped : true, //奇偶行是否使用不同的颜色
			remoteSort : false, //是否从服务器排序数
			sortName : 'examTime', //按照ID列的值排序
			sortOrder : 'asc', //使用倒序排序 */
			idField : 'id',
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