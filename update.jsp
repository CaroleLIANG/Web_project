<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page language="java" import="java.util.*,java.sql.*"
    contentType="text/html; charset=utf-8"%>
<%
   request.setCharacterEncoding("utf-8");
    String msg = "";
	String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String img_path=request.getParameter("p");
	String pid =(String)session.getAttribute("pid"); 
	try{ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,"user","123");
		Statement stmt = con.createStatement();
	    String sql="update user set img_path='"+img_path+"' where id='"+pid+"';";
	    int cnt = stmt.executeUpdate(sql);
		if(cnt>0) {msg="修改成功！";
		request.getSession().setAttribute("path", img_path);}
		stmt.close(); con.close();
	}catch (Exception e){
		msg = e.getMessage();
	}
	%>

	<!DOCTYPE  html>
<html  lang="zh-cn">
<head>
<meta charset="utf-8">
<title>修改头像</title>
</head>
<style type="text/css">
	body{
		background-color: rgba(187,231,172,0.2);
		text-align: center;
	}
	p{
		border-radius: 12em;
		border: 1px dashed black;
	}
</style>
<body>
<p><%=msg%></p>
<a href="test.jsp">返回</a>
</body>
</html>