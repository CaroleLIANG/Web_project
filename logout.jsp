<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>  
  
<%  
session.removeAttribute("pid");  //���Session���� 
session.removeAttribute("path");
session.removeAttribute("name");
session.removeAttribute("introduce");
response.sendRedirect("zong1.html");  
%>  