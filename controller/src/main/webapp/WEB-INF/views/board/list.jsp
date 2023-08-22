<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#modal{
		width:100%;
		height:100vh;
		position:absolute;
		top:0;
		left:0;
		background:rgba(0,0,0,0.5);
		display:none;
	}
	#modalbox{
		width:70%;
		background: #fff;
		margin: 20px auto;
		padding:20px;
		border-radius:10px;	
	}
</style>
</head>
<body>
	<h1>리스트페이지</h1>
	<table>
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>수정일</td>
		</tr>
		<c:forEach items="${list }" var="board">
			<tr>
				<td><c:out value="${board.bno }"></c:out></td>
				<td><a href="/board/get?bno=${board.bno}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
				<c:out value="${board.title }"/></a></td>
				<td><c:out value="${board.writer }"></c:out></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate }"/></td>
			</tr>
		</c:forEach>
	</table>
	<!-- 검색추가하기 -->
	<form method="get" action="/board/list">
	
	<select name="type">
		<option value="N" <c:out value="${pageMaker.cri.type == 'N' ? 'selected' : ''}"/>>제목</option>
		<option value="P" <c:out value="${pageMaker.cri.type == 'P' ? 'selected' : ''}"/>>출판사</option>
		<option value="A" <c:out value="${pageMaker.cri.type == 'A' ? 'selected' : ''}"/>>작가</option>
	</select>
	<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
	<input type="submit" value="검색">
	</form> 
	<!-- 페이징 추가 -->
	<div class="pull-right">
		<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li>
					<a href="/board/list?pageNum=${pageMaker.startPage-1 }&amount=10&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">prev</a>
				</li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				<li>
					<a href="/board/list?pageNum=${num }&amount=10&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">${num }</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<li>
					<a href="/board/list?pageNum=${pageMaker.endPage+1 }&amount=10&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">next</a>
				</li>
			</c:if>
		</ul>
	</div>
	<!-- 페이징 추가 끝 -->
	<p><button onclick="location.href='/board/register'">게시글등록</button></p>
	<!-- 모달 추가 -->
	<div id="modal">
		<div id="modalbox">
			<h3>페이지 안내</h3>
			<div id="infotext">
				<c:out value="${param.result}"/> 처리가 완료되었습니다
			</div>
			<button id="modalclose">닫기</button>
		</div>
	</div>
	<script>
		let result = '<c:out value="${param.result}"/>';
		console.log(result);
		checkModal(result);
		function checkModal(result){
			if(!result) return;
			document.querySelector("#modal").style.display = 'block';
		}
		//닫기 누르면 모달창 사라지게 하기
		document.querySelector("#modalclose").addEventListener("click",function(){
			document.querySelector("#modal").style.display = 'none';			
		});
		
	</script>
</body>
</html>