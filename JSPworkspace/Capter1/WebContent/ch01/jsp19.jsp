<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
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
	
	
	
	String root = request.getSession().getServletContext().getRealPath(savePath);
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
<%
	String fileName = uploadFilePath + "/" + serverFileName;
	File file;
	BufferedImage bi;
	BufferedImage dst; // 썸네일
	                   //원본 a.jpg -> thumb_a.jpg
	out.print("fileName = "+fileName+"<br>");
	int x = 0;
	int y = 0;
	int width = 100;
	int height = 100;
		
	String serverThumbFileName = "thumb_"+serverFileName;
	String thumbFileName = uploadFilePath + "/" + serverThumbFileName;
	
	try{
		file = new File(fileName);
		bi = ImageIO.read(file);
		x = bi.getWidth();
		y = bi.getHeight();
		
		out.print("x = "+x+" , "+"y = "+y+"<br>");
	
		if(x>y){ //가로형 사진
			height = (int)(y * width / x);
		}else{ //세로형 사진
			width = (int)(x * height / y); 			
		}
		
		
		dst = new BufferedImage(width,height,BufferedImage.TYPE_3BYTE_BGR);
		java.awt.Graphics2D g = dst.createGraphics();
		g.drawImage(bi,0,0,width,height,null);
		
		File outFile = new File(thumbFileName);
		ImageIO.write(dst,"JPEG",outFile);
		
	}catch(Exception e){
		out.print("Error : "+e.getMessage()+"<br>");
	}
%>			
		</form>
		업로드 된 파일의 ThumbNail<br>
		<img src="upload/<%=serverThumbFileName%>"><br>
		<a href="jsp18FileUploadSize.jsp">이전화면으로 돌아가기</a>
	</div>
</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>