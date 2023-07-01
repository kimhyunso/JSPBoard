<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	ArrayList<String> list = new ArrayList<String>();
	
	list.add("홍길동");
	list.add("알파고");
	list.add("테스트");
	list.add("이순신");
	list.add("광개토");
	
	list.remove(1);
	list.set(2,"박보검");
	
	request.setAttribute("size",list.size());
	request.setAttribute("WINNERS",list);
	RequestDispatcher rd = request.getRequestDispatcher("el10.jsp");
	rd.forward(request, response);
%>



