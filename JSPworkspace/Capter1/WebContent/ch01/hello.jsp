<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	hello JSP world2 <br>
	헬로우 JSP 2<br>
	
<%
	int sum = 0;
	for(int i=1; i<=100; i++){
		sum += i;
		out.print("현재 값 : "+i+"<br>");
		
	}
	
	out.print("합계 = " + sum);
%>

</body>
</html>