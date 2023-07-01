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

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible"  content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>게시판형 홈페이지</title>

    <!-- Bootstrap -->
    <link href="./css/mycss.css" rel="stylesheet">
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/custom2.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  </head>
<body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>

<c:if test="${not empty resultMsg }">
	<script>
		alert('${resultMsg}');
	</script>
</c:if>

<div class="container">  
    <nav class="navbar navbar-default" role="navigation">
      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="main.jsp">
        	<span class="glyphicon glyphicon-home text-primary"> </span>
        </a>
      </div>
     
      <!-- Collect the nav links, forms, and other content for toggling -->
      <div class="collapse navbar-collapse navbar-ex1-collapse">
        <ul class="nav navbar-nav">
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">게시판 모음 <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="main.jsp?cmd=bbsList">자유게시판</a></li>
              <li><a href="#">공지게시판</a></li>
              <li><a href="#">질문게시판</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">메뉴 2 <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="#">서브메뉴 1</a></li>
              <li><a href="#">서브메뉴 2</a></li>
              <li><a href="#">서브메뉴 3</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">메뉴 3 <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="#">서브메뉴 1</a></li>
              <li><a href="#">서브메뉴 2</a></li>
              <li><a href="#">서브메뉴 3</a></li>
            </ul>
          </li>
        </ul>
        <form class="navbar-form navbar-right">
         	<div class="input-group">
         	
         		<c:if test="${empty sessionScope.sessID }">
					<button class="btn btn-default" type="button" onClick="location.href='main.jsp?cmd=login.jsp'"><span class="glyphicon glyphicon-log-in"></span> 로그인</button>
					<button class="btn btn-info" type="button" onClick="location.href='main.jsp?cmd=signUp.jsp'"><span class="glyphicon glyphicon-link"></span> 회원가입</button>
         		</c:if>
         		
         		<c:if test="${not empty sessionScope.sessID }">
	         		<span class="glyphicon glyphicon-user"></span> <b class="text text-info">${sessionScope.sessName}님</b>
					<button class="btn btn-info" type="button" onClick="location.href='logout'"><span class="glyphicon glyphicon-link"></span> 로그아웃</button>
         		</c:if>
			</div>
        </form>

      </div><!-- /.navbar-collapse -->
      
    </nav>
    
	<jsp:include page="${param.cmd }" />

</div> <!-- container 끝 -->

	
</body>
</html>





