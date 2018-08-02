<%@ page language="java" import="java.util.*,java.sql.*"
	contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");
	String msg = "";
	String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"
				+ "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
	String comment="";
	boolean error = false;
	String pid = request.getParameter("pid");
	
	try{ 
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(connectString,"user","123");
		Statement stmt = con.createStatement();
		String sql="select * from comment where id="+pid+";";
		ResultSet rs=stmt.executeQuery(sql); 
		while(rs.next()){
			comment=rs.getString("comment");
		}
		rs.close();
		String sub=request.getParameter("sub");
		if(sub!=null){
			comment = request.getParameter("comment");
			if(comment=="")	{
				error = true;
				msg = "评论不能为空!";
			}
			if(!error){
				sql="update comment set comment='"+comment+"' where id="+pid+";";
				int cnt = stmt.executeUpdate(sql);
				if(cnt>0)msg = "修改成功!";
			}
		}
		stmt.close(); con.close();
	}catch (Exception e){
		msg = e.getMessage();
	}
	%>
<!DOCTYPE HTML><html><head><title>修改评论</title>
	<style> 
		a:link,a:visited {color:blue;}
		.container{margin:0 auto;width:500px;text-align:center;}
		  body{
   		background-color: rgba(187,231,172,0.2);
  }
	</style>
</head>
	<body>
	<div class="container">
		<h1>修改评论</h1>
		<form action="updatecomment.jsp?pid=<%=pid %>" method="post" name="f">
	    <label for="content">评论:</label>
	    <textarea id="comment" name="comment"><%=comment%></textarea><br/><br/>
		<input type="submit" name="sub" value="修改">
		<input type="reset" name="reset" value="清空" autocomplete="off"><br/><br/>
		</form>
		<%=msg %>
		<br/>
		<a href='commentshow.jsp'>返回</a>
	</div>
	</body>
</html>
