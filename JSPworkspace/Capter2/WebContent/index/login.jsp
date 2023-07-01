<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>


<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>

<div class="container">

	<form action="login" method="post">
		<div class="row">
			<div class="input-group">
				<input type="text" class="form-control" placeholder="아이디" name="id" required>
			</div>
			<div class="input-group">
				<input type="password" class="form-control" placeholder="비밀번호" name="pass" required>
			</div>
			
		</div>
		
		<div class="row">
			<button class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-log-in"></span> 로그인</button>
		</div>
	</form>
</div>








