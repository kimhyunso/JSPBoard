<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
	/*
	String cmd = request.getParameter("cmd");
	
	if(cmd == null){
		
		RequestDispatcher rd = request.getRequestDispatcher("main.jsp?cmd=intro.jsp");
		rd.forward(request, response);
	}
	*/
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	String formatToday = dateFormat.format(new Date());
	pageContext.setAttribute("newLine", "\n");
%>
<c:set var="today" scope="request"><%=formatToday %></c:set>

<sql:query var="setupRs" dataSource="jdbc/Capter1">
	select *, CAST(privacy as char(10000) character set utf8) as setupPrivacy,
	CAST(rule as char(10000) character set utf8) as setupRule,
	CAST(css as char(10000) character set utf8) as setupCss,
	CAST(siteinfo as char(10000) character set utf8) as setupSiteinfo
	from setup 
</sql:query>

<c:forEach var="setup" items="${setupRs.rows }">
	<c:set var="setup" value="${setup }" scope="request"/>
</c:forEach>

<c:if test="${empty param.cmd }">
	
</c:if>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>게시판형 홈페이지</title>

    <!-- Bootstrap -->
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="./css/custom2.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  
  <style>
  
  	.rowLine{
  		border-bottom:1px solid #AAAAAA; 
  		padding-top:10px;
  		padding-bottom:10px;
  	}
  	
  	.ellipsis{
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
  	}
  	
  	.myBadge{
  		background-color: #ff0000;
  	}
  	
  	.myCheckbox {
    	width:20px; height:20px;
    }
  	
  </style>
  
  </head>
<body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>

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
        	
        	<c:if test="${empty setup.logo }">
        		<a class="navbar-brand" href="main.jsp"><span class="glyphicon glyphicon-home text-primary"></span></a>
        	</c:if>
        	<c:if test="${not empty setup.logo }">
        		<a class="navbar-brand" href="main.jsp"><img src="./upload/setup/${setup.logo }" alt="logo" width="50px"></a>
        	</c:if>
        	
      	</div>
     
     	 <!-- Collect the nav links, forms, and other content for toggling -->
      	<div class="collapse navbar-collapse navbar-ex1-collapse">
      		<ul class="nav navbar-nav">
      		<!-- <li class="dropdown">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown">게시판 모음<b class="caret"></b></a>
	            <ul class="dropdown-menu">
		            <li><a href="main.jsp?cmd=bbsList?bid=1">자유게시판</a></li>
		            <li><a href="main.jsp?cmd=bbsList?bid=2">공지게시판</a></li>
		            <li><a href="main.jsp?cmd=bbsList?bid=3">질문게시판</a></li>
	        	</ul>
        	</li> -->
        	
	        <sql:query var="rs" dataSource="jdbc/Capter1">
				select * from bbscat where useflag='1' order by odr asc
			</sql:query>
		
			<c:forEach var="row" items="${rs.rows }">
				<li class="dropdown">
	            	<a href="#" class="dropdown-toggle" data-toggle="dropdown">${row.title} <b class="caret"></b></a>
		            <ul class="dropdown-menu">
		            	<sql:query var="rs2" dataSource="jdbc/Capter1">
							select * from bbsmanager where useflag='1' and cat='${row.cidx}' order by odr asc
						</sql:query>
						
						<c:forEach var="row2" items="${rs2.rows }">
							<li><a href="main.jsp?cmd=bbsList?bid=${row2.idx }">${row2.title}</a></li>
						</c:forEach>
		            </ul>
	          	</li>
			</c:forEach>
          	
          	<c:if test="${sessionScope.sessRole eq 'admin' or sessionScope.sessRole eq 'dev' }">
          		<li class="dropdown">
          			<a href="#" class="dropdown-toggle" data-toggle="dropdown">관리자메뉴 <b class="caret"></b></a>
          		<ul class="dropdown-menu">
          			<li><a href="main.jsp?cmd=manBBS.jsp">게시판관리</a></li>
          			<li><a href="main.jsp?cmd=manMember.jsp">회원관리</a></li>
          			<li><a href="main.jsp?cmd=manSetup.jsp">설정관리</a></li>
          			<li><a href="main.jsp?cmd=mypage.jsp">마이페이지</a></li>
          			<li><a href="main.jsp?cmd=manBanner.jsp">배너관리</a></li>
          			<li><a href="main.jsp?cmd=manTest.jsp">테스트</a></li>
          			<c:if test="${sessionScope.sessRole eq 'dev' }">
          				<li><a href="main.jsp?cmd=manLog.jsp">[+] 로그관리</a></li>      			
          			</c:if>
          		</ul>
          		</li>
          	</c:if>
          	
          	<c:if test="${empty sessionScope.sessRole and not empty sessionScope.sessID}">
          		<li class="dropdown">
          			<a href="#" class="dropdown-toggle" data-toggle="dropdown">마이페이지 <b class="caret"></b></a>
          		<ul class="dropdown-menu">
          			<li><a href="main.jsp?cmd=mypage.jsp">게시글 확인</a></li>
          		</ul>
          		</li>
          	</c:if>
          	
          	</ul>
          	
          	<form class="navbar-form navbar-right" role="search" method="post" action="bbsList">
          		<div class="form-group"><input type="text" name="keyword" value="${keyword }" class="form-control" placeholder="검색" required></div>
          		<button type="submit" class="btn btn-default">검색</button>
        	</form>
      </div><!-- /.navbar-collapse -->
      
    </nav>
	
	<div class="row text-right">
		<c:if test="${empty sessionScope.sessID }">
			<form class="form-inline" role="form" action="login" method="post">
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
					<input type="text" name="id" class="form-control" placeholder="아이디 " >
				</div>
				
				<div class="input-group">
					<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
					<input type="password" name="pass" class="form-control" placeholder="비밀번호" >
				</div>
				
				<div class="input-group">
					<button class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-log-in"></span> 로그인</button>
					<button class="btn btn-info" type="button" onClick="location.href='main.jsp?cmd=printJoin.jsp'"><span class="glyphicon glyphicon-link"></span> 회원가입</button>
				</div>
			</form>
		</c:if>		
		
		<c:if test="${not empty sessionScope.sessID }">
			<button class="btn btn-info" disabled type="button"><span class="glyphicon glyphicon-user"></span> ${sessionScope.sessName }님 사용중</button>
			<button class="btn btn-primary" onClick="location.href='logout'"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</button>
		</c:if>
	</div>
	
	<c:if test="${not empty param.cmd }">
		<jsp:include page="${param.cmd }" />
	</c:if>
	
