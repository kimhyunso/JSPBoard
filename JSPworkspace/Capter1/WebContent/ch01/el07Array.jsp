<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	String[] winners = new String[3];
	winners[0] = "홍길동";
	winners[1] = "테스트";
	winners[2] = "HongJilDong";
	
	request.setAttribute("WINNERS",winners);
	RequestDispatcher rd = request.getRequestDispatcher("el08.jsp");
	rd.forward(request, response);
%>



