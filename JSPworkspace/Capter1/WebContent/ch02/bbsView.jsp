<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
	
	<sql:query var="bbsRs" dataSource="jdbc/Capter1">
		select *, CAST(css as char(10000) character set utf8) as mycss from bbsmanager where idx = '${param.bid }'
	</sql:query>
	
	<c:forEach var="bbsConf" items="${bbsRs.rows }">
		<c:set var="readLevel">${bbsConf.rlevel}</c:set>
		<c:set var="writeLevel">${bbsConf.wlevel}</c:set>
		<c:set var="mwriteLevel">${bbsConf.mwlevel}</c:set>
		<c:set var="bbscss">${bbsConf.mycss }</c:set>	
		<c:set var="cssleft">${bbsConf.cssleft }</c:set>
		<c:set var="cssright">${bbsConf.cssright }</c:set>
		<c:set var="WYSIWYG">${bbsConf.wysiwyg }</c:set>
	</c:forEach>
	
	<c:if test="${BBSItem.notice ne 1 and (empty sessionScope.sessID or sessionScope.sessLevel lt readLevel) }">
		<script>
			alert('읽기 권한이 없습니다.');
			location.href='main.jsp';
		</script>
	</c:if>

	<header>
		<h2 class="text-primary">
			<span class="glyphicon glyphicon-search"> </span>
			게시물 내용
		</h2>
	</header>
	
	
		
	<div class="row rowLine">
		<div class="col-md-2 col-sm-2 col-xs-2">제목</div>
		<div class="col-md-10 col-xm-10 col-xm-10 ellipsis">
			<c:if test="${BBSItem.notice eq 1 }">
				<span class="label label-danger">공지</span>
			</c:if>
			
			<c:if test="${not empty BBSItem.head}">
				<span class="label label-success">${BBSItem.head }</span>
			</c:if>
		
			<label>${BBSItem.title }</label>
		</div>
	</div>
	
	<div class="row rowLine">
		<div class="col-md-2 col-sm-2 col-xs-2">작성자</div>
		<div class="col-md-10 col-xm-10 col-xm-10">
			<label>${BBSItem.writer }</label>
		</div>
	</div>
	
	<div class="row rowLine">
		<div class="col-md-2 col-sm-2 col-xs-2">작성일</div>
		<div class="col-md-10 col-xm-10 col-xm-10">
			<label>${BBSItem.time }</label>
		</div>
	</div>
	
	<div class="row rowLine">
		<div class="col-md-12" style="min-height:200px;">
		
			<c:if test="${ WYSIWYG eq 1}">
				${BBSItem.html2 }
			</c:if>
			
			<c:if test="${ WYSIWYG ne 1}">
				${BBSItem.html }
			</c:if>
			
			<c:if test="${not empty BBSItem.file1 and not empty ext1 and (ext1 eq 'jpg' or ext1 eq 'jpeg' or ext1 eq 'gif' or ext1 eq 'png')}">
				<br><br>
				<img class="img-responsive" src="upload/bbs/${BBSItem.file1 }">
			</c:if>
			
			<c:if test="${not empty BBSItem.file2 and not empty ext2 and (ext2 eq 'jpg' or ext2 eq 'jpeg' or ext2 eq 'gif' or ext2 eq 'png')}">
				<br><br>
				<img class="img-responsive" src="upload/bbs/${BBSItem.file2 }">
			</c:if>
			
		</div>
	</div>
	
	<c:if test="${not empty BBSItem.file1 }">
		<div class="row rowLine">
			<div class="col-md-12">
				<label>
					<span class="glyphicon glyphicon-paperclip"> </span> 1 :
					
					<a href="bbsDownload.jsp?file=${encodeFile1 }">
						${BBSItem.file1 }
					</a>
				</label>
			</div>
		</div>
	</c:if>
	
	<c:if test="${not empty BBSItem.file2  }">
		<div class="row rowLine">
			<div class="col-md-12">
				<label>
					<span class="glyphicon glyphicon-paperclip"> </span> 2 :
					
					<a href="bbsDownload.jsp?file=${encodeFile2 }">
						${BBSItem.file2 }
					</a>
				</label>
			</div>
		</div>
	</c:if>
	
	<div class="row rowLine">
		<div class="col-md-12">
			<ul class="pager">
				<c:if test="${prev eq 0 }">
					<li class="previous disabled">
						<a href="#"><span class="glyphicon glyphicon-chevron-left"> </span>이전글</a>
					</li>
				</c:if>
				
				<c:if test="${prev ne 0 }">
					<li class="previous">
						<a href="bbsView?bid=${param.bid }&idx=${prev}&sopt=${sopt}&key=${enkey}&keyword=${enKeyword}"><span class="hidden-xs hidden-sm">(${prevTitle })</span><span class="glyphicon glyphicon-chevron-left"> </span>이전글</a>
					</li>
				</c:if>
				
				<c:if test="${next eq 0 }">
					<li class="next disabled">
						<a href="#">다음글<span class="glyphicon glyphicon-chevron-right"> </span></a>
					</li>
				</c:if>
				
				<c:if test="${next ne 0 }">
					<li class="next">
						<a href="bbsView?bid=${param.bid }&idx=${next}&sopt=${sopt}&key=${enkey}&keyword=${enKeyword}">다음글<span class="hidden-xs hidden-sm">(${nextTitle })</span><span class="glyphicon glyphicon-chevron-right"> </span></a>
					</li>
				</c:if>
				
			</ul>
		</div>
	</div>
	
	<div class="row rowLine text-center" >
		<button type="button" class="btn btn-primary" onClick="location.href='main.jsp?cmd=bbsList?bid=${param.bid}'">
			<span class="glyphicon glyphicon-list"> </span> 목록
		</button>
		
		<c:if test="${not empty sessionScope.sessID and sessionScope.sessLevel ge writeLevel }">
			<button type="button" class="btn btn-success" onClick="location.href='main.jsp?cmd=bbsView?bid=${param.bid}&ridx=${param.idx}'">
				<span class="glyphicon glyphicon-share-alt"> </span> 답글
			</button>
		</c:if>
		
		<c:if test="${sessionScope.sessID eq BBSItem.id or sessionScope.sessRole eq 'admin' or sessionScope.sessRole eq 'dev'}">
			
			<script>
				function confirmDelete(pidx)
				{
					if(confirm('정말 삭제하시겠습니까?'))
					{
						location.href='bbsDelete?bid=${param.bid}&didx='+pidx;	
					}
				}
			</script>
			
			<button type="button" class="btn btn-info" onClick="location.href='main.jsp?cmd=bbsView?bid=${param.bid}&uidx=${param.idx}'">
				<span class="glyphicon glyphicon-edit"> </span> 수정
			</button>
		
			<button type="button" class="btn btn-danger" onClick="confirmDelete(${param.idx})">
				<span class="glyphicon glyphicon-remove"> </span> 삭제
			</button>
		</c:if>
	</div>
	
	<c:if test="${sessionScope.sessLevel lt mwriteLevel }">
		<c:set var="disableMark" value="disabled"/>
	</c:if>
	
	<form method="post" action="bbsInsertMemo">
		<input type="hidden" name="bidx" value="${param.idx}">
		<input type="hidden" name="bid" value="${param.bid }">
		
		<div class="row rowLine">
			<div class="col-md-11 col-sm-10 col-xs-10">
				<textArea name="memo" required rows="5" class="form-control" ${disableMark } placeholder="댓글을 입력하세요"></textArea>
			</div>
			<div class="col-md-1 col-sm-2 col-xs-2">
				<button type="submit" class="btn btn-primary" style="height:93px;"><span class="glyphicon glyphicon-edit"></span> 등록</button>
			</div>
		</div>
	</form>
	
	<c:if test="${msgCount ge 1 }">
	
		<script>
			function confirmDeleteMemo(pidx) {
				if(confirm('선택한 댓글을 삭제하시겠습니까?')){
					location.href='bbsDeleteMemo?midx='+pidx+'&bid='+${param.bid}+'&bidx='+${param.idx};
				}
			}
		
		</script>
		
	
		<c:forEach var="cnt" begin="0" end="${msgCount -1 }">
		
			<div class="row rowLine" style="border-bottom: none;">
				<div class="col-md-12">
					작성자 : <b>${msgNameList[cnt] }</b> |
					작성일 : <b>${msgTimeList[cnt] }</b> |
					IP : <b>${msgIpList[cnt] }</b> |
					
					<c:if test="${sessionScope.sessID eq msgIdList[cnt] or sessionScope.sessRole eq 'admin' or sessionScope.sessRole eq 'dev' }">
						<button type="button" class="btn btn-danger btn-xs" onClick="confirmDeleteMemo(${msgMidxList[cnt]});" ><span class="glyphicon glyphicon-remove"></span> 삭제</button>
					</c:if>
					
				</div>			
			</div>
			
			<div class="row rowLine">
				<div class="col-md-12">
					${msgMemoList[cnt] }
				</div>			
			</div>
			
		</c:forEach>		
	</c:if>
	



