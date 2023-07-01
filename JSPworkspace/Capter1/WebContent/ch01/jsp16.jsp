<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	String savePath = "ch01/upload";
	String uploadFilePath = getServletContext().getRealPath(savePath);
	System.out.println("uploadFilePath = " + uploadFilePath);
	
	int uploadFileSizeLimit = 50 * 1024 * 1024;
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(
								request,
								uploadFilePath,
								uploadFileSizeLimit,
								encType,
								new DefaultFileRenamePolicy()
							);
	
	String serverFileName = multi.getFilesystemName("upfile");
	String originalFileName = multi.getOriginalFileName("upfile");
%>    
    
    
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>파일 업로드 처리</title>

    <!-- Bootstrap -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/custom2.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<body>

<div class="container">

	<header>
		<h2>파일 업로드</h2>
	</header>

	<div class="form-group">
		<form  role="form" class="inline-form" enctype="multipart/form-data" method="post" action="jsp16.jsp">
		<div class="container">
			업로드 폴더 위치 : <%=uploadFilePath %> <br>
			사용자 업로드한 파일명 : <%=originalFileName %><br>
			서버에 업로드된 파일명 : <%=serverFileName %> <br><br>
			
			<img src="upload/<%=serverFileName %>"><br>
		</div>
			
			
		</form>
	</div>
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>