<%@ page language="java" import="java.util.*,java.io.*"
contentType="text/html;charset=utf-8"%>
<% 
	request.setCharacterEncoding("utf-8");
    String name =(String)session.getAttribute("name"); 
    String pid =(String)session.getAttribute("pid"); 
    String path =(String)session.getAttribute("path"); 
    String introduce =(String)session.getAttribute("introduce");
    ServletContext context = pageContext.getServletContext();
    String filePath = context.getInitParameter("file-upload");
    String url = "images//"+path;%>
<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
<meta charset="utf-8">
<title>个人中心</title>
</head>
<style type="text/css">
	body{
		background-color: rgba(187,231,172,0.2);
		text-align: center;
	}
	#container{
		width: 400px;
		margin: 10% auto;
		padding: 20px;
		text-align: center;
		border:1px solid black;
		border-radius: 2em 2em;
		background: rgba(255,255,255,0.9);
	}
	#photo{
		width: 100px;
		height: 100px;
		border-radius: 100px;
		border: 1px dashed black;
		overflow: hidden;
		margin: 0 auto;
		text-align: center;
	}
	#bk{
		position:absolute; 
		top: -1.5px;
		left: -1.5px;
		width:100%; 
		height:100%; 
		z-index:-1;
		opacity: 0.6;
		overflow: hidden;
		margin: auto;
	}
	body{
		margin: 0 auto;
	}
</style>
<body>
	<div id="bk">  
		<img src="images/bk.jpg" height="100%" width="100%"/>  
	</div>
	<div id="container">
		<h1 align="left"><%=name%>,欢迎您</h1> 
		<p align="left">个性签名：</p>
		<p align="left">&emsp;&emsp;<%=introduce%></p>
		<div id="photo"><img width="100" height="100" src="<%=url%>"/></div>
		<br>
		<a href="uploadshow.html">修改头像</a>
		<a href="updateintroduce.jsp">修改签名</a>
		<a href="login.jsp">重新登录</a>
		<a href="zong1.html">返回主页</a>
	</div>
</body>
</html>