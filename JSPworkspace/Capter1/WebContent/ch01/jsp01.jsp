<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int sum = 0;
	for(int i=1; i<=10; i++){
		sum+=i;
	}

	out.print("sum = "+sum+"<br>");
%>

	다시 HTML 영역으로 돌아왔습니다.<br>
	합 = <%=sum %>


</body>
</html>