<%@page import="java.util.HashMap"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	
	// map = key, value 값으로 구성된 자료구조
	HashMap<String,String> protocol = new HashMap<String,String>();
	
	protocol.put("TCP","Transmission Control Protocol");
	protocol.put("UDP","User Datagram Protocol");
	protocol.put("HTTP","Hyper Text Transfer Protocol");
	protocol.put("FTP","File Transfer Protocol");
	
	request.setAttribute("protocols",protocol);
	RequestDispatcher rd = request.getRequestDispatcher("el12.jsp?protocol=HTTP");
	rd.forward(request, response);
%>



