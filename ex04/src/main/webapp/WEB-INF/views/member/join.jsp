<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원 가입</h2>
	<form action="/member/join" method="post">
		<table>
			<tr>
				<td>ID</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>PASSWORD</td>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr>
				<td>NAME</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>PHONENUMBER</td>
				<td><input type="text" name="phonenumber"></td>
			</tr>			
			<tr>
				<td>ADDRESS</td>
				<td><input type="text" name="address"></td>
			</tr>
			<tr>
				<td>E-MAIL</td>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<td rowspan="2">
					<button type="submit">가입</button>
					<button type="reset">취소</button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>