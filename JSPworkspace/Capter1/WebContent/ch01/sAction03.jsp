<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
%>

	<jsp:useBean class="kr.co.itbank.network.Car" id="texi" scope="request"/>
	<jsp:setProperty property="speed" name="texi" value="77" />
	<jsp:setProperty property="color" name="texi" value="RED"/>
	<jsp:forward page="sAction04.jsp"></jsp:forward>