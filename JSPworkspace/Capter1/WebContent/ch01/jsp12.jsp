<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	int age = Integer.parseInt(request.getParameter("age"));
	age = age + 1;

	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String type = request.getParameter("type");
	String memo = request.getParameter("memo");
	
	request.setAttribute("name","변경된 이름 "+name);
	request.setAttribute("age","내년의 나이는 "+age);
	request.setAttribute("newType",type);
	
	RequestDispatcher rd = request.getRequestDispatcher("jsp13.jsp");
	rd.forward(request, response);
%>    

