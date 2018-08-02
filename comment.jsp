<%@ page language="java" import="java.util.*,java.sql.*"
    contentType="text/html; charset=utf-8"%>
<%  request.setCharacterEncoding("utf-8");
    String msg = "";
	String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"
	                       + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String user="user";
	String pwd="123";
	String user_id= (String)session.getAttribute("pid"); //session
	String user_name= (String)session.getAttribute("name"); 
	String campi = request.getParameter("campi");
	if(campi==null) campi="";
	String campis[]= {"","","","",""};
	if(campi.equals("南校区"))
		campis[0] = "checked";
	else if(campi.equals("东校区"))
		campis[1] = "checked";
	else if(campi.equals("北校区"))
		campis[2] = "checked";
	else if(campi.equals("珠海校区"))
		campis[3] = "checked";
	String comment = request.getParameter("comment");
	if(comment==null) comment="";
	if(request.getMethod().equalsIgnoreCase("post")) {
	   Class.forName("com.mysql.jdbc.Driver");
	   Connection con = DriverManager.getConnection(connectString,user, pwd);
	   Statement stmt = con.createStatement();
	   try{
		   if(comment!=null && campi!=null){
			   String fmt="insert into comment(user_id,user_name,campi,comment) values('%s','%s','%s','%s')";
			   String sql = String.format(fmt,user_id,user_name,campi,comment);
			   int cnt = stmt.executeUpdate(sql);
			   if(cnt>0)msg = "评论成功!";
		   }
		   stmt.close();
		   con.close();}
    catch (Exception e){
       msg = e.getMessage();}}%>
<!DOCTYPE HTML>
<html>
<meta charset="utf-8">
<head>
<script language="javascript">    
    function isValid(form){    
		if (form.comment.value==""){    
			 alert("评论不能为空");    
			 return false;}   
		if (form.campi.value==""){    
			alert("校区不能为空！");    
			return false;} 
		else return true;}    
	</script> 
    <title>发表评论</title>
	<style>
	a:link,a:visited {color:blue;}
	.container{
		width: 290px;
		margin: 10% auto 0;
		padding-top: 30px;
		text-align: center;
		border:1px solid black;
		border-radius: 2em 2em;
		background-color: rgba(187,231,172,0.2);
	}
	body{
		background-color: rgba(187,231,172,0.2);
	}
	</style>
</head>
<body>
    <div class="container">    	
			<form action="comment.jsp" method="post" name="f" onSubmit="return isValid(this);">
				<table border="0" width="80%" cellspacing="0" id="table" height="130" align="center">
	     			<tr><td width="15%" align="right">校区:</td><td width="30%" align="right">南校区<input type="radio" name="campi" value="南校区" <%=campis[0]%>/></td><td width="30%" align="right">东校区<input type="radio" name="campi" value="东校区" <%=campis[1]%>/></td></tr>	  
	     	        <tr><td width="30%" align="right"></td><td width="30%" align="right">北校区<input type="radio" name="campi" value="北校区" <%=campis[2]%>/></td><td width="30%" align="right">珠海校区<input type="radio" name="campi" value="珠海校区" <%=campis[3]%>/></td></tr>
				
	     	<tr><td width="15%" align="right">评论:</td><td colspan="2">
	     	<textarea id="comment" name="comment"><%=comment%></textarea></td> </tr>
	     	<tr><td width="15%" align="right"></td><td colspan="2" height="38"><p align="center">
		    <input type="reset" name="reset" value=" 重置 ">
		    <input type="submit" name="sub" value=" 发表 "></p></td></tr>
		</table>
		    </form><br/>
		    <%=msg%><br/>
		    <a href="comment.jsp">返回</a><br/><br/>
	</div>
</body>
</html>

