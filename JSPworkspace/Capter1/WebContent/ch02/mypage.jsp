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
	<h3 class="text-primary"><span class="glyphicon glyphicon-cog"></span> 게시판 관리</h3>	
	<div class="row">
		<ul class="pagination">
			<c:if test="${sub eq 1 }">
				<li class="active"><a href="main.jsp?cmd=mypage.jsp?sub=1">내가 쓴 글</a></li>
			</c:if>
			
			<c:if test="${sub ne 1 }">
				<li><a href="main.jsp?cmd=mypage.jsp?sub=1">내가 쓴 글</a></li>
			</c:if>
			
			<c:if test="${sub eq 2 }">
				<li class="active"><a href="main.jsp?cmd=mypage.jsp?sub=2">내 댓글</a></li>
			</c:if>
			
			<c:if test="${sub ne 2 }">
				<li><a href="main.jsp?cmd=mypage.jsp?sub=2">내 댓글</a></li>
			</c:if>
			
			<c:if test="${sub eq 3 }">
				<li class="active"><a href="main.jsp?cmd=mypage.jsp?sub=3">정보 변경</a></li>
			</c:if>
			
			<c:if test="${sub ne 3 }">
				<li><a href="main.jsp?cmd=mypage.jsp?sub=3">정보 변경</a></li>
			</c:if>
			
		</ul>
	</div>
	
	<c:set var="PPG" value="5"/>
	<c:set var="LPP" value="10"/>
	
	<c:if test="${sub eq 1 }">
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select count(*) as totalData, 
			ceil(count(*)/${LPP }) as totalPage, 
			ceil(count(*)/${LPP } / ${PPG }) as totalGroup from bbs where 
				gid in(select distinct gid from bbs where id = '${sessionScope.sessID }') 
					order by gid desc, thread asc
		</sql:query>
		
		<c:forEach var="mybbs" items="${rs.rows}">
			<c:set var="totalData" value="${mybbs.totalData }"/>
			<c:set var="totalPage" value="${mybbs.totalPage }"/>
			<c:set var="totalGroup" value="${mybbs.totalGroup }"/>
		</c:forEach>
		
		
		<c:if test="${empty param.page }">
			<c:set var="page" value="1"/>
		</c:if>
		
		<c:if test="${not empty param.page }">
			<c:set var="page" value="${param.page }"/>
		</c:if>
		
		<c:set var="N">${page }</c:set>
		<c:set var="N" value="${N/PPG }"></c:set>
		<fmt:formatNumber var="group" value="${N+(1-(N%1))%1 }"></fmt:formatNumber>
		
		<c:set var="start" value="${(page-1)*LPP }"></c:set>
		
	
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select * from bbs where 
				gid in(select distinct gid from bbs where id = '${sessionScope.sessID }') 
					order by gid desc, thread asc limit ${start}, ${LPP}
		</sql:query>
		
		<div class="row rowLine">
			<div class="col-md-1 hidden-xs hidden-sm">순서</div>
			<div class="col-md-5 col-xs-6 col-sm-6 ellipsis">제목</div>
			<div class="col-md-2 col-xs-2 col-sm-2 ellipsis">작성자</div>
			<div class="col-md-2 col-xs-2 col-sm-2 ellipsis">작성일</div>
			<div class="col-md-1 col-xs-1 col-sm-1 ellipsis">파일</div>
			<div class="col-md-1 col-xs-1 col-sm-1 ellipsis">조회수</div>
		</div>
		
		<c:forEach var="mybbs" items="${rs.rows}">
		
			<div class="row rowLine">
				<div class="col-md-1 hidden-xs hidden-sm">${mybbs.idx}</div>
				<div class="col-md-5 col-xs-6 col-sm-6 ellipsis">
					
					<c:if test="${fn:length(mybbs.thread) gt 1 }">
						<c:forEach var="i" begin="1" end="${fn:length(mybbs.thread) -1 }" step="1">&nbsp; &nbsp;</c:forEach>
						<span class="glyphicon glyphicon-share-alt"></span>
					</c:if>
					
					<c:if test="${not empty mybbs.head }">
						<span class="label label-success">${mybbs.head }</span>
					</c:if>
					
					<c:if test="${fn:contains(mybbs.time, today) }">
						<span class="label label-danger">N</span>
					</c:if>
					
					<a href="main.jsp?cmd=bbsView?bid=${mybbs.bid }&idx=${mybbs.idx}">${mybbs.title}</a>
				</div>
				<div class="col-md-2 col-xs-2 col-sm-2 ellipsis">${mybbs.writer}</div>
				<div class="col-md-2 col-xs-2 col-sm-2 ellipsis">
				
					<c:if test="${fn:contains(mybbs.time, today) }">
						${fn:substring(mybbs.time, 11, 16) }
					</c:if>
					<c:if test="${fn:contains(mybbs.time, today) eq false }">
						${fn:substring(mybbs.time, 0, 10) }
					</c:if>
				
				</div>
				<div class="col-md-1 col-xs-1 col-sm-1">
					<c:if test="${not empty mybbs.file1 or not empty mybbs.file2 }">
						<span class="glyphicon glyphicon-file"></span>
					</c:if>
				</div>
				<div class="col-md-1 col-xs-1 col-sm-1">${mybbs.hit}</div>
			</div>
			
		</c:forEach>
		
		<c:if test="${totalPage ge 2 }">
			<div class="row text-center">
				<ul class="pagination">
				
					<c:if test="${group gt 2}">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=1"><span class="glyphicon glyphicon-step-backward"></span></a></li>
					</c:if>
					
					<c:if test="${group gt 1}">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=${(group -2)*PPG +1 }"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
					</c:if>
					
					<c:forEach var="p" begin="${(group-1)* PPG + 1 }" end="${group * PPG }">
						<c:if test="${p le totalPage}">
							<c:if test="${p eq page }">
								<li class="active"><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=${p }">${p }</a></li>
							</c:if>
							
							<c:if test="${p ne page }">
								<li><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=${p }">${p }</a></li>
							</c:if>
						</c:if>
					</c:forEach>
					
					<c:if test="${group lt totalGroup}">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${param.sub }&page=${group * PPG+1 }"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
					</c:if>
					
					<c:if test="${group lt totalGroup -1 }">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${param.sub }&page=${(totalGroup-1) * PPG +1 }"><span class="glyphicon glyphicon-step-forward"></span></a></li>
					</c:if>
				</ul>
			</div>
		</c:if>
		
		
	</c:if>
	
	<c:if test="${sub eq 2 }">
	
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select count(*) as totalData, 
			ceil(count(*)/${LPP }) as totalPage, 
			ceil(count(*)/${LPP } / ${PPG }) as totalGroup from bbsmsg where 
				id = '${sessionScope.sessID }'
				order by midx desc
		</sql:query>
		
		<c:forEach var="myMemo" items="${rs.rows}">
			<c:set var="totalData" value="${myMemo.totalData }"/>
			<c:set var="totalPage" value="${myMemo.totalPage }"/>
			<c:set var="totalGroup" value="${myMemo.totalGroup }"/>
		</c:forEach>
		
		
		<c:if test="${empty param.page }">
			<c:set var="page" value="1"/>
		</c:if>
		
		<c:if test="${not empty param.page }">
			<c:set var="page" value="${param.page }"/>
		</c:if>
		
		<c:set var="N">${page }</c:set>
		<c:set var="N" value="${N/PPG }"></c:set>
		<fmt:formatNumber var="group" value="${N+(1-(N%1))%1 }"></fmt:formatNumber>
		<c:set var="start" value="${(page-1)*LPP }"></c:set>
		
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select *, CAST(memo as char(10000) character set utf8) as strMemo from bbsmsg where id = '${sessionScope.sessID}' order by midx desc limit ${start }, ${LPP }
 		</sql:query>
		
		<!-- 순서, 내용-->
		<div class="row rowLine">
			<div class="col-md-1 col-xs-2 col-sm-2">순서</div>
			<div class="col-md-11 col-xs-10 col-sm-10 ellipsis">댓글내용</div>
		</div>		
		
		<c:forEach var="memoRow" items="${rs.rows }">
			<div class="row rowLine">
				<div class="col-md-1 col-xs-2 col-sm-2">${memoRow.midx }</div>
				<div class="col-md-11 col-xs-10 col-sm-10 ellipsis">
					<a href="main.jsp?cmd=bbsView?bid=${memoRow.bid }&idx=${memoRow.bidx}">${memoRow.strMemo }</a>
				</div>
			</div>	
		</c:forEach>
		
		<c:if test="${totalPage ge 2 }">
			<div class="row text-center">
				<ul class="pagination">
				
					<c:if test="${group gt 2}">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=1"><span class="glyphicon glyphicon-step-backward"></span></a></li>
					</c:if>
					
					<c:if test="${group gt 1}">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=${(group -2)*PPG +1 }"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
					</c:if>
					
					<c:forEach var="p" begin="${(group-1)* PPG + 1 }" end="${group * PPG }">
						<c:if test="${p le totalPage}">
							<c:if test="${p eq page }">
								<li class="active"><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=${p }">${p }</a></li>
							</c:if>
							
							<c:if test="${p ne page }">
								<li><a href="main.jsp?cmd=mypage.jsp?sub=${sub }&page=${p }">${p }</a></li>
							</c:if>
						</c:if>
					</c:forEach>
					
					<c:if test="${group lt totalGroup}">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${param.sub }&page=${group * PPG+1 }"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
					</c:if>
					
					<c:if test="${group lt totalGroup -1 }">
						<li><a href="main.jsp?cmd=mypage.jsp?sub=${param.sub }&page=${(totalGroup-1) * PPG +1 }"><span class="glyphicon glyphicon-step-forward"></span></a></li>
					</c:if>
				</ul>
			</div>
		</c:if>
		
	</c:if>
	
	
	<c:if test="${sub eq 3 }">
	
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
			select * from member_table where id = '${sessionScope.sessID}'
		</sql:query>
		
		<c:forEach var="row" items="${rs.rows }">
			<div class="container">
			
				<div class="row rowLine">
					<div class="col-md-12"><h3 class="text-primary"><span class="glyphicon glyphicon-user"></span> <label>회원정보 조회</label></h3></div>
				</div>
				
			<form action="updateMember" method="post" name="memForm">
				<input type="hidden" name="idx" value="${row.idx }">
				<input type="hidden" name="from" value="mypage">
				<input type="hidden" name="level" value="${row.level }">
				
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
						<select class="form-control" disabled style="background-color:#00FF00;">
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
	
	</c:if>
	
	
</div>




