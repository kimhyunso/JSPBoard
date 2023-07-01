<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 지시자 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재 시간 알아보기</title>
</head>
<body>
<%
	GregorianCalendar now = new GregorianCalendar();
	String date = String.format("%TF",now);
	String time = String.format("%TT",now);
	
	Date today = new Date();
%>	 

	today <%=today %><br>
	오늘의 날짜  <%=date %><br>
	현재 시간 <%=time %><br>
	
	call jspInclude.jsp<br>
<%@include file="jspInclude.jsp"%>
	end jspInclude.jsp<br>
	
</body>
</html>