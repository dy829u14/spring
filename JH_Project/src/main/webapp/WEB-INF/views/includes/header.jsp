<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="path" value="${pageContext.request.contextPath}"/> 
   
<!DOCTYPE html>
<html>
<style>
#logout button {
	border: none;
	background-color: #fff;
}
</style>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Shop Homepage - Start Bootstrap Template</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- Core theme CSS (includes Bootstrap)-->
    
    <link href="${path}/resources/css/styles.css" rel="stylesheet" >
    <link href="${path}/resources/css/style.css" rel="stylesheet" >
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
   	 <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
     <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
</head>
<body></body>
		<div id="topmenu">
			<p>Icon</p>
			<h1><a href="../main">J-MARKET</a></h1>
			<div>
				<sec:authorize access="isAnonymous()">
					<p><a href="/customLogin">로그인</a></p>
					<p><a href="/member/register">회원가입</a></p>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<form action="/customLogout" method="post">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
						<p id="logout"><button>로그아웃</button></p>
					</form>
					<p><a href="/member/register">회원정보</a></p>
				</sec:authorize>
								
			</div>
		</div>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a href="../main">J-MARKET</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link active" aria-current="page" href="/sell/list">Product</a></li>
                        <li class="nav-item"><a class="nav-link active" href="#!">자유게시판</a></li>
                        <li class="nav-item"><a class="nav-link active" href="#!">Q&A</a></li>                     
                    </ul>               
                    <!-- 검색추가하기 -->
					<form method="get" action="/sell/list" class="d-flex">
						<select name="type">
							<option value="T" <c:out value="${pageMaker.cri.type == 'T' ? 'selected' : ''}"/>>제목</option>
							<option value="W" <c:out value="${pageMaker.cri.type == 'W' ? 'selected' : ''}"/>>글쓴이</option>
							<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected' : ''}"/>>내용</option>
						</select>
						<input type="text" name="keyword" value="${pageMaker.cri.keyword }">
						<input class="btn btn-outline-dark" type="submit" value="검색">
					</form> 
                </div>
            </div>
        </nav>
