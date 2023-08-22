<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>리스트페이지</h1>
	<table>
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
			<td>등록일</td>
		</tr>
		<c:forEach items="${list}" var="board">
			<tr>
				<td><c:out value="${board.sno }"></c:out></td>
				<td><a href="/sell/get?sno=${board.sno}&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
				<c:out value="${board.STitle }"/></a></td>
				<td><c:out value="${board.MId }"></c:out></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.SRdate }"/></td>				
			</tr>
		</c:forEach>
	</table>
	<!-- 검색추가하기 -->
	<form method="get" action="/sell/list">
	
	<select name="type">
		<option value="T" <c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}"/>>제목</option>
		<option value="W" <c:out value="${pageMaker.cri.type == 'W' ? 'selected' : ''}"/>>글쓴이</option>
		<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}"/>>내용</option>
	</select>
	<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
	<input type="submit" value="검색">
	</form> 
	<!-- 페이징 추가 -->
	<div class="pull-right">
		<ul class="pagination">
			<c:if test="${pageMaker.prev }">
				<li>
					<a href="/sell/list?pageNum=${pageMaker.startPage-1 }&amount=10&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">prev</a>
				</li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				<li>
					<a href="/sell/list?pageNum=${num }&amount=10&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">${num }</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<li>
					<a href="/sell/list?pageNum=${pageMaker.endPage+1 }&amount=10&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">next</a>
				</li>
			</c:if>
		</ul>
	</div>
	<!-- 페이징 추가 끝 -->
	<p><button onclick="location.href='/sell/register'">게시글등록</button></p>
</body>
</html>