<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
var confirmID = "undefined"; 
var confirmPass = "undefined";
var ID;
var PASS;

$(document).ready(function () {
    $("#btnID").click(function() {
    	var jsonText = JSON.stringify({'id':$('#id').val()});
    	
    	if($('#id').val() == null || $('#id').val() == ''){
    		$("#userInfo").addClass('text text-danger');
			$("#userInfo").html('아이디를 입력해주세요.');  
			confirmID = "undefined"; 
    		return;
    	}
    	
    	var pattern = /\s/g;
    	var korean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    	var pattern2 = /[~!@#$%^&*()_+|<>?:{}]/;
    	
    	if(korean.test($('#id').val()) || $('#id').val().match(pattern) || $('#id').val().match(pattern2)){
    		$("#userInfo").addClass('text text-danger');
    		$("#userInfo").html('다시 입력해주세요.'); 
    		confirmID = "undefined"; 
    		return;
    	}
    	
    	 $.ajax({
         	type: 'POST',
         	data: jsonText,
         	headers: {'Content-Type': 'application/json;charset=utf-8'},
            url : "checkID",
            dataType : "json",
            success : function(data) {
            	var test = JSON.stringify(data);
            	if(JSON.parse(test).resultMsg == 'success'){
            		$("#userInfo").addClass('text text-success');
					$("#userInfo").html('사용가능합니다.');
					confirmID = 'success';
					ID = $('#id').val();
            	}
            	
            	if(JSON.parse(test).resultMsg == 'undefined'){
            		$("#userInfo").addClass('text text-danger');
					$("#userInfo").html('사용중인 아이디입니다.');    
					confirmID = 'undefined';
            	}
            },
          	error : function(error) {
          		alert("error : " + error);
          		confirmID = 'error';
          	}
       });
    });
    
    
    
    $('#passConfirm').keyup(function (){
    	if($('#pass').val() == $('#passConfirm').val()){
    		confirmPass = 'success';
    	}else{
    		confirmPass = 'undefind';
    	}	
    });


    $('#pass').blur(function(){
    	PASS = $('#pass').val();
    });
    
    
}); 



function check(){
	
	if(PASS != $('#passConfirm').val()){
		alert('비밀번호를 확인 해주세요!');
		return false;
	}else if(ID != $('#id').val()){
		alert('아이디 중복확인을 해주세요!');
		return false;
	}else if(confirmPass == 'success' && confirmID == 'success'){
		return true;
	}else if(confirmPass != 'success'){
		alert('비밀번호를 확인해주세요.');
		return false;
	}else if(confirmID != 'success'){
		alert('아이디를 확인해주세요.');
		return false;
	}
	
}


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

<style>
	.mymargin{
		margin-top:10px;
	}
</style>

<div class="container">
	<div class="row">
		<h3 class="text-primary"><span class="glyphicon glyphicon-link"></span> <label>회원가입</label></h3>
	</div>
	
	<form action="join" method="post" name="joinForm" onSubmit="return check();">
	
	<div class="row">
		<div class="col-md-12"><b>아이디</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-9 col-sm-9 col-xs-9"><input type="text" class="form-control" name="id" id="id" placeholder="영문(대문자 사용금지), 숫자포함 4-10자 이내" required></div>
		<div class="col-md-3 col-sm-3 col-xs-3"><button class="btn btn-default" type="button" id="btnID">중복확인</button></div>
	</div>
	
	<div class="row">
		<div class="col-md-12 text-left">
			<label id="userInfo"></label>
			&nbsp; &nbsp; &nbsp;
		</div>
	</div>


	<div class="row">
		<div class="col-md-12"><b>비밀번호</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="password" id="pass" name="pass" class="form-control" placeholder="4-10자의 영문, 특수문자, 숫자" required></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="password" id="passConfirm" class="form-control" placeholder="비밀번호 확인" required></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><b>이름</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="text" class="form-control" name="name" placeholder="실명 입력"></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><b>휴대전화</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="number" class="form-control" name="mobile" placeholder="010-0000-0000"></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><b>우편번호</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-9 col-sm-9 col-xs-9"><input type="text" class="form-control" name="zipcode" id="zipcode" readonly placeholder="우편 번호"></div>
		<div class="col-md-3 col-sm-3 col-xs-3"><button class="btn btn-default" type="button" onClick="daumZipCode()"><span class="glyphicon glyphicon-search"></span> 검색</button></div>	
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><b>주소</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="text" class="form-control" readonly name="addr1" id="addr1" placeholder="주소 검색"></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><b>상세주소</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="text" class="form-control" name="addr2" id="addr2" placeholder="상세 주소 입력"></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><b>성별</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12">
			<input type="radio" name="gender" value="1" > <label style="margin-top:5px;">남성</label> &nbsp;
			<input type="radio" name="gender" value="2" checked> <label style="margin-top:5px;">여성</label>
		</div>
	</div>
	
	
	<div class="row mymargin">
		<div class="col-md-12"><b>이메일</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="text" class="form-control" name="email" placeholder="user@com"></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><b>생일</b></div>
	</div>
	
	<div class="row mymargin">
		<div class="col-md-12"><input type="text" class="form-control" name="birth" placeholder="YYYY-MM-DD"></div>
	</div>
	
	<div class="row rowLine">
		<div class="col-md-12 col-xs-12 col-sm-12"><label style="margin-bottom:5px;">이용약관</label>
		 	<textarea rows="10" class="form-control">${setup.setupRule }</textarea>
		 	<input type="checkbox" name="okRule"> 이용약관에 동의합니다.
		</div>
	</div>
	
	<div class="row rowLine">
		<div class="col-md-12 col-xs-12 col-sm-12"><label style="margin-bottom:5px;">개인정보 보호정책</label>
		 	<textarea rows="10" class="form-control">${setup.setupPrivacy }</textarea>
		 	<input type="checkbox" name="okPrivacy"> 개인정보 보호정책에 동의합니다.
		</div>
	</div>
	
	<div class="row rowLine text-center" style="border-bottom:none;">
		<button class="btn btn-success" type="submit"><span class="glyphicon glyphicon-edit"></span> 회원가입</button>
	</div>
	
	</form>
</div>    
    
