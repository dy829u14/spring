<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>all페이지 입니다.</h2>
	<sec:authorize access="isAnonymous()">
		<a href="/customLogin">로그인</a>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
	<a href="/customLogout">로그아웃</a>
</sec:authorize>
</body>
</html>