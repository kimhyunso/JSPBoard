<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MySQL</title>

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
			<h2 class="text-primary">MySql Connect</h2>
		</header>
	</div>
<%
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	
	String idx = request.getParameter("idx");
	if(idx == null){
		idx = "1";
	}
	try{
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/itbank2?characterEncoding=utf-8",
				"itbank2", "itbank2pass"
				);
		
		if(conn != null){
			out.print("OK : itbank2 Connection <br>");		
			
			stmt = conn.createStatement();
			String sql = "";
			
			sql = "select *from dept where idx = '"+idx+"'";
			ResultSet rs = null;
			rs = stmt.executeQuery(sql);
			
			//sql = "select *from dept where idx = ?";
			//pstmt = conn.prepareStatement(sql);
			//pstmt.setString(1, idx);
			//rs = pstmt.executeQuery();
			
			//out.print("[pstmt] = "+pstmt+"<br>");
			
			if(rs.next()){
				String name = rs.getString("name");
				String major = rs.getString("major");
				int age = rs.getInt("age");
				
				out.print("name = "+name+"<br>");
				out.print("major = "+major+"<br>");
			}
			
		}else{
			out.print("Error : itbank2 Connection");
		}
	}finally{
		try{
			if(conn != null)conn.close();
			out.print("OK : itbank2 Close <br>");
			if(stmt != null) stmt.close();
		}catch(Exception e){}
	}
%>
</body>
</html>