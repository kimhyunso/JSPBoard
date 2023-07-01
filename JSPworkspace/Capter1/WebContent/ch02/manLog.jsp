<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>

<c:if test="${empty param.sub }">
	<c:set var="sub">1</c:set>
</c:if>
<c:if test="${not empty param.sub }">
	<c:set var="sub">${param.sub}</c:set>
</c:if>

<div class="container">
	
	<script>
		function confirmDelete(didx){
			if(confirm('정말 삭제하시겠습니까?')){
				location.href='deleteLog?didx='+didx;
			}
		}
	</script>

	
	<h3 class="text-primary"><span class="glyphicon glyphicon-cog"></span> 로그관리</h3>


	<c:set var="PPG" value="5"/>
	<c:set var="LPP" value="30"/>

	<sql:query var="rs" dataSource="jdbc/Capter1">
		select count(*) as totalData, 
		ceil(count(*)/${LPP }) as totalPage, 
		ceil(count(*)/${LPP } / ${PPG }) as totalGroup from log
	</sql:query>

	<c:forEach var="myLog" items="${rs.rows}">
		<c:set var="totalData" value="${myLog.totalData }" />
		<c:set var="totalPage" value="${myLog.totalPage }" />
		<c:set var="totalGroup" value="${myLog.totalGroup }" />
	</c:forEach>


	<c:if test="${empty param.page }">
		<c:set var="page" value="1" />
	</c:if>

	<c:if test="${not empty param.page }">
		<c:set var="page" value="${param.page }" />
	</c:if>

	<c:set var="N">${page }</c:set>
	<c:set var="N" value="${N/PPG }"></c:set>
	<fmt:formatNumber var="group" value="${N+(1-(N%1))%1 }"></fmt:formatNumber>
	<c:set var="start" value="${(page-1)*LPP }"></c:set>
	
	<sql:query var="rsLog" dataSource="jdbc/Capter1">
		select *,
		 CAST(memo1 as char(10000) character set utf8) as strMemo1, 
		 CAST(memo2 as char(10000) character set utf8) as strMemo2
		 from log limit ${start }, ${LPP }
	</sql:query>
	
	<!-- 순서, 제목, 이름, 언제, 비고 -->
	
	<div class="row rowLine">
		<div class="col-md-1 hidden-xs hidden-sm">순서</div>
		<div class="col-md-5 col-xs-7 col-sm-7">제목</div>
		<div class="col-md-1 col-xs-2 col-sm-2 ellipsis">이름</div>
		<div class="col-md-2 hidden-xs hidden-sm">시간</div>
		<div class="col-md-1 hidden-xs hidden-sm">IP</div>
		<div class="col-md-2 col-xs-3 col-sm-3">비고</div>
	</div>
	
	<c:forEach var="logInfo" items="${rsLog.rows }">
		<div class="row rowLine">
			<div class="col-md-1 hidden-xs hidden-sm">${logInfo.idx }</div>
			<div class="col-md-5 col-xs-7 col-sm-7 ellipsis">${logInfo.title }</div>
			<div class="col-md-1 col-xs-2 col-sm-2">${logInfo.name }</div>
			<div class="col-md-2 hidden-xs hidden-sm">
			
				<c:if test="${fn:contains(logInfo.time, today) }">
					${fn:substring(logInfo.time, 11, 16) }
				</c:if>
				<c:if test="${fn:contains(logInfo.time, today) eq false }">
					${fn:substring(logInfo.time, 0, 10) }
				</c:if>
				
			</div>
			<div class="col-md-1 hidden-xs hidden-sm">${logInfo.ip }</div>
			<div class="col-md-2 col-xs-3 col-sm-3">
				<button type="button" class="btn btn-info btn-xs" onClick="window.open('logView.jsp?idx=${logInfo.idx}','LOGINFO','resizable=yes scrollbars=yes width=800 height=600')"><span class="glyphicon glyphicon-search"></span> 상세</button>
				<button type="button" class="btn btn-danger btn-xs" onClick="confirmDelete(${logInfo.idx});"><span class="glyphicon glyphicon-remove"></span> 삭제</button>
			</div>
		</div>
	</c:forEach>
	
	<c:if test="${totalPage ge 2 }">
		<div class="row text-center">
			<ul class="pagination">

				<c:if test="${group gt 2}">
					<li><a href="main.jsp?cmd=manLog.jsp?page=1"><span class="glyphicon glyphicon-step-backward"></span></a></li>
				</c:if>

				<c:if test="${group gt 1}">
					<li><a href="main.jsp?cmd=manLog.jsp?page=${(group -2)*PPG +1 }"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
				</c:if>

				<c:forEach var="p" begin="${(group-1)* PPG + 1 }" end="${group * PPG }">
					<c:if test="${p le totalPage}">
						<c:if test="${p eq page }">
							<li class="active"><a href="main.jsp?cmd=manLog.jsp?page=${p }">${p }</a></li>
						</c:if>

						<c:if test="${p ne page }">
							<li><a href="main.jsp?cmd=manLog.jsp?page=${p }">${p }</a></li>
						</c:if>
					</c:if>
				</c:forEach>

				<c:if test="${group lt totalGroup}">
					<li><a href="main.jsp?cmd=manLog.jsp?page=${group * PPG+1 }"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
				</c:if>

				<c:if test="${group lt totalGroup -1 }">
					<li><a href="main.jsp?cmd=manLog.jsp?page=${(totalGroup-1) * PPG +1 }"><span class="glyphicon glyphicon-step-forward"></span></a></li>
				</c:if>
			</ul>
		</div>
	</c:if>

</div>



