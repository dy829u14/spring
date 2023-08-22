<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>BOOK LIST</h2>
	<button onclick="location.href='/book/register'">게시물 등록</button>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작가</td>
			<td>가격</td>
		</tr>		
		<c:forEach items="${list}" var="list">
		<tr>
			<td><c:out value="${list.bno}"></c:out></td>
			<td><c:out value="${list.title}"></c:out></td>
			<td><c:out value="${list.writer}"></c:out></td>
			<td><c:out value="${list.price}"></c:out></td>
		</tr>
		</c:forEach>		
	</table>
</body>
</html>