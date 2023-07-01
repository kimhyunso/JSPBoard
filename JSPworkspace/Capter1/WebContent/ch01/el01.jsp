<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");

	int sum = 0;
	
	for(int i=1; i<=100; i++)
		sum = sum + i;
	
	request.setAttribute("resultSum", sum);
	
	RequestDispatcher rd = request.getRequestDispatcher("el02.jsp");
	rd.forward(request, response);
%>






