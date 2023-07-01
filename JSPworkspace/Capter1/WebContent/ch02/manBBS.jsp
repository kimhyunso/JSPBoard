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
				<li class="active"><a href="main.jsp?cmd=manBBS.jsp?sub=1">새글목록</a></li>
			</c:if>
			
			<c:if test="${sub ne 1 }">
				<li><a href="main.jsp?cmd=manBBS.jsp?sub=1">새글목록</a></li>
			</c:if>
			
			<c:if test="${sub eq 2 }">
				<li class="active"><a href="main.jsp?cmd=manBBS.jsp?sub=2">게시판 분류</a></li>
			</c:if>
			
			<c:if test="${sub ne 2 }">
				<li><a href="main.jsp?cmd=manBBS.jsp?sub=2">게시판 분류</a></li>
			</c:if>
			
			<c:if test="${sub eq 3 }">
				<li class="active"><a href="main.jsp?cmd=manBBS.jsp?sub=3">게시판 등록</a></li>
			</c:if>
			
			<c:if test="${sub ne 3 }">
				<li><a href="main.jsp?cmd=manBBS.jsp?sub=3">게시판 등록</a></li>
			</c:if>
			
			<c:if test="${sub eq 4 }">
				<li class="active"><a href="main.jsp?cmd=manBBS.jsp?sub=4">게시판 목록</a></li>
			</c:if>
			
			<c:if test="${sub ne 4 }">
				<li><a href="main.jsp?cmd=manBBS.jsp?sub=4">게시판 목록</a></li>
			</c:if>
			
			<c:if test="${sub eq 5 }">
				<li class="active"><a href="main.jsp?cmd=manBBS.jsp?sub=5">댓글 목록</a></li>
			</c:if>
			
			<c:if test="${sub ne 5 }">
				<li><a href="main.jsp?cmd=manBBS.jsp?sub=5">댓글 목록</a></li>
			</c:if>
		</ul>
	</div>
	
	<c:if test="${sub eq 1 }">
		<div class="row rowLine">
			<div class="col-md-1">순서</div>
			<div class="col-md-1">머릿글</div> 
			<div class="col-md-5">제목</div> 
			<div class="col-md-1">작성자</div> 
			<div class="col-md-1">파일</div> 
			<div class="col-md-2">작성일</div> 
			<div class="col-md-1">조회수</div> 		
		</div>
		
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select count(*) as bbsCount from bbs
		</sql:query>
		
		<c:forEach var="row" items="${rs.rows }">
			<c:set var="totalDataCount">${row.bbsCount }</c:set>
			<c:set var="N">${row.bbsCount }</c:set>
			<c:set var="N" value="${N/10 }"></c:set>
			<fmt:formatNumber var="maxPage" value="${N+(1-(N%1))%1 }"></fmt:formatNumber>
		</c:forEach>
		
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select *from bbs order by idx desc limit 20
		</sql:query>
	
		<c:forEach var="row" items="${rs.rows }">
			<div class="row rowLine">
				<div class="col-md-1">
					<c:if test="${row.notice eq 1 }">
						<span class="label label-danger">공지</span>
					</c:if>
					<c:if test="${row.notice ne 1 }">
						${row.idx }
					</c:if>
				</div>
				<div class="col-md-1">${row.head }</div> 
				<div class="col-md-5 ellipsis">
					<c:if test="${fn:contains(row.time, today) }">
						<span class="label label-success">New</span>
					</c:if>
					${row.title }
				</div> 
				<div class="col-md-1">${row.writer }</div> 
				<div class="col-md-1 ellipsis">${row.file1 }</div> 
				<div class="col-md-2">
					<c:if test="${fn:contains(row.time, today) }">
						${fn:substring(row.time, 11, 16) }
					</c:if>
						
					<c:if test="${fn:contains(row.time, today) eq false }">
						${fn:substring(row.time, 0, 10) }
					</c:if>
				</div> 
				
				<div class="col-md-1">${row.hit }</div> 		
			</div>
		</c:forEach>
		
		<div class="row text-center">
			<ul class="pagination">
				<c:forEach var="p" begin="1" end="${maxPage }">
					<c:if test="${p eq page }">
						<li class="active"><a href="main.jsp?cmd=bbsList?page=${p }&bid=${param.bid}">${p }</a></li>
					</c:if>

					<c:if test="${p ne page }">
						<li><a href="main.jsp?cmd=bbsList?page=${p }&bid=${param.bid}">${p }</a></li>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		
	</c:if>
	
	<c:if test="${sub eq 2 }">
		<h3 class="text-primary"><span class="glyphicon glyphicon-list"></span> 게시판 분류</h3>
		
		<form class="form" method="post" action="bbsInsertCategroy">
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-2 text-right">분류명</div>
				<div class="col-md-10"><input type="text" name="title" class="form-control" required placeholder="분류명 입력"></div>
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
				<div class="col-md-2 text-right">배치순서</div>
				<div class="col-md-10"><input type="number" name="odr" class="form-control" required placeholder="배치순서 입력" value="1"></div>
			</div>
			
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-12 text-right"><button type="submit" class="btn btn-primary">분류 등록</button></div>
			</div>
		</form> 
		
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select *from bbscat order by odr asc
		</sql:query>
		
		<div class="row rowLine">
			<div class="col-md-2 col-sm-2 col-xs-2">순서</div>
			<div class="col-md-4 col-sm-4 col-xs-4">제목</div>
			<div class="col-md-3 col-sm-3 col-xs-3">표시</div>
			<div class="col-md-3 col-sm-3 col-xs-3">비고</div>
		</div>
		
		<c:forEach var="row" items="${rs.rows }">
			<form class="form" method="post" action="bbsUpdateCategroy">
				<input type="hidden" name="cidx" value="${row.cidx }">
				
				<div class="row rowLine">
					<div class="col-md-2 col-sm-2 col-xs-2"><input type="number" name="odr" class="form-control" value="${row.odr }"></div>
					<div class="col-md-4 col-sm-4 col-xs-4"><input type="text" name="title" class="form-control" value="${row.title }"></div>
					<div class="col-md-3 col-sm-3 col-xs-3">
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
					<div class="col-md-3 col-sm-3 col-xs-3"><button type="submit" class="btn btn-primary btn-sm">변경</button></div>
				</div>
			</form>
		</c:forEach>
		
	</c:if>
	
	
	<c:if test="${sub eq 3 }">
		<c:if test="${not empty param.idx }">
			<h3 class="text-danger"><span class="glyphicon glyphicon-refresh"></span> 게시판변경</h3>
			
			<sql:query var="rsOrg" dataSource="jdbc/Capter1">
				select *, CAST(css as char(10000) character set utf8) as mycss from bbsmanager where idx = '${param.idx}'
			</sql:query>
			
			<c:forEach var="org" items="${rsOrg.rows }">
				<c:set var="cat" value="${org.cat }"/>
				<c:set var="title" value="${org.title }"/>
				<c:set var="rlevel" value="${org.rlevel }"/>
				<c:set var="wlevel" value="${org.wlevel }"/>
				<c:set var="mwlevel" value="${org.mwlevel }"/>
				<c:set var="downlevel" value="${org.downlevel }"/>
				<c:set var="heads" value="${org.heads }"/>
				<c:set var="odr" value="${org.odr }"/>
				<c:set var="manager" value="${org.manager }"/>
				<c:set var="lpp" value="${org.lpp }"/>
				<c:set var="useflag" value="${org.useflag }"/>
				<c:set var="filecount" value="${org.filecount }"/>
				<c:set var="ext" value="${org.ext }"/>
				<c:set var="css" value="${org.mycss }"/>
				<c:set var="cssno" value="${org.cssno }"/>
				<c:set var="csshead" value="${org.csshead }"/>
				<c:set var="csstitle" value="${org.csstitle }"/>
				<c:set var="csswriter" value="${org.csswriter }"/>
				<c:set var="cssfile" value="${org.cssfile }"/>
				<c:set var="csstime" value="${org.csstime }"/>
				<c:set var="csshit" value="${org.csshit }"/>
				<c:set var="cssleft" value="${org.cssleft }"/>
				<c:set var="cssright" value="${org.cssright }"/>
				<c:set var="uplogo" value="${org.uplogo }"/>
				<c:set var="downlogo" value="${org.downlogo }"/>
				<c:set var="wysiwyg" value="${org.wysiwyg }"/>
				<c:set var="isdft" value="${org.isdft }"/>
			</c:forEach>
			
			<c:set var="nextUrl" value="bbsUpdateManager" />
		</c:if>
		
		<c:if test="${empty param.idx }">
			<h3 class="text-primary"><span class="glyphicon glyphicon-pencil"></span> 게시판등록</h3>
			<c:set var="nextUrl" value="bbsInsertManager" />
		</c:if>
		
			
		
		
		<script>
			function setDefaultSetup(){
				var f = document.manForm;
				f.cat.value = "1";
				f.useflag.value = "1";
				f.odr.value = "1";
				f.rlevel.value = "1";
				f.wlevel.value = "1";
				f.mwlevel.value = "1";
				f.downlevel.value = "1";
				f.heads.value = '질문, 답변, 정보, 기타';
				f.filecount.value = '2';
				f.ext.value = 'jpg,jpeg,gif,png';
				f.lpp.value = '15';
				
				f.cssno.value = 'col-md-1 hidden-xs hidden-sm';
				f.csshead.value = 'col-md-1 hidden-xs hidden-sm';
				f.csstitle.value = 'col-md-4 col-xs-9 col-sm-9 ellipsis';
				f.csswriter.value = 'col-md-2 col-xs-3 col-sm-3 ellipsis';
				f.cssfile.value = 'col-md-1 hidden-xs hidden-sm';
				f.csstime.value = 'col-md-2 hidden-xs hidden-sm';
				f.csshit.value = 'col-md-1 hidden-xs hidden-sm';
				
				f.cssleft.value = 'col-md-2 col-sm-2 col-xs-2';
				f.cssright.value = 'col-md-10 col-xm-10 col-xm-10';
			}
		
		</script>
		
		<form method="post" name="manForm" class="form" enctype="multipart/form-data" action="${nextUrl }">
		<c:if test="${not empty param.idx }">
			<input type="hidden" name="uidx" value="${param.idx }">
		</c:if>
		
		
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">분류</div>
				<div class="col-md-10">
					<select name="cat" class="form-control">
						<option value="0">=== 분류 선택 ===</option>
						
						<sql:query var="rs" dataSource="jdbc/Capter1">
							select *from bbscat order by title asc
						</sql:query>
						
						<c:forEach var="row" items="${rs.rows }">
							<c:if test="${cat eq row.cidx }">
								<option value="${row.cidx }" selected>${row.title }</option>
							</c:if>
							
							<c:if test="${cat ne row.cidx }">
								<option value="${row.cidx }">${row.title }</option>
							</c:if>
						</c:forEach>
						
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">명칭</div>
				<div class="col-md-10">
					<input type="text" class="form-control" value="${title }" required name="title" placeholder="게시판 명칭">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">사용여부</div>
				<div class="col-md-10">
					
					<select name="useflag" class="form-control">
						<option value="1">사용</option>
						
						<c:if test="${useflag ne 1}">
							<option value="${useflag }" selected>------</option>
						</c:if>
								
						<c:if test="${useflag eq 1}">
							<option value="0">------</option>
						</c:if>
						
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">관리자</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="manager" placeholder="관리자1, 관리자2" value="${manager }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">배치순서</div>
				<div class="col-md-10">
					<input type="number" class="form-control" name="odr" value="${odr }" placeholder="배치 순서">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">읽기</div>
				<div class="col-md-10">
					<select name="rlevel" class="form-control">
						<option value="0">=== 읽기 권한 ===</option>
						<sql:query var="rs" dataSource="jdbc/Capter1">
							select *from leveltable order by level asc
						</sql:query>
						
						<c:forEach var="row" items="${rs.rows }">
							<c:if test="${rlevel eq row.level }">
								<option value="${row.level }" selected>${row.title }</option>
							</c:if>
							
							<c:if test="${rlevel ne row.level }">
								<option value="${row.level }">${row.title }</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">쓰기</div>
				<div class="col-md-10">
					<select name="wlevel" class="form-control">
						<option value="0">=== 쓰기 권한 ===</option>
						<sql:query var="rs" dataSource="jdbc/Capter1">
							select *from leveltable order by level asc
						</sql:query>
						
						<sql:query var="rs" dataSource="jdbc/Capter1">
							select *from leveltable order by level asc
						</sql:query>
						
						<c:forEach var="row" items="${rs.rows }">
							<c:if test="${wlevel eq row.level }">
								<option value="${row.level }" selected>${row.title }</option>
							</c:if>
							
							<c:if test="${wlevel ne row.level }">
								<option value="${row.level }">${row.title }</option>
							</c:if>
						</c:forEach>
						
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">댓글</div>
				<div class="col-md-10">
					<select name="mwlevel" class="form-control">
						<option value="0">=== 댓글 권한 ===</option>
						<sql:query var="rs" dataSource="jdbc/Capter1">
							select *from leveltable order by level asc
						</sql:query>
						
						<c:forEach var="row" items="${rs.rows }">
							<c:if test="${mwlevel eq row.level }">
								<option value="${row.level }" selected>${row.title }</option>
							</c:if>
							
							<c:if test="${mwlevel ne row.level }">
								<option value="${row.level }">${row.title }</option>
							</c:if>
						</c:forEach>
						
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">다운</div>
				<div class="col-md-10">
					<select name="downlevel" class="form-control">
						<option value="0">=== 다운 권한 ===</option>
						<sql:query var="rs" dataSource="jdbc/Capter1">
							select *from leveltable order by level asc
						</sql:query>
						
						<c:forEach var="row" items="${rs.rows }">
							<c:if test="${downlevel eq row.level }">
								<option value="${row.level }" selected>${row.title }</option>
							</c:if>
							
							<c:if test="${downlevel ne row.level }">
								<option value="${row.level }">${row.title }</option>
							</c:if>
						</c:forEach>
					</select>
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">머리글</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="heads" placeholder="머리글1, 머리글2" value="${heads }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">LPP(라인 수)</div>
				<div class="col-md-10">
					<input type="number" maxlength="2" class="form-control" name="lpp" placeholder="목록 라인 수" value="${lpp }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">첨부갯수</div>
				<div class="col-md-10">
					<input type="number" class="form-control" name="filecount" maxlength="1" placeholder="첨부 파일 수" value="${filecount }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">파일종류</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="ext" placeholder="jpg, jpeg, png, gif" value="${ext }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS</div>
				<div class="col-md-10">
					<textarea rows="7" name="css" class="form-control"><c:if test="${not empty css }">${css }</c:if></textarea>
				</div>
			</div>
			
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 머리글</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="csshead" placeholder="CSS 머리글" value="${csshead }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 순서</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="cssno" placeholder="CSS 순서" value="${cssno }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 제목</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="csstitle" placeholder="CSS 제목" value="${csstitle }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 작성자</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="csswriter" placeholder="CSS 작성자" value="${csswriter }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 첨부</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="cssfile" placeholder="CSS 첨부" value="${cssfile }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 시간</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="csstime" placeholder="CSS 시간" value="${csstime }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 조회수</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="csshit" placeholder="CSS 조회수" value="${csshit }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 좌측</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="cssleft" placeholder="CSS 왼쪽" value="${cssleft }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">CSS 우측</div>
				<div class="col-md-10">
					<input type="text" class="form-control" name="cssright" placeholder="CSS 오른쪽" value="${cssright }">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">WSIWYG</div>
				<div class="col-md-10">
							
					<select name="wysiwyg" class="form-control">
						<option value="0">------</option>
						
						<c:if test="${empty wysiwyg}">
							<option value="1">WSIWYG</option>
						</c:if>
						
						<c:if test="${not empty wysiwyg and wysiwyg eq 1}">
							<option value="1" selected>WSIWYG</option>
						</c:if>
						
						<c:if test="${not empty wysiwyg and wysiwyg ne 1}">
							<option value="1">WSIWYG</option>
						</c:if>
						
					</select>
				</div>
			</div>
			
			
			<div class="row rowLine">
				<div class="col-md-2 hidden-xs hidden-sm">기본 설정</div>
				<div class="col-md-10">
					<select name="isdft" class="form-control">
						<option value="0">------</option>
						
						<c:if test="${empty isdft}">
							<option value="1">기준게시판</option>
						</c:if>
						
						<c:if test="${not empty isdft and isdft eq 1}">
							<option value="1" selected>기준게시판</option>
						</c:if>
						
						<c:if test="${not empty isdft and isdft ne 1}">
							<option value="1">기준게시판</option>
						</c:if>
						
					</select>
				</div>
			</div>
			
			
			<div class="row rowLine">
				<div class="col-md-12"><span class="glyphicon glyphicon-paperclip"></span> 상단
					<c:if test="${not empty uplogo }">
						( <input type="checkbox" name="delFile1"> 삭제 )
						${uplogo }
					</c:if>
					
					<input type="file" class="form-control" name="upfile1" placeholder="상단 로고">
				</div>
			</div>
			
			<div class="row rowLine">
				<div class="col-md-12"><span class="glyphicon glyphicon-paperclip"></span> 하단
					<c:if test="${not empty downlogo }">
						( <input type="checkbox" name="delFile2"> 삭제 )
						${downlogo }
					</c:if>
					
					<input type="file" class="form-control" name="upfile2" placeholder="하단 로고">
				</div>
			</div>
			
			<div class="row rowLine" style="border-bottom:none;">
				<div class="col-md-6 col-sm-6 col-xs-6 text-left">
					<c:if test="${empty param.idx }">
						<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> 등록</button>	
					</c:if>
					
					<c:if test="${not empty param.idx }">
						<button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-refresh"></span> 변경</button>	
					</c:if>
				</div>
				
				<div class="col-md-6 col-sm-6 col-xs-6 text-right">
					<button type="button" class="btn btn-info" onClick="setDefaultSetup();"><span class="glyphicon glyphicon-cog"></span> 기본값</button>	
				</div>					
			</div>
			
		</form>		
	</c:if>
	
	<c:if test="${sub eq 4 }">
		<h4 class="text-primary"><span class="glyphicon glyphicon-list"></span> 게시판 목록</h4>
		
		
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select * from bbsmanager order by title asc
		</sql:query>
		
		<div class="row rowLine">
			<div class="col-md-1 hidden-xs hidden-sm">순서</div>	
			<div class="col-md-3 hidden-sm hidden-xs">분류</div>
			<div class="col-md-3 col-sm-5 col-xs-5">제목</div>
			<div class="col-md-1 col-sm-2 col-xs-2">읽기</div>
			<div class="col-md-1 col-sm-2 col-xs-2">쓰기</div>
			<div class="col-md-1 col-sm-1 col-xs-1">사용</div>
			<div class="col-md-1 hidden-xs hidden-sm">기본</div>	
			<div class="col-md-1 col-sm-2 col-xs-2">비고</div>	
		</div>
						
		<c:forEach var="row" items="${rs.rows }">
			<div class="row rowLine">
				<div class="col-md-1 hidden-xs hidden-sm">${row.idx }</div>	
				<div class="col-md-3 hidden-sm hidden-xs">
					<sql:query var="rs1" dataSource="jdbc/Capter1">
						select * from bbscat where cidx = '${row.cat }'
					</sql:query>
					<c:forEach var="row1" items="${rs1.rows }">
						${row1.title }					
					</c:forEach>
				</div>
				<div class="col-md-3 col-sm-5 col-xs-5">${row.title }</div>
				<div class="col-md-1 col-sm-2 col-xs-2">
					<sql:query var="rs1" dataSource="jdbc/Capter1">
						select * from leveltable where level = '${row.rlevel }'
					</sql:query>
					<c:forEach var="row1" items="${rs1.rows }">
						${row1.title }					
					</c:forEach>				
				</div>
				<div class="col-md-1 col-sm-2 col-xs-2">
					<sql:query var="rs1" dataSource="jdbc/Capter1">
						select * from leveltable where level = '${row.wlevel }'
					</sql:query>
					<c:forEach var="row1" items="${rs1.rows }">
						${row1.title }					
					</c:forEach>
				</div>
				<div class="col-md-1 col-sm-1 col-xs-1">
					<c:if test="${row.useflag eq 1 }">Y</c:if>
					<c:if test="${row.useflag ne 1 }">-</c:if>
				</div>
				
				<div class="col-md-1 hidden-xs hidden-sm">
					<c:if test="${row.useflag eq 1 }">Y</c:if>
					<c:if test="${row.useflag ne 1 }">-</c:if>
				</div>	
				
				<div class="col-md-1 col-sm-2 col-xs-2">
					<button type="button" class="btn btn-primary btn-sm" onClick="location.href='main.jsp?cmd=manBBS.jsp?sub=3&idx=${row.idx}'"><span class="glyphicon glyphicon-refresh"></span> 변경</button>
				</div>	
			</div>
		</c:forEach>
		
	</c:if>
	
	<c:set var="PPG" value="5"/>
	<c:set var="LPP" value="10"/>
	
	<c:if test="${sub eq 5 }">
		<sql:query var="rs" dataSource="jdbc/Capter1">
			select count(*) as totalData, 
			ceil(count(*)/${LPP }) as totalPage, 
			ceil(count(*)/${LPP } / ${PPG }) as totalGroup from bbsmsg 
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
			select *, CAST(memo as char(10000) character set utf8) as strMemo from bbsmsg  order by midx desc limit ${start }, ${LPP }
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
						<li><a href="main.jsp?cmd=manBBS.jsp?sub=${sub }&page=1"><span class="glyphicon glyphicon-step-backward"></span></a></li>
					</c:if>
					
					<c:if test="${group gt 1}">
						<li><a href="main.jsp?cmd=manBBS.jsp?sub=${sub }&page=${(group -2)*PPG +1 }"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
					</c:if>
					
					<c:forEach var="p" begin="${(group-1)* PPG + 1 }" end="${group * PPG }">
						<c:if test="${p le totalPage}">
							<c:if test="${p eq page }">
								<li class="active"><a href="main.jsp?cmd=manBBS.jsp?sub=${sub }&page=${p }">${p }</a></li>
							</c:if>
							
							<c:if test="${p ne page }">
								<li><a href="main.jsp?cmd=manBBS.jsp?sub=${sub }&page=${p }">${p }</a></li>
							</c:if>
						</c:if>
					</c:forEach>
					
					<c:if test="${group lt totalGroup}">
						<li><a href="main.jsp?cmd=manBBS.jsp?sub=${param.sub }&page=${group * PPG+1 }"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
					</c:if>
					
					<c:if test="${group lt totalGroup -1 }">
						<li><a href="main.jsp?cmd=manBBS.jsp?sub=${param.sub }&page=${(totalGroup-1) * PPG +1 }"><span class="glyphicon glyphicon-step-forward"></span></a></li>
					</c:if>
				</ul>
			</div>
		</c:if>
	</c:if>
	
</div>




