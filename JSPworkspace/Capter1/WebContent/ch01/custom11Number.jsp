<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="date" value="<%=new Date() %>"></c:set>

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
    <title>custom03Catch.jsp </title>

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
	
	<h3 class="text-primary">Number Format</h3>
	<h3 class="text-danger">Number Format</h3>
	<h3 class="text-success">Number Format</h3>
	
	<button type="button" class="btn">버튼</button>
	<button type="button" class="btn btn-primary">버튼</button>
	<button type="button" class="btn btn-danger">버튼</button>
	<button type="button" class="btn btn-success">버튼</button>
	
	<label class="label-success">Success</label>
	<label class="label-info">Info</label>
	<label class="label-warning">Warning</label>
	
	<button type="button" class="btn btn-secondary">버튼4</button>
	<button type="button" class="btn btn-dark">버튼4</button>
	<button type="button" class="btn btn-light">버튼4</button>
	
	<button type="button" class="btn btn-primary">버튼</button>
	<button type="button" class="btn btn-primary btn-sm">버튼</button>
	<button type="button" class="btn btn-primary btn-xs">버튼</button>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>대상</th>
				<th>예제</th>
			</tr>		
		</thead>
		
		<tr>
			<td>그룹핑</td>
			<td><fmt:formatNumber value="12345678.91" groupingUsed="true"/></td>
		</tr>
		
		<tr>
			<td>그룹핑</td>
			<td><fmt:formatNumber value="123456782343" groupingUsed="true"/></td>
		</tr>
		
		<tr>
			<td>#.##</td>
			<td><fmt:formatNumber value="3.1415926" pattern="#.##"/></td>
		</tr>
		
		<tr>
			<td>#.##</td>
			<td><fmt:formatNumber value="3.1475926" pattern="#.##"/></td>
		</tr>
		
		<tr>
			<td>#.00</td>
			<td><fmt:formatNumber value="3.1475926" pattern="#.00"/></td>
		</tr>
		
		<tr>
			<td>#.00</td>
			<td><fmt:formatNumber value="3.1" pattern="#.00"/></td>
		</tr>
		
		<tr>
			<td>percent</td>
			<td><fmt:formatNumber value="3.1" type="percent" /></td>
		</tr>
		
		<tr>
			<td>percent</td>
			<td><fmt:formatNumber value="0.76" type="percent"/></td>
		</tr>
		
		<tr>
			<td>달러</td>
			<td><fmt:formatNumber value="123456" type="currency" currencySymbol="$"/></td>
		</tr>
		
		<tr>
			<td>원화</td>
			<td><fmt:formatNumber value="123456" type="currency" currencySymbol="&#8361;"/></td>
		</tr>
		
		<tr>
			<td>유로</td>
			<td><fmt:formatNumber value="123456" type="currency" currencySymbol="&#8364;"/></td>
		</tr>
		
	</table>
</body>
</html>