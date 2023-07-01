<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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
    <title>MySql </title>

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
		<h2 class="text-primary">MySql PSTMT</h2>
	</header>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;

	try 
	{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/itbank2?characterEncoding=utf8",
					"itbank2", "itbank2pass"
				);

		if(conn != null)
		{
			out.print("OK : itbank2 Connection <br>");

			String sql = "";
			sql = "select * from dept order by major asc, name asc";
			ResultSet rs = null;
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, idx);
			rs = pstmt.executeQuery();
			out.print("[ pstmt ] = " + pstmt + "<br>");
				
			List<String> listName = new ArrayList<String>();
			List<Integer> listIdx = new ArrayList<Integer>();
			List<String> listMajor = new ArrayList<String>();
			List<Integer> listAge = new ArrayList<Integer>();
			
			while(rs.next())
			{
				String name = rs.getString("name");
				String major = rs.getString("major");
				int age = rs.getInt("age");
				int tmpIdx = rs.getInt("idx");
				
				listName.add(name);
				listMajor.add(major);
				listAge.add(age);
				listIdx.add(tmpIdx);
			}
				
			request.setAttribute("listName", listName);
			request.setAttribute("listMajor", listMajor);
			request.setAttribute("listAge", listAge);
			request.setAttribute("listIdx", listIdx);
			
			request.setAttribute("listSize", listIdx.size());
					
			
		}else
		{
			out.print("Error : itbank2 Connection<br>");
		}
	} finally 
	{
		try
		{
			if(conn != null)
			{
				conn.close();
				out.print("OK : itbank2 Close<br>");
			}
			
			if(pstmt != null)
			{
				pstmt.close();
			}
		} catch(Exception e)
		{
			
		}
	}
	
	
	RequestDispatcher rd = request.getRequestDispatcher("mysqlList.jsp");
	rd.forward(request, response);
	
%>

</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>