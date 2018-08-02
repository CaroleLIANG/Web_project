<%@ page language="java" import="java.util.*,java.sql.*"
	contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
	String msg = "";
	String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	boolean error = false;
	String pid = request.getParameter("pid");
	try{ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,"user","123");
		Statement stmt = con.createStatement();
		String sql="delete from comment where id="+pid+";";
                int flag= stmt.executeUpdate(sql);
                if(flag > 0) {
                    msg = "Delete Success!";}
		stmt.close(); con.close();
	}catch (Exception e){
		msg = e.getMessage();
	}%>
<!DOCTYPE HTML>
<html>
<head>
   <title>删除评论</title>
   <style>
     a:link,a:visited {color:blue}
     .container{  
    	margin:10% auto; 
    	width:400px;  
    	text-align:center;  
    	border:1px dashed black;
    	padding: 15px;
    	border-radius: 2em;
     } 
     body{
		background-color: rgba(187,231,172,0.2);
	}
   </style>
</head>
<body>
  <div class="container">
    <h1>删除评论</h1>
	Delete Success!<br/><br/>
	<a href='commentshow.jsp'>返回</a>
  </div>
</body>
</html>
