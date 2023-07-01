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
	<h3 class="text-primary"><span class="glyphicon glyphicon-cog"></span> 설정관리</h3>	
	<div class="row">
		<ul class="pagination">
			<c:if test="${sub eq 1 }">
				<li class="active"><a href="main.jsp?cmd=manSetup.jsp?sub=1">기본설정</a></li>
			</c:if>
			
			<c:if test="${sub ne 1 }">
				<li><a href="main.jsp?cmd=manSetup.jsp?sub=1">기본설정</a></li>
			</c:if>
			
			<c:if test="${sub eq 2 }">
				<li class="active"><a href="main.jsp?cmd=manSetup.jsp?sub=2">회원관리</a></li>
			</c:if>
			
			<c:if test="${sub ne 2 }">
				<li><a href="main.jsp?cmd=manSetup.jsp?sub=2">회원관리</a></li>
			</c:if>
			
			<c:if test="${sub eq 3 }">
				<li class="active"><a href="main.jsp?cmd=manSetup.jsp?sub=3">rs1</a></li>
			</c:if>
			
			<c:if test="${sub ne 3 }">
				<li><a href="main.jsp?cmd=manSetup.jsp?sub=3">rs1</a></li>
			</c:if>
			
			<c:if test="${sub eq 4 }">
				<li class="active"><a href="main.jsp?cmd=manSetup.jsp?sub=4">rs2</a></li>
			</c:if>
			
			<c:if test="${sub ne 4 }">
				<li><a href="main.jsp?cmd=manSetup.jsp?sub=4">rs3</a></li>
			</c:if>
			
			<c:if test="${sub eq 5 }">
				<li class="active"><a href="main.jsp?cmd=manSetup.jsp?sub=5">rs4</a></li>
			</c:if>
			
			<c:if test="${sub ne 5 }">
				<li><a href="main.jsp?cmd=manSetup.jsp?sub=5">rs4</a></li>
			</c:if>
			
			
		</ul>
	</div>
	
	<c:if test="${sub eq 1 }">
		<h4 class="text-primary"><span class="glyphicon glyphicon-cog"></span> 기본 설정</h4>
		<form method="post" action="updateSetup" enctype="multipart/form-data">
		
		<div class="row rowLine">
			<div class="col-md-12 col-xs-12 col-sm-12">
			로고
			<c:if test="${not empty setup.logo}">
				( <input type="checkbox" name="delFile1" > 삭제 )
				${setup.logo }
			</c:if>
			
			<input type="file" class="form-control" name="upfile1">
			</div>		
		</div>
		
		<c:forEach var="cnt" begin="1" end="10" step="1">
			<c:set var="tmp">bbs${cnt }</c:set>
		
			<div class="row rowLine">
				<div class="col-md-2 col-xs-2 col-sm-2">게시판 ${cnt }</div>
				<div class="col-md-10 col-xs-10 col-sm-10">
					<select name="bbs${cnt }" class="form-control">
						<option value="0">===${cnt } 번째 게시판===</option>
						<sql:query var="bbsRs" dataSource="jdbc/Capter1">
							select * from bbsmanager where useflag = '1' order by title asc
						</sql:query>
									
						
						<c:forEach var="bbsData" items="${bbsRs.rows }">
							<c:if test="${bbsData.idx eq setup[tmp] }">
								<option value="${bbsData.idx }" selected>${bbsData.title }</option>
							</c:if>
							
							<c:if test="${bbsData.idx ne setup[tmp] }">
								<option value="${bbsData.idx }">${bbsData.title }</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
		</c:forEach>
		
		<div class="row rowLine">
			<div class="col-md-2 col-xs-2 col-sm-2">
				사이트정보
			</div>		
			<div class="col-md-10 col-xs-10 col-sm-10">
				<textarea name="siteinfo" class="form-control" rows="7">${setup.setupSiteinfo }</textarea>			
			</div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 col-xs-2 col-sm-2">
				CSS
			</div>		
			<div class="col-md-10 col-xs-10 col-sm-10">
				<textarea name="css" class="form-control" rows="7">${setup.setupCss }</textarea>			
			</div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 col-xs-2 col-sm-2">
				개인보호정책
			</div>		
			<div class="col-md-10 col-xs-10 col-sm-10">
				<textarea name="privacy" class="form-control" rows="7">${setup.setupPrivacy }</textarea>			
			</div>
		</div>
		
		<div class="row rowLine">
			<div class="col-md-2 col-xs-2 col-sm-2">
				이용약관
			</div>		
			<div class="col-md-10 col-xs-10 col-sm-10">
				<textarea name="rule" class="form-control" rows="7">${setup.setupRule }</textarea>			
			</div>
		</div>
		
		<div class="row rowLine text-center" style="border-bottom:none;">
			<button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-refresh"></span> 설정 변경</button>		
		</div>
		</form>
		
	</c:if>
	
	<c:if test="${sub eq 2 }">
		<h3 class="text-primary"><span class="glyphicon glyphicon-list"></span> 회원 분류</h3>
		
		<form class="form" method="post" action="bbsInsertMember">
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-2 text-right">분류명</div>
				<div class="col-md-10"><input type="text" name="title" class="form-control" required placeholder="분류명 입력"></div>
			</div>
			
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-2 text-right">레벨번호</div>
				<div class="col-md-10"><input type="number" name="level" value="1" class="form-control" required placeholder="회원 레벨 ex)1.정회원"></div>
			</div>
			
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-2 text-right">사용여부</div>
				<div class="col-md-10">
					<select name="useflag" class="form-control">
						<option value="1">사용</option>
						<option value="0">---------</option>
					</select>
				</div>
			</div>
			
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-2 text-right">관리자</div>
				<div class="col-md-10">
					<select name="isadmin" class="form-control">
						<option value="0">---------</option>
						<option value="1">관리자</option>
					</select>
				</div>
			</div>
			
			<c:if test="${sessionScope.sessRole eq 'dev' }">
				<div class="row rowLine" style="border-bottom:none;">
					<div class="col-md-2 text-right">개발자</div>
					<div class="col-md-10">
						<select name="isdev" class="form-control">
							<option value="0">---------</option>
							<option value="1">개발자</option>
						</select>
					</div>
				</div>
			</c:if>
			
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-12 text-right"><button type="submit" class="btn btn-primary">회원 등록</button></div>
			</div>
		</form> 
		
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select *from leveltable where level <= '${sessionScope.sessLevel }' order by level asc
		</sql:query>
		
		
		<c:if test="${sessionScope.sessRole eq 'dev' }">
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">레벨</div>
				<div class="col-md-2 col-sm-2 col-xs-2">제목</div>
				<div class="col-md-2 col-sm-2 col-xs-2">표시</div>
				<div class="col-md-2 col-sm-2 col-xs-2">관리</div>
				<div class="col-md-2 col-sm-2 col-xs-2">개발</div>
				<div class="col-md-2 col-sm-2 col-xs-2">비고</div>
			</div>
		</c:if>
		
		<c:if test="${sessionScope.sessRole ne 'dev' }">
			<div class="row rowLine">
				<div class="col-md-2 col-sm-2 col-xs-2">레벨</div>
				<div class="col-md-3 col-sm-3 col-xs-3">제목</div>
				<div class="col-md-2 col-sm-2 col-xs-2">표시</div>
				<div class="col-md-3 col-sm-3 col-xs-3">관리</div>
				<div class="col-md-2 col-sm-2 col-xs-2">비고</div>
			</div>
		</c:if>
		
		<script>
			function confirmDeleteLevel(pidx){
				if(confirm('레벨을 삭제하시겠습니까?')){
					location.href='bbsDeleteMember?didx='+pidx;					
				}				
			}
		</script>
		
		
		
		<c:forEach var="row" items="${rs.rows }">
			<form class="form" method="post" action="bbsUpdateMember">
				<input type="hidden" name="idx" value="${row.idx }">
				
				<div class="row rowLine">
					<div class="col-md-2 col-sm-2 col-xs-2"><input type="number" name="level" class="form-control" value="${row.level }"></div>
					
					<c:if test="${sessionScope.sessRole eq 'dev' }">
						<div class="col-md-2 col-sm-2 col-xs-2"><input type="text" name="title" class="form-control" value="${row.title }"></div>
					</c:if>
					
					<c:if test="${sessionScope.sessRole ne 'dev' }">
						<div class="col-md-3 col-sm-3 col-xs-3"><input type="text" name="title" class="form-control" value="${row.title }"></div>
					</c:if>
					
					
					<div class="col-md-2 col-sm-2 col-xs-2">
						<select name="useflag" class="form-control">
							<option value="1">사용</option>
							
							<c:if test="${row.useflag eq 0 }">
								<option value="0" selected>------</option>
							</c:if>
							
							<c:if test="${row.useflag ne 0 }">
								<option value="0">------</option>
							</c:if>
						</select>
					</div>
					
					<c:if test="${sessionScope.sessRole eq 'dev' }">
						<div class="col-md-2 col-sm-2 col-xs-2">
							<select name="isadmin" class="form-control">
								<option value="0">-------</option>
								
								<c:if test="${row.isadmin eq 1 }">
									<option value="1" selected>관리자</option>
								</c:if>
								
								<c:if test="${row.isadmin ne 1 }">
									<option value="1">관리자</option>
								</c:if>
							</select>
						</div>
					</c:if>
					
					<c:if test="${sessionScope.sessRole ne 'dev' }">
						<div class="col-md-3 col-sm-3 col-xs-3">
							<select name="isadmin" class="form-control">
								<option value="0">-------</option>
								
								<c:if test="${row.isadmin eq 1 }">
									<option value="1" selected>관리자</option>
								</c:if>
								
								<c:if test="${row.isadmin ne 1 }">
									<option value="1">관리자</option>
								</c:if>
							</select>
						</div>
					</c:if>
					
					
					<c:if test="${sessionScope.sessRole eq 'dev' }">
						<div class="col-md-2 col-sm-2 col-xs-2">
							<select name="isdev" class="form-control">
								<option value="0">-------</option>
								
								<c:if test="${row.isdev eq 1 }">
									<option value="1" selected>개발자</option>
								</c:if>
								
								<c:if test="${row.isdev ne 1 }">
									<option value="1">개발자</option>
								</c:if>
							</select>
						</div>
					</c:if>
					
					<div class="col-md-2 col-sm-2 col-xs-2">
						<button type="submit" class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-refresh"></span> 변경</button>
						<button type="button" onClick="confirmDeleteLevel(${row.idx});" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-remove-circle"></span> 삭제</button>
					</div>
				</div>
			</form>
		</c:forEach>
		
	</c:if>
	
	<c:if test="${sub eq 3 }">
		3번 메뉴 처리
	</c:if>
	
	<c:if test="${sub eq 4 }">
		4번 메뉴 처리
	</c:if>
	
	<c:if test="${sub eq 5 }">
		5번 메뉴 처리
	</c:if>
	
</div>




