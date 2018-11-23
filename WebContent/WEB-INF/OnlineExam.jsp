<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>试卷</title>
<link href="lib/css/default/easyui.css" type="text/css" rel="stylesheet">
<link href="lib/css/icon.css" type="text/css" rel="stylesheet">
<script src="lib/js/jquery.min.js"></script>
<script src="lib/js/jquery.easyui.min.js"></script>
<script src="lib/js/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<!-- 倒计时还有 01时01分01秒 -->
	<h5 id="showTime" align="center"></h5>
	<!--预览试卷  -->
	<div id="showPaper"
		style="width: 400px; height: 600px; padding-left: 30%; text-shadow: gray; font-size: 12px"
		title="考试试卷"></div>
</body>
<script type="text/javascript">
	$(function() {
		showPaper();
	})
	//单选题号
	var sign = 0;
	//多选题号
	var more = 0;
	//判断题
	var judge = 0;
	//简答题
	var shortanswer = 0;
	//预览试卷
	function showPaper() {
		//$("#showPaper").window("open");
		//var row = $('#questionTb').datagrid("getSelected");
		//console.log(row.pId);
		$.post( "showPaper.do",
						{
							"pId" : "<%=session.getAttribute("paperid")%>"
						},
						function(data) {
							var html = "";
							//拼接试题名称，总分，考试时间
							html += "<h3 align='center'>试卷名称：" + data[0].p.paperName + "</h3>"
							html += "<h3 align='center'>总分：" + data[0].p.allscore + "</h3>"
							html += "<h3 align='center'>考试时间：" + data[0].p.paperTime
									+ "分钟</h3>"
							//获取单选题
							html += "<h2>一：单选题</h2>"
							for (var i = 0; i < data.length; i++) {
								if (data[i].q.qType == 1) {
									sign++;
									html += "<p>" + sign + ":"
											+ data[i].q.qContent + "</p>"
									html += "A:<input type='radio' name='s"+sign+"' value='A'>"
											+ data[i].q.aOption + "<br>";
									html += "B:<input type='radio' name='s"+sign+"' value='B'>"
											+ data[i].q.bOption + "<br>";
									html += "C:<input type='radio' name='s"+sign+"' value='C'>"
											+ data[i].q.cOption + "<br>";
									html += "D:<input type='radio' name='s"+sign+"' value='D'>"
											+ data[i].q.dOption + "<br>";
								}
							}
							//获取多选题
							html += "<h2>二：多选题</h2>"
							for (var i = 0; i < data.length; i++) {
								if (data[i].q.qType == 2) {
									more++;
									html += "<p>" + more + ":"
											+ data[i].q.qContent + "</p>"
									html += "A:<input type='checkbox' name='m"+more+"' value='A'>"
											+ data[i].q.aOption + "<br>";
									html += "B:<input type='checkbox' name='m"+more+"'value='B'>"
											+ data[i].q.bOption + "<br>";
									html += "C:<input type='checkbox' name='m"+more+"' value='C'>"
											+ data[i].q.cOption + "<br>";
									html += "D:<input type='checkbox' name='m"+more+"'value='D'>"
											+ data[i].q.dOption + "<br>";
								}
							}

							//获取判断题
							html += "<h2>三：判断题</h2>"
							for (var i = 0; i < data.length; i++) {
								if (data[i].q.qType == 3) {
									judge++;
									html += "<p>" + judge + ":"
											+ data[i].q.qContent + "</p>"
									html += "√:<input type='radio' name='j"+judge+"' value='√'>";
									html += "×:<input type='radio'name='j"+judge+"' value='×'>";

								}
							}
							html += "<h2>四：简答题</h2>"
							for (var i = 0; i < data.length; i++) {
								if (data[i].q.qType == 4) {
									shortanswer++;
									html += "<p>" + shortanswer + ":"
											+ data[i].q.qContent + "</p>"
									html += "<textarea style='width:500px;height:200px;resize:none;' id='shortanswer"+shortanswer+"'></textarea>";
								}
							}
							html += "<br><button onclick='getPaper()' style='margin: 10px 15px'>提交试卷</button>";
							$("#showPaper").append(html);

						})
	}

	var answerArr = new Array();
	//提交试卷
	function getPaper() {
		//获取单选题弹
		for (var i = 1; i <= sign; i++) {
			var sanswer = $('input[name="s' + i + '"]:checked').val();
			answerArr.push(sanswer);
		}
		//获取多选题弹
		for (var i = 1; i <= more; i++) {
			var manswer = "";
			$('input[name="m' + i + '"]:checked').each(function() {
				manswer += $(this).val()
			})
			answerArr.push(manswer);
		}
		//获取判断题
		for (var i = 1; i <= judge; i++) {
			var sanswer = $('input[name="j' + i + '"]:checked').val();
			answerArr.push(sanswer);
		}
		//获取简答题答案
		for (var i = 1; i <= shortanswer; i++) {
			var sanswer = $('textarea[id="shortanswer' + i + '"]').val();
			answerArr.push(sanswer);
		}
		//
		var answer="";
		for (var i = 0; i < answerArr.length; i++) {
			answer += answerArr[i]+",";
		} 
		$.messager.confirm("信息提示", "是否提交",function(is){
			if(is){
				$.ajax({
					url:"delanswer.do",
					dataType:"text",
					data:{"arr":answer,"pId" : "<%=session.getAttribute("paperid")%>"},
					success:function(data){
						if(data=='success'){
							$.messager.alert("信息提示","提交成功","info");
							window.location.href = "redo.do";
						}else{
							$.messager.alert("信息提示","提交失败","info");
						}
						
					}
				});
			}
		});
	}
</script>
<script>
	//设置倒计时的时间范围 单位秒
	var seconds = "<%=session.getAttribute("time")%>";

	//启动计时函数
	timeRun();

	//定时调用函数
	var timer = setInterval(timeRun, 1000);

	//倒计时函数
	function timeRun() {
		//获取 showTime
		var showTime = document.getElementById('showTime');
		//判断倒计时时间结束
		if (seconds < 0) {
			//清除计时器
			clearInterval(timer);
			alert("时间到了，系统自动提交答卷")
			getPaper();
			return;
		}
		//计算 秒数 里面包含的小时数
		var h = Math.floor(seconds / 3600);
		//计算剩下的秒数
		var s = seconds - h * 3600;
		//在从剩下的秒数中 取出 分钟
		var m = Math.floor(s / 60);
		//计算剩下的秒数
		s -= m * 60;

		//处理数字 <10的数字前加0
		h = (h < 10) ? '0' + h : h;
		m = (m < 10) ? '0' + m : m;
		s = (s < 10) ? '0' + s : s;

		//拼接字符串
		var message = "考试结束还有 " + h + '时' + m + '分' + s + '秒';
		//把字符串输出到showTime中
		showTime.innerHTML = message;

		//秒数减少
		seconds--;
	}
</script>
</html>