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

<script>

$(document).ready(function () {
    $("#btnID").click(function() {
    	var jsonText = JSON.stringify({'id':$('#id').val()});
    	 $.ajax({
         	type: 'POST',
         	data: jsonText,
         	headers: {'Content-Type': 'application/json;charset=utf-8'},
            url : "checkID",
            dataType : "json",
            success : function(data) {
            	var test = JSON.stringify(data);
            	if(JSON.parse(test).resultMsg == 'success'){
            		$("#userInfo").css('color','#FF0000');
					$("#userInfo").html('사용가능합니다.');            		
            	}
            },
          	error : function(error) {
          		alert("error : " + error);
          	}
       });
    });
}); 
 
</script>

<h4 class="text-primary"><span class="glyphicon glyphicon-user"></span> <b>회원정보입력</b></h4>

<div class="row">
	<div class="col-md-12">아이디</div>
</div>

<div class="row">
	<div class="col-md-9 col-sm-9 col-xs-9"><input type="text" class="form-control" name="id" id="id" placeholder="영문(대문자 사용금지), 숫자포함 4-10자 이내" required></div>
	<div class="col-md-3 col-sm-3 col-xs-3"><button class="btn btn-default" type="button" id="btnID">중복확인</button></div>
</div>


<div class="row">
	<div class="col-md-12 text-left">
		<span id="userInfo"></span>
		&nbsp; &nbsp; &nbsp;
	</div>
</div>


<div class="row">
	<div class="col-md-12">비밀번호</div>
</div>

<div class="row">
	<div class="col-md-12"><input type="password" class="form-control" placeholder="4-10자의 영문, 특수문자, 숫자" required></div>
</div>

<div class="row">
	<div class="col-md-12"><input type="password" class="form-control" placeholder="비밀번호 확인" required></div>
</div>









