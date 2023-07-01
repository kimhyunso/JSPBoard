<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="jsp20Conf.jsp" %>
    
<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>    
    
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=homePageName %></title>

    <!-- Bootstrap -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/custom2.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<body>

<div class="container">

	<header>
		<h2>파일 포함시키기(Include)</h2>
	</header>
	
	<p>
		설정값 확인 <br>
		conf_sess_id = <%=conf_sess_id %><br>	
	</p>
	
	jsp22Display.jsp 포함하고 싶은 경우<br>
	
	<%
		String yourName = "홍길동";
	%>
	
	<jsp:include page="jsp22Display.jsp">
		<jsp:param value="홍길동" name="myName"/>
		<jsp:param value="010-1111-2222" name="myTel"/>
	</jsp:include>
	
	<p>
		main의 하단부입니다.
	</p>

</div>

	<script src="./js/bootstrap.min.js"></script>
</body>
</html>