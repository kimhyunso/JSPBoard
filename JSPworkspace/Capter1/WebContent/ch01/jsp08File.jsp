<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>    

<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>내장 객체(File.jsp)</title>

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
		<h2>File</h2>
	</header>
	
	<textarea class="form-control" rows=10><%
		BufferedReader reader = null;
		try{
						
			String filePath = application.getRealPath("/ch01/jsp01.jsp");
			out.print("jsp01.jsp 파일을 읽어봅니다.");
			
			reader = new BufferedReader(
					new InputStreamReader(
							new FileInputStream(filePath),"UTF-8"
					)
			);
			
			while(true){
				String str = reader.readLine();
				if(str == null) break;
				out.print(str+"\n");
			}
			
		}catch(Exception e){
			out.print("Error! "+e.getMessage());
		}finally{
			try{
				if(reader != null)reader.close();
			}catch(Exception e){}
		}
		
	%></textarea>
	
</div>


<script src="./js/bootstrap.min.js"></script>
	
</body>
</html>