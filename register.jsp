<%@ page language="java" import="java.util.*,java.sql.*"
    contentType="text/html; charset=utf-8"%>
<%  request.setCharacterEncoding("utf-8");
    String msg = "";
	String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"
	                       + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user";
	String pwd="123";
	String img_path="th.jpg";
	String name = request.getParameter("name");
	if(name==null) name="";
	String gender = request.getParameter("gender");
	if(gender==null) gender="";
	String genders[]= {"","",""};
	if(gender.equals("secrecy"))
		genders[0] = "checked";
	else if(gender.equals("male"))
		genders[1] = "checked";
	else if(gender.equals("female"))
		genders[2] = "checked";
	String email = request.getParameter("email");
	if(email==null) email="";
	String password = request.getParameter("pwd2");
	String introduce = request.getParameter("introduce");
	if(introduce==null) introduce="这个人很懒，什么都没有留下。";
	if(request.getMethod().equalsIgnoreCase("post")) {
	   Class.forName("com.mysql.jdbc.Driver");
	   Connection con = DriverManager.getConnection(connectString,user, pwd);
	   Statement stmt = con.createStatement();
	   try{
		   if(name!=null && password!=null){
			   String fmt="insert into user(name,gender,email,password,introduce,img_path) values('%s','%s','%s','%s','%s','%s')";
			   String sql = String.format(fmt,name,gender,email,password,introduce,img_path);
			   int cnt = stmt.executeUpdate(sql);
			   if(cnt>0)msg = "注册成功!";
		   }
		   stmt.close();
		   con.close();}
    catch (Exception e){
       msg = e.getMessage();}}%>
<!DOCTYPE HTML>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="css/font-awesome.css" /> 
	<style>
	a:link,a:visited {color:blue;}
    .container{
		width: 500px;
		margin: 10% auto 0;
		padding: auto auto;
		text-align: center;
		border:1px solid black;
		border-radius: 2em 2em;
		background: rgba(255,255,255,0.9);
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
	<script language="javascript">    
    function isValid(form){    
		if (form.name.value==""){    
			 alert("用户名不能为空");    
			 return false;}
		if (form.pwd1.value!=form.pwd2.value){    
			alert("两次输入的密码不同！");    
			return false;}    
		else  if (form.pwd1.value==""){    
			alert("用户密码不能为空！");    
			return false;} 
		else return true;}    
	</script> 
</head>
<body>
	<div id="bk">  
		<img src="images/bk.jpg" height="100%" width="100%"/>  
	</div>
    <div class="container">
	    <h1>注册</h1>
	    <table border="0" width="53%" cellspacing="0" id="table" height="358" align="center">
		<form action="register.jsp" method="post" name="f" onSubmit="return isValid(this);">
	     	<tr><td width="37%" align="right">*姓名:</td><td width="61%"><input id="name" type="text" name="name"/></td> </tr>	
	     	<tr><td width="37%" align="right">
	     	        性别:</td><td width="61%">
	     	        保密<input type="radio" name="gender" value="secrecy" />
	     	         男<input type="radio" name="gender" value="male" />
	     	         女<input type="radio" name="gender" value="female"/></td></tr>	
	     	<tr><td width="37%" align="right">邮箱:</td>  <td width="61%"><input id="email" type="text" name=1"email"/></td> </tr>
	     	<tr><td width="37%" align="right">*密码:</td>  <td width="61%"><input id="password" type="text" name="pwd1" ></td> </tr>
	     	<tr><td width="37%" align="right">*确认密码:</td>  <td width="61%"><input id="password" type="text" name="pwd2" ></td> </tr>
	     	<tr><td width="37%" align="right">自我介绍:</td>  <td width="61%">
	     	<textarea id="introduce" name="introduce"></textarea></td> </tr>
	     	<tr><td colspan="2" height="38"><p align="center">
		    <input type="reset" name="reset" value=" 重置 ">
		    <input type="submit" name="sub" value=" 注册 ">
		    </p></td></tr>
		    </form>
		    </table>
		    <%=msg%>
		    <a href='login.jsp'>登录</a>
		    <a href='zong1.html'>返回</a>
		    <br><br>
		</div>
	</div>
</body>
</html>
