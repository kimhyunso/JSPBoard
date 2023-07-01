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


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원정보 조회/변경</title>

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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
//daum객체는 위에서 설정한 라이브러리 안쪽에 들어있다.
function daumZipCode() {
	 new daum.Postcode({
	     oncomplete: function(data) {
	         var fullAddr = ''; // 최종 주소 변수
	         var extraAddr = ''; // 조합형 주소 변수
	        
	         if (data.userSelectedType === 'R') {  //R은 도로명 주소이다.
	             fullAddr = data.roadAddress;
	 
	         } else { // 사용자가 지번 주소를 선택했을 경우(J)
	             fullAddr = data.jibunAddress; //도로명 주소가 아니라면.. 지번주소.
	         }
	 
	         // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	         if(data.userSelectedType === 'R'){
	             //법정동명이 있을 경우 추가한다.
	             if(data.bname !== ''){
	                 extraAddr += data.bname;
	             } //도로명 주소일때는 법에 맞춰서 '동' 이름을 추가해야 한다.
	             
	             
	             // 건물명이 있을 경우 추가한다.
	             if(data.buildingName !== ''){
	                 extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	             }
	             
	             // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	             fullAddr += (extraAddr !== '' ? 
	                     ' ('+ extraAddr +')' : '');
	         }
	 
	         // 우편번호와 주소 정보를 해당 필드에 넣는다.
	         //5자리 새우편번호 사용
	         document.getElementById('zipcode').value = data.zonecode; 
	         document.getElementById('addr1').value = fullAddr; //addr1에 확정된 주소값의 풀네임이 들어간다.
	 
	         // 커서를 상세주소 필드로 이동한다. 
	         // 커서를 이동시켜서 깜빡이게끔 한다.
	         document.getElementById('addr2').focus();
	     }
	 }).open();
}
</script>

<sql:query var="rs" dataSource="jdbc/Capter1">
	select * from member_table where idx = '${param.idx}'
</sql:query>
		
<c:forEach var="row" items="${rs.rows }">
	<div class="container">
	
		<div class="row rowLine">
			<div class="col-md-12"><h3 class="text-primary"><span class="glyphicon glyphicon-user"></span> <label>회원정보 조회</label></h3></div>
		</div>
		
	<form action="updateMember" method="post" name="memForm">
		<input type="hidden" name="idx" value="${param.idx }">
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">아이디</label></div>
			<div class="col-md-10"><input type="text" class="form-control" name="id"  readonly value="${row.id }"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">이름</label></div>
			<div class="col-md-10"><input type="text" class="form-control" name="name" value="${row.name }" placeholder="실명 입력"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-12">비밀번호 변경시에만 비번 변경</div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">비밀번호</label></div>
			<div class="col-md-10"><input type="password" class="form-control" name="pass" placeholder="비밀번호 입력"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">비밀번호 확인</label></div>
			<div class="col-md-10"><input type="password" class="form-control" name="pass2" placeholder="비밀번호 입력 "></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">휴대전화</label></div>
			<div class="col-md-10"><input type="number" class="form-control" name="mobile" placeholder="010-0000-0000" value="${row.mobile }"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">우편번호</label></div>
			<div class="col-md-8 col-sm-9 col-xs-9"><input type="text" class="form-control" name="zipcode" id="zipcode" readonly placeholder="우편 번호" value="${row.zipcode }"></div>
			<div class="col-md-2 col-sm-3 col-xs-3"><button class="btn btn-primary" type="button" onClick="daumZipCode()"><span class="glyphicon glyphicon-search"></span> 검색</button></div>	
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">주소</label></div>
			<div class="col-md-10"><input type="text" class="form-control" readonly name="addr1" id="addr1" placeholder="주소 검색" value="${row.addr1 }"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">상세 주소</label></div>
			<div class="col-md-10"><input type="text" class="form-control" name="addr2" id="addr2" placeholder="상세 주소 입력" value="${row.addr2 }"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">성별</label></div>
			<div class="col-md-10">
				<c:if test="${row.gender eq 2 }">
					<c:set var="checkMark">checked</c:set>
				</c:if>
				
				<input type="radio" name="gender" value="1" checked> <label style="margin-top:5px;">남성</label> &nbsp;
				<input type="radio" name="gender" value="2" ${checkMark} > <label style="margin-top:5px;">여성</label>
			</div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">이메일</label></div>
			<div class="col-md-10"><input type="text" class="form-control" name="email" placeholder="user@com" value="${row.email }"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">생일</label></div>
			<div class="col-md-10"><input type="text" class="form-control" name="birth" placeholder="YYYY-MM-DD"  value="${row.birth }"></div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 hidden-xs hidden-sm"><label style="margin-top:5px;">등급</label></div>
			<div class="col-md-10">
				<select name="level" class="form-control" style="background-color:#00FF00;">
					<sql:query var="rs2" dataSource="jdbc/Capter1">
						select * from leveltable where level <= '${sessionScope.sessLevel}' order by level asc
					</sql:query>
					
					<c:forEach var="row2" items="${rs2.rows }">
						<c:if test="${row.level eq  row2.level}">
							<option selected value="${row2.level }">${row2.title }</option>
						</c:if>
						
						<c:if test="${row.level ne  row2.level}">
							<option value="${row2.level }">${row2.title }</option>
						</c:if>
						
					</c:forEach>
				</select>
			</div>
		</div>
		
		<div class="row rowLine text-center" style="border-bottom:none;">
			<button class="btn btn-danger" type="submit"><span class="glyphicon glyphicon-edit"></span> 회원정보 변경</button>
		</div>
	</form>
		
	</div> <!-- container 끝 -->
</c:forEach>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>