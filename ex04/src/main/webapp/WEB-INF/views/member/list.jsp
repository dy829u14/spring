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
	<h2>회원 목록</h2>
	<button onclick="location.href='/member/join'">회원가입</button>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>이름</td>
			<td>전화번호</td>
			<td>주소</td>
			<td>이메일</td>
		</tr>		
		<c:forEach items="${list}" var="list">
		<tr>
			<td><c:out value="${list.mno}"></c:out></td>
			<td><c:out value="${list.name}"></c:out></td>
			<td><c:out value="${list.phonenumber}"></c:out></td>
			<td><c:out value="${list.address}"></c:out></td>
			<td><c:out value="${list.email}"></c:out></td>
		</tr>
		</c:forEach>		
	</table>
</body>
</html>