<c:if test="${empty param.cmd }">
		<c:set var="miniBBSLine" value="5" />
		<c:forEach var="cnt" begin="1" end="10" step="1">
			<c:set var="tmp">bbs${cnt }</c:set>
			
			<c:if test="${setup[tmp] ne 0 }">
				<c:if test="${cnt mod 2 eq 1 }">
					<div class="row"></div>
				</c:if>
				
				<sql:query var="manBBSRs" dataSource="jdbc/Capter1">
					select * from bbsmanager where idx = '${setup[tmp] }'
				</sql:query>
				
				<c:forEach var="bbsManager" items="${manBBSRs.rows }">
					<div class="col-md-6 col-xs-6 col-sm-6">
						<div class="row rowLine">
							<div class="col-md-10">
								<h4 class="text-primary"><span class="glyphicon glyphicon-list"></span> ${bbsManager.title}</h4>
							</div>
							<div class="col-md-2">
								<h4 class="text-primary">
									<a href="main.jsp?cmd=bbsList?bid=${bbsManager.idx }"><span class="glyphicon glyphicon-plus"></span></a>
								</h4>
							</div>
						</div>
						
						<sql:query var="miniRs" dataSource="jdbc/Capter1">
							select * from bbs where bid = '${bbsManager.idx }' order by notice desc, idx desc limit ${miniBBSLine }
						</sql:query>
							
						<c:set var="i" value="0" />
						
						<c:forEach var="mini" items="${miniRs.rows }">
							<c:set var="i" value="${i+1 }" />
							<div class="row rowLine">
								<div class="col-md-9 ellipsis">
									<c:if test="${mini.notice eq 1  }">
										<span class="label label-danger">공지</span>
									</c:if>
									<c:if test="${fn:contains(mini.time, today) }">
										<span class="label label-success">N</span>
									</c:if>
									
									<c:if test="${mini.notice ne 1 and (empty sessionScope.sessID or sessionScope.sessLevel lt bssManager.rlevel) }">
										<a href="#" onClick="alert('읽기 권한이 없습니다.');">${mini.title }</a>
										
										<sql:query var="msgRs" dataSource="jdbc/Capter1">
											select count(*) as msgCnt from bbsmsg where bidx='${mini.idx}'
										</sql:query>
										
										<c:forEach var="msgInfo" items="${msgRs.rows }">
											<c:if test="${msgInfo.msgCnt gt 0 }">
												<span class="badge" style="background-color: #008299;">${msgInfo.msgCnt }</span>
											</c:if>	
										</c:forEach>
									
									</c:if>
									
									<c:if test="${(not empty sessionScope.sessLevel and sessionScope.sessLevel ge bbsManager.rlevel) or mini.notice eq 1 }">
										<a href="main.jsp?cmd=bbsView?bid=${mini.bid }&idx=${mini.idx}&sopt=&key=">${mini.title }</a>
										
										<sql:query var="msgRs" dataSource="jdbc/Capter1">
											select count(*) as msgCnt from bbsmsg where bidx='${mini.idx}'
										</sql:query>
										
										
										<c:forEach var="msgInfo" items="${msgRs.rows }">
											<c:if test="${msgInfo.msgCnt gt 0 }">
												<span class="badge" style="background-color: #008299;">${msgInfo.msgCnt }</span>
											</c:if>	
										</c:forEach>
									</c:if>
									
								</div>
								<div class="col-md-3">${mini.writer }</div>
							</div>
						</c:forEach>
						
						<c:forEach var="j" begin="${i+1 }" end="${miniBBSLine }" step="1">
							<div class="row rowLine">
								<div class="col-md-9">&nbsp;</div>
								<div class="col-md-3">&nbsp;</div>
							</div>
						</c:forEach>
						
					</div>
				
				</c:forEach>
				<c:if test="${setup[tmp] ne 0 }">
					<c:if test="${cnt mod 2 eq 0 }">
						<div></div>
						<div class="row">
							&nbsp;
						</div>
					</c:if>				
				</c:if>
				
			</c:if>
		</c:forEach>	
	</c:if>
</div>

	<c:if test="${not empty setup.setupSiteinfo }">
		<div id="wrapper" style="background-size:cover; background-color:#DDDDDD; padding:10px; margin-top:30px;">
			<div class="contanier">
				<c:set var="brSiteInfo">
					${fn:replace(setup.setupSiteinfo, newLine, '<br>') }
				</c:set>
			
				<div class="div text-center">
					${brSiteInfo }
				</div>
			</div>
		</div>
	</c:if>

</body>
</html>