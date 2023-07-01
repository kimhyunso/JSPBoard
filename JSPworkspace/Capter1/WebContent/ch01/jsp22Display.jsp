<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
여기는 display입니다.<br>
한글이 안 깨져야 합니다.<br>
<%
	String myName = request.getParameter("myName");
	String tel = request.getParameter("myTel");
%>

display name = <%=myName %><br>
display tel = <%=tel %>

여기는 display의 끝입니다.<br>