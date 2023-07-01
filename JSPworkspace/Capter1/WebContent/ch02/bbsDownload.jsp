<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");

	String fileName = request.getParameter("file");
	String saveDir = "ch02/upload/bbs";
	
	ServletContext context = getServletContext();
	String realDir = context.getRealPath(saveDir);
	String filePath = realDir + "/" + fileName;
	
	try {
		out.clear();
		out = pageContext.pushBody();
		
		File file = new File(filePath);
		byte b[] = new byte[4096];
		
		response.reset();
		response.setContentType("application/octet-stream");
		String encoding = java.net.URLEncoder.encode(fileName, "utf-8");
		response.setHeader("Content-Disposition", "attachment; filename="+encoding);
		
		FileInputStream is = new FileInputStream(filePath);
		ServletOutputStream sos = response.getOutputStream();
		
		int numRead;
		while((numRead = is.read(b, 0, b.length)) != -1){
			sos.write(b, 0, numRead);
		}
		
		sos.flush();
		sos.close();
		is.close();
	} catch(Exception e){
		
	}

%>

