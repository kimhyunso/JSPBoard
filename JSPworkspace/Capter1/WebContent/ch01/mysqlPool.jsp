<%@page import="org.apache.commons.dbcp2.PoolingDriver"%>
<%@page import="org.apache.commons.dbcp2.PoolableConnection"%>
<%@page import="org.apache.commons.pool2.impl.GenericObjectPool"%>
<%@page import="org.apache.commons.pool2.impl.GenericObjectPoolConfig"%>
<%@page import="org.apache.commons.dbcp2.PoolableConnectionFactory"%>
<%@page import="org.apache.commons.dbcp2.DriverManagerConnectionFactory"%>
<%@page import="org.apache.commons.dbcp2.ConnectionFactory"%>
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
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
			
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<body>

<style>
	.songLine{
		border-bottom:1px solid #AAAAAA;
	}
</style>

<%
	
	final String POOL_NAME = "/itbank2_pool";
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(
			"jdbc:mysql://localhost:3306/itbank2?characterEncoding=utf-8",
			"itbank2","itbank2pass"
		);
		
		PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(connectionFactory,null);
		
		GenericObjectPoolConfig objectPoolConfig = new GenericObjectPoolConfig();
		objectPoolConfig.setTimeBetweenEvictionRunsMillis(1000L * 60L *5L); //5분
		objectPoolConfig.setTestWhileIdle(true);
		objectPoolConfig.setMinIdle(4);
		objectPoolConfig.setMaxTotal(50);
		
		GenericObjectPool<PoolableConnection> objectPool = new GenericObjectPool<PoolableConnection>(
				poolableConnectionFactory,objectPoolConfig);
		
		PoolingDriver poolingDriver = new PoolingDriver();
		poolingDriver.registerPool(POOL_NAME,objectPool);
		
		Class.forName("org.apache.commons.dbcp2.PoolingDriver");
		//커넥션 목록 출력
		PoolingDriver driver = (PoolingDriver)DriverManager.getDriver("jdbc:apache:commons:dbcp:mysql");
		
		String[] names = driver.getPoolNames();
		for(int cnt=0; cnt<names.length; cnt++){
			out.print(cnt+" : "+names[cnt]+"<br>");			
		}
		
		out.print(poolingDriver.toString() + " is Created !!<br>");
	
		String sql = "select *from members";
		conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/itbank2_pool");
		
		pstmt = conn.prepareStatement(sql);	
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			out.print("idx = "+rs.getInt("idx") + ", ");
			out.print("id = "+rs.getString("id") + ", ");
			out.print("name = "+rs.getString("name") + ", ");
			out.print("mobile = "+rs.getInt("mobile") + ", ");
			out.print("addr = "+rs.getString("addr") + "<br><br>");
		}
		
	}catch(Exception e){
		out.print("Exception : "+e.getMessage());		
	}
	
%>


<div class="container">
	<header>
		<h2 class="text-primary">MySql Connection Pool</h2>
	</header>
	
	커넥션 풀 이름 : <%=POOL_NAME %>
</div>

<script src="./js/bootstrap.min.js"></script>	
</body>
</html>