<%@page import="java.sql.Connection,java.sql.Statement,java.util.Scanner,java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<!DOCTYPE html>
<html>
<head>

<style>

  .c1 {
    width:100px
  }
  .c2 {
    width:200px
  }
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

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>评论浏览</title>
</head>
<body>

<div class="container">
      <h1>评论浏览</h1>  
<%
request.setCharacterEncoding("utf-8");
String pid =(String)session.getAttribute("pid");
if(pid==null){
	pid="0";
}
String check="1";
String pgno = "";  //网址中传递的页面数据
String pgcnt = ""; //网址传递的每页最大显示数目
int RowAmount = 0; //数据库中总的行数
int PageAmount = 0; //数据库所有页面可以组成多少个页面
int PageSize; //每页最大显示数目
int PageNow;  //当前页面
ResultSet rs;
if(request.getParameter("pgno")!=null){  //获取网址从传递的数据
    pgno = request.getParameter("pgno");
}else{
    pgno = "1";  //赋给初始值防止没有传入数据时崩溃
}
PageNow = java.lang.Integer.parseInt(pgno);
if(PageNow <= 0){
    PageNow = 1;
}

if(request.getParameter("pgcnt")!=null){
    pgcnt = request.getParameter("pgcnt");
}else{
    pgcnt = "4";
}
PageSize = java.lang.Integer.parseInt(pgcnt); //**转换为int类型**

try{
    String connectString = "jdbc:mysql://172.18.187.232:53306/liang15352195"
            + "?autoReconnect=true&useUnicode=true&characterEncoding=UTF-8";
    String user = "user";
    String pwd = "123";
    String sql = "select *from comment;";
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(connectString, user, pwd);

    Statement state = conn.createStatement();
    rs = state.executeQuery(sql);
    rs.last();
    RowAmount = rs.getRow();
    PageAmount = (RowAmount + PageSize - 1 )/ PageSize;
    if(PageNow > PageAmount){
        PageNow = PageAmount;
    }
    if(PageAmount > 0){
        rs.absolute((PageNow - 1)*PageSize + 1); 
    }
    if(pid.equals(check)){
        for(int i = 0 ; i < PageSize && !rs.isAfterLast(); i++){
            %>
            <div id="shows">
              <p style="text-align: left;">校区:<%=rs.getString("campi") %></p>
              <p style="text-align: left;"><%=rs.getString("user_name") %>说：&nbsp;&nbsp;<%=rs.getString("comment") %></p>
              <a href='deletecomment.jsp?pid=<%=rs.getString("id") %>'>删除</a>
          </div>
            <%
            rs.next();
        }
    }else {
        for(int i = 0 ; i < PageSize && !rs.isAfterLast(); i++){
            %>
            <div id="shows">
              <p style="text-align: left;">校区:<%=rs.getString("campi") %></p>
              <p style="text-align: left;"><%=rs.getString("user_name") %>说：&nbsp;&nbsp;<%=rs.getString("comment") %></p>
          </div>
            <%
            rs.next();
        }
    }
    rs.close();
    state.close();
    conn.close();
    }catch (Exception e){
    e.printStackTrace();
}
%>    
      <br><br>  
      <div style="float:left">
         <a href="mycomment.jsp">我的评论</a>&nbsp;&nbsp;
         <a href="querycomment.jsp">查询评论</a>
      </div>
      <br/><br/>
      <div style="float:right">
        <a href="commentshow.jsp?pgno=<%=PageNow-1 %>&pgcnt=4">
                        上一页</a>    &nbsp;               
        <a href="commentshow.jsp?pgno=<%=PageNow+1 %>&pgcnt=4">
                       下一页</a>
      </div>

  </div>
</body>
</html>