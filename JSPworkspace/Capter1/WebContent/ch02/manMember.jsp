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
%>

<c:if test="${sessionScope.sessRole ne 'admin' and sessionScope.sessRole ne 'dev' }">
	<script>
		alert('잘못된 접근입니다.');
		location.href='main.jsp';
	</script>
</c:if>

<c:if test="${empty param.page }">
	<c:set var="page" value="1"/>
</c:if>

<c:if test="${not empty param.page }">
	<c:set var="page" value="${param.page }"/>
</c:if>

<c:if test="${empty param.sub }">
	<c:set var="sub" value="1"/>
</c:if>

<c:if test="${not empty param.sub }">
	<c:set var="sub" value="${param.sub }"/>
</c:if>

<div class="container">
	<div class="row">
		<div class="col-md-12"><h3 class="text-primary"><span class="glyphicon glyphicon-user"></span> 회원관리</h3></div>
	</div>
	
	
	<div class="row">
		<ul class="pagination">
			<sql:query var="rs" dataSource="jdbc/Capter1">
				select * from leveltable where level<='${sessionScope.sessLevel }' order by level asc
			</sql:query>
			
			<c:forEach var="row" items="${rs.rows }">
			
				<sql:query var="rs2" dataSource="jdbc/Capter1">
					select count(*) as memcnt from member_table where level = '${row.level }'
				</sql:query>
			
				<c:forEach var="row2" items="${rs2.rows }">
					<c:if test="${row2.memcnt gt 0 }">
						<c:set var="countMark"><span class="label label-danger">${row2.memcnt }</span></c:set>					
					</c:if>
					
					<c:if test="${row2.memcnt eq 0 }">
						<c:set var="countMark"></c:set>	
					</c:if>					
				</c:forEach>
				<c:if test="${row.level eq sub }">
					<li class="active"><a href="main.jsp?cmd=manMember.jsp?sub=${row.level }">${row.title }</a></li>
				</c:if>
				
				<c:if test="${row.level ne sub }">
					<li><a href="main.jsp?cmd=manMember.jsp?sub=${row.level }">${row.title } ${countMark }</a></li>
				</c:if>
			</c:forEach>
		</ul>
	</div>
	
	<br><br>
	<c:if test="${not empty sub }">
		<c:set var="LPP">10</c:set>
		
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select count(*) as memcnt, ceil(count(*) / ${LPP }) as pages from member_table where level = '${sub }'
		</sql:query>
		
		<c:forEach var="row" items="${rs.rows }">
			<c:set var="maxData">${row.memcnt }</c:set>
			<c:set var="maxPage">${row.pages }</c:set>
		</c:forEach>
		
		<c:set var="start">${(page-1)*LPP}</c:set>
	
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select * from member_table where level='${sub}' order by name asc limit ${start }, ${LPP }
		</sql:query>
		
		<div class="row rowLine">
			<div class="col-md-1 hidden-sm hidden-xs">순서</div>
			<div class="col-md-2 col-sm-3 col-xs-3 ellipsis">이름</div>
			<div class="col-md-2 col-sm-2 col-xs-2 ellipsis">아이디</div>
			<div class="col-md-3 col-sm-3 col-xs-3 ellipsis">전화번호</div>
			<div class="col-md-2 col-sm-2 col-xs-2 ellipsis">가입일</div>
			<div class="col-md-2 col-sm-2 col-xs-2 ellipsis">비고</div>
		</div>

		<c:set var="cnt" value="0" />

		<c:forEach var="row" items="${rs.rows }">
		
			<c:set var="cnt" value="${cnt + 1 }" />
			<div class="row rowLine">
				<div class="col-md-1 hidden-sm hidden-xs">${cnt }</div>
				<div class="col-md-2 col-sm-3 col-xs-3 ellipsis">${row.name }</div>
				<div class="col-md-2 col-sm-2 col-xs-2 ellipsis">${row.id }</div>
				<div class="col-md-3 col-sm-3 col-xs-3 ellipsis">${row.mobile }</div>
				<div class="col-md-2 col-sm-2 col-xs-2 ellipsis">${row.regdate }</div>
				<div class="col-md-2 col-sm-2 col-xs-2 ellipsis">
				<button type="button" class="btn btn-primary btn-xs" onClick="window.open('showMember.jsp?idx=${row.idx}','MemberWIN','resizable=yes scrollbars=yes width=500 height=500')"><span class="glyphicon glyphicon-zoom-in"></span> 상세</button></div>
			</div>
		</c:forEach>
		
		<div class="row text-center" style="margin-top:10px;">
			<ul class="pagination">
				<c:forEach var="p" begin="1" end="${maxPage }" step="1">
					<c:if test="${p eq page }">
						<li class="active"><a href="main.jsp?cmd=manMember.jsp?sub=${sub }&page=${p}">${p }</a></li>
					</c:if>
					
					<c:if test="${p ne page }">
						<li><a href="main.jsp?cmd=manMember.jsp?sub=${sub }&page=${p}">${p }</a></li>
					</c:if>
				</c:forEach>			
			</ul>
		</div>		
		
	</c:if>
</div>
