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
	<h3 class="text-primary"><span class="glyphicon glyphicon-cog"></span> 배너관리</h3>	
	<div class="row">
		<ul class="pagination">
			<c:if test="${sub eq 1 }">
				<li class="active"><a href="main.jsp?cmd=manBanner.jsp?sub=1">배너등록</a></li>
			</c:if>
			
			<c:if test="${sub ne 1 }">
				<li><a href="main.jsp?cmd=manBanner.jsp?sub=1">배너등록</a></li>
			</c:if>
			
			<c:if test="${sub eq 2 }">
				<li class="active"><a href="main.jsp?cmd=manBanner.jsp?sub=2">배너목록</a></li>
			</c:if>
			
			<c:if test="${sub ne 2 }">
				<li><a href="main.jsp?cmd=manBanner.jsp?sub=2">배너목록</a></li>
			</c:if>
							
		</ul>
	</div>
	
	<c:if test="${sub eq 1 }">
		<form method="post" enctype="multipart/form-data" action="insertBanner">
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">제목</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<input type="text" class="form-control" name="title">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">위치</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<select name="pos" class="form-control">
						<option value="1">왼쪽</option>
						<option value="2">오른쪽</option>
						<option value="3">가운데</option>
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">순서</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<input type="text" class="form-control" name="odr" value="1">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">기간</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<input type="text" class="form-control" name="day" value="${today }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">사용여부</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<select name="useflag" class="form-control">
						<option value="1">사용</option>
						<option value="0">------</option>
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">URL</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<input type="text" class="form-control" name="url" >
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">파일</div>
				<div class="col-md-10 col-sm-10 col-xs-10">
					<input type="file" class="form-control" name="upfile1" >
				</div>
			</div>
			
			<div class="row rowLine text-center" style="border-bottom: none;">
				<button class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-pencil"></span> 등록</button>
			</div>
		</form>
	</c:if>
	
	
	<c:if test="${sub eq 2 }">
	
	
	</c:if>
	
	
</div>




