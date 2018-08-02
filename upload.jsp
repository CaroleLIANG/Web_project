<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page language="java" import="java.util.*,java.sql.*"
    contentType="text/html; charset=utf-8"%>
<%
   request.setCharacterEncoding("utf-8");
   File file ;
   String path="";
   String img_path="";
   String pid =(String)session.getAttribute("pid"); 
   String s=pid+"_";
   String msg="YES";
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");

   // 验证上传内容了类型
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {

      DiskFileItemFactory factory = new DiskFileItemFactory();
      // 设置内存中存储文件的最大值
      factory.setSizeThreshold(maxMemSize);
      // 本地存储的数据大于 maxMemSize.
      factory.setRepository(new File("c:\\temp"));

      // 创建一个新的文件上传处理程序
      ServletFileUpload upload = new ServletFileUpload(factory);
      // 设置最大上传的文件大小
      upload.setSizeMax( maxFileSize );
      try{ 
         // 解析获取的文件
         List fileItems = upload.parseRequest(request);
         // 处理上传的文件
         Iterator i = fileItems.iterator();
         out.println("<html>");
         out.println("<head>");
         out.println("<title>修改头像</title>");  
         out.println("</head>");%>
      <style type="text/css">
         body{
            background-color: rgba(187,231,172,0.2);
            text-align: center;
            margin: 10% auto;
         }
         #photo{
            width: 100px;
            height: 100px;
            border-radius: 100px;
            border: 1px dashed black;
            overflow: hidden;
            margin: 0 auto;
            text-align: center;
         }

</style>
         <%
         out.println("<body>");
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            if ( !fi.isFormField () )	
            {
            // 获取上传文件的参数
            //String fieldName = fi.getFieldName();
            String fileName = fi.getName();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();
            // 写入文件
            if( fileName.lastIndexOf("\\") >= 0 ){
	            file = new File( filePath , 
	            fileName=s+fileName.substring( fileName.lastIndexOf("\\")+1)) ;
            }else{
	            file = new File( filePath ,
	            fileName=s+fileName.substring(fileName.lastIndexOf("\\")+1)) ;
            }
            fi.write(file);
            path="images\\"+fileName;
            img_path=fileName;
            }
         }
         %>
         <div id="photo"><img width="100" height="100" src="<%=path%>"/></div>
         <br/><br/>
         <a href="update.jsp?p=<%=img_path%>">继续</a>
         <a href="uploadshow.jsp">返回</a>
         <%
         out.println("</body>");
         out.println("</html>");
      }catch(Exception ex) {
         System.out.println(ex);
      }
   }%>