<%@ page language="java" import="java.util.*,java.sql.*"   
         contentType="text/html; charset=utf-8"%>
<%  request.setCharacterEncoding("utf-8");  
    String msg ="";  
    String connectString = "jdbc:sqlserver://localhost:1433;DatabaseName=DBS_Pro";   
        StringBuilder table=new StringBuilder("");
        String query="";
        if(request.getMethod().equalsIgnoreCase("post")){
            query = request.getParameter("query");}  
    try{  
      Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");  
      Connection con=DriverManager.getConnection(connectString, "sa", "123");  
      Statement stmt=con.createStatement();  
      ResultSet rs=stmt.executeQuery("select * from Book where B_nanme like '%"+query+"%' or B_author like '%"+query+"%' or B_num like '%"+query+"%'");  
      table.append("<table><tr><th>书名</th><th>出版社</th><th>作者</th><th>出版日期</th><th>当前库存</th><th>-</th>");  
      while(rs.next()) {  
          table.append(String.format(  
              "<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s %s</td></tr>",  
              rs.getString("B_name"),rs.getString("B_press"),rs.getString("B_author"),
              rs.getString("B_publish_date"),rs.getString("B_num"),
              "<a href='updateStu15352195_1.jsp?B_pid="+rs.getString("B_id")+"'>借书</a>",  
              "<a href='deleteStu15352195_1.jsp?B_pid="+rs.getString("B_id")+"'>预约</a>"));}
      table.append("</table>");  
      rs.close();  
      stmt.close();  
      con.close();} 
    catch (Exception e){  
      msg = e.getMessage();}%>
