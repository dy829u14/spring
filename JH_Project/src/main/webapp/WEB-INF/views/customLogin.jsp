<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./includes/header.jsp" %>
	<div id="wrap">
	<h2>로그인 페이지</h2>
	<form action="/login" method="post">
		<p><input type="text" name="username"/></p>
		<p><input type="password" name="password"/></p>
		<p><input class="btn btn-outline-dark" type="submit" value="로그인"/></p>
		<input type="hidden" name="remember-me" value="true"/>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	</form>
	</div>
<%@ include file="./includes/footer.jsp" %>