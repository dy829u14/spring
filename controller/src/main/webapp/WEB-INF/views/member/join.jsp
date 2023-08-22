<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="/member/join">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	<table border="1">
		<tr>
			<th>아이디</th>
			<td><input type="text" name="userid"/></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="userpw"/></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="userName"/></td>
		</tr>
		<tr>
			<th>회원등급</th>
			<td>
				<select name="auth">
					<option value="ROLE_USER">일반회원</option>	
					<option value="ROLE_MEMBER">관리자회원</option>	
					<option value="ROLE_ADMIN">운영자회원</option>	
				</select>
			</td>
		</tr>
	</table>
	<input type="submit" value="전송"/>
	</form>
</body>
</html>