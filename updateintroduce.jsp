<%@ page language="java" import="java.util.*,java.sql.*"
	contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
	String msg = "";
	String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String introduce="";
	boolean error = false;
	String pid = (String)session.getAttribute("pid");
	try{ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,"user","123");
		Statement stmt = con.createStatement();
		String sql="select * from user where id="+pid+";";
		ResultSet rs=stmt.executeQuery(sql); 
		while(rs.next()){
			introduce=rs.getString("introduce");
		}
		rs.close();
		String sub=request.getParameter("sub");
		if(sub!=null){
			introduce = request.getParameter("introduce");
			if(introduce=="")	{
				error = true;
				msg = "个性签名不能为空!";
			}
			if(!error){
				sql="update user set introduce='"+introduce+"' where id="+pid+";";
				int cnt = stmt.executeUpdate(sql);
				if(cnt>0){
					msg = "修改成功!";
					request.getSession().setAttribute("introduce",introduce);
				}
			}
		}
		stmt.close(); con.close();
	}catch (Exception e){
		msg = e.getMessage();
	}
	%>
<!DOCTYPE HTML><html><head><title>修改个性签名</title>
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
		body{
			margin: 0 auto;
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
	</style>
</head>
	<body>
	<div id="bk">  
		<img src="images/bk.jpg" height="100%" width="100%"/>  
	</div>
	<div class="container">
		<h1>修改个性签名</h1>
		<form action="updateintroduce.jsp?pid=<%=pid%>" method="post" name="f">
	    <label for="content">个性签名:</label>
	    <textarea id="introduce" name="introduce"><%=introduce%></textarea><br/><br/>
		<input type="submit" name="sub" value="修改">
		<input type="reset" name="reset" value="清空" autocomplete="off"><br/><br/>
		</form>
		<%=msg %>
		<br/>
		<a href='test.jsp'>返回</a><br/><br/>
	</div>
	</body>
</html>
