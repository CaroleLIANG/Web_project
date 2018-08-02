<%@ page language="java" import="java.util.*,java.sql.*"   
         contentType="text/html; charset=utf-8"%>

<%  request.setCharacterEncoding("utf-8");  
    String msg ="";  
    String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"  
                    + "?autoReconnect=true&useUnicode=true"  
                    + "&characterEncoding=UTF-8";   
        String query="";
        if(request.getMethod().equalsIgnoreCase("post")){
            query = request.getParameter("query");}  
    try{  
      Class.forName("com.mysql.jdbc.Driver");  
      Connection con=DriverManager.getConnection(connectString,   
                     "user", "123");  
      Statement stmt=con.createStatement();  
      ResultSet rs=stmt.executeQuery("select * from comment where campi like '%"+query+"%'or comment like '%"+query+"%'"); 
%>
<!DOCTYPE HTML>   
<html>  
   <style>  
    a:link,a:visited {
      color:blue
    }
    #shows{
      border-radius: 2em;
      border: 1px dashed black;
      padding: 15px;
      margin-bottom: 5px;
    }
    .container{  
      margin:0 auto;   
      width:290px;  
      text-align:center;  
    }  
    body{
      background-color: rgba(187,231,172,0.2);
    }
   </style>
<head><title>查询</title></head>  
<body>  
  <div class="container">  
      <h1>查询</h1>
		<form action="querycomment.jsp"  method="post">
		    输入查询:<input type="text" name=query value="<%=query%>" >
 		<input type="submit" name="sub" value="查询">
		</form><br/>
<%
      while(rs.next()) {  
          %>
          <div id="shows">
            <p style="text-align: left;">校区:<%=rs.getString("campi") %></p>
            <p style="text-align: left;"><%=rs.getString("user_name") %>说：&nbsp;&nbsp;<%=rs.getString("comment") %></p>
          </div>
          <%
          }
      rs.close();  
      stmt.close();  
      con.close();} 
    catch (Exception e){  
      msg = e.getMessage();}%>
      <div style="float:left"><a href='commentshow.jsp'>返回</a></div></div>
</body>  
</html> 