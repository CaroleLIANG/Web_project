<%@ page language="java" import="java.util.*,java.sql.*"
    contentType="text/html; charset=utf-8"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="javax.servlet.http.Cookie.*" %>
<%@ page import="javax.servlet.http.HttpSession.*" %>
<%@ page import="javax.servlet.http.HttpServletResponse.*" %>
<%@ page import="javax.servlet.http.HttpServletRequest.*" %>
<%@ page import="javax.servlet.http.HttpServlet.*" %>
<%@ page import="javax.servlet.ServletException.*" %>
<%@ page language="java" import="java.util.*,java.sql.*"
    contentType="text/html; charset=utf-8"%>
<%  request.setCharacterEncoding("utf-8");
    String msg = "";
	String connectString = "jdbc:sqlserver://localhost:1433;DatabaseName=DBS_Pro"
	                       + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="sa";
	String pwd="123";
    String name="";
    String password="";
    String pid="";
    String path="";
	boolean flag=false;
	if(request.getMethod().equalsIgnoreCase("post")) {
		name = request.getParameter("name");
		password = request.getParameter("password");}
	   try{
		   Class.forName("com.mysql.jdbc.Driver");
		   Connection con = DriverManager.getConnection(connectString,user,pwd);
		   Statement stmt = con.createStatement();
		   ResultSet cnt=stmt.executeQuery("select * from Reader where R_name = '"+name+"' and R_password = '"+password+"'");
		   if(cnt.next()){
			   pid=cnt.getString("R_id");
			   path=cnt.getString("img_path");
               request.getSession().setAttribute("name", name);  
               request.getSession().setAttribute("pid", pid);
               request.getSession().setAttribute("path",path);
               request.getSession().setAttribute("introduce",cnt.getString("introduce"));
               response.sendRedirect("zong1.html");}//这里要改成我们的捉泥页面
		   else{
		       msg="请确保用户名和密码正确。";}
		   stmt.close();
		   con.close();}
    catch (Exception e){
       msg = e.getMessage();}%>  
<html>  
<head>  
<title>登录</title>  
</head>  
<link rel="stylesheet" type="text/css" href="css/font-awesome.css" /> 
<style>	
	#main{
		width: 350px;
		margin: 10% auto 0;
		padding: auto auto;
		text-align: center;
		border:1px solid black;
		border-radius: 2em 2em;
		background: rgba(255,255,255,0.9);
	}
	#main_in{
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
		<div id="main">
			<h1>Welcome back</h1>
			<div id="main_in">
			<form action="login.jsp" method="post">   
				<p><i class="fa fa-user fa-fw" ></i>&emsp;
					<input type="text" name="name" size="20" placeholder="用户名" value="<%=name%>"/></p> 
	  			<p><i class="fa fa-key fa-fw"></i>&emsp;<input type="password" name="password" size="20" placeholder="密码" value="<%=password%>"/></p>
			  	<input type="submit" name="sub" value="登录"/>
			  	<input type="reset" value="重置"/>  
			</form>
			<p><%=msg%></p>
	  	 	</div>
	 		<p>如果您还没有注册，请单击<a href="register.jsp">这里</a>注册!</p>
		</div>		
	</div>
</body>    
</html>