<%@page import="javax.naming.*"%>
<%@page import="javax.sql.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

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
    <title>MySQL Pool</title>

    <!-- Bootstrap -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/custom2.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  
  <style>
  	.rowLine{
  		border-bottom:1px dashed #AAAAAA; 
  	}
  	
  	.ellipsis{
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
  	}
  </style>
  
  </head>
<body>

<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		Context initContext = new InitialContext();
		Context envContext = (Context) initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource) envContext.lookup("jdbc/itbank2_pool");
		
		conn = ds.getConnection();
		String sql = "select * from members";
		pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			out.print("Name : " + rs.getString("name") + ",");
			out.print("Mobile : " + rs.getString("mobile") + "<br>");
			
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
	}catch(Exception e)
	{
		out.print("Error :" + e.getMessage() + "<br>");
	}

%>

<div class="container">
	<header>
		<h2 class="text-primary">MySql Connection Pool</h2>
	</header>
	<!-- text는 font색상 변경 label은 배경 색상 변경 -->
	
	<sql:query var="rs" dataSource="jdbc/itbank2_pool">
		select *from members
	</sql:query>
	
	<c:forEach var="row" items="${rs.rows }">
		<div class="row rowLine">
			<div class="col-md-2 hidden-sm hidden-xs">
				<c:if test="${row.idx mod 2 eq 0 }">
					<span class="text text-danger">${row.idx }</span>				
				</c:if>	
				
				<c:if test="${row.idx mod 2 ne 0 }">
					<span class="text text-success">${row.idx }</span>				
				</c:if>	
			</div>
			
			<div class="col-md-3 col-sm-3 col-xs-3">${row.name }</div>
			
			<div class="col-md-2 col-sm-3 col-xs-3 ellipsis">${row.mobile }</div>
			
			<div class="col-md-2 col-sm-3 col-xs-3">
				<c:choose>
					<c:when test="${row.addr eq '서울' }">
						<h4><label class="label label-primary">${row.addr }</label></h4>
					</c:when>
					
					<c:otherwise>
						<h4><label class="label label-danger">${row.addr }</label></h4>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="col-md-3">
				<button type="button" class="btn btn-primary btn-sm">
					<span class="glyphicon glyphicon-pencil"> 버튼</span>
				</button>
			</div>
			
		</div>
	</c:forEach>
	
	<div class="row rowLine text-right">
		<button type="button" class="btn btn-success" onclick="location.href='mysqlSelectPool2.jsp'">
			<span class="glyphicon glyphicon-link"></span> Go To Servlet 
		</button>				
	</div>
	
</div>
<script src="./js/bootstrap.min.js"></script>
	
</body>
</html>