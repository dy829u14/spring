<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%@ include file="../includes/header.jsp" %>
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
               
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>
	<h2>갤러리 상세보기</h2>
	<p><c:out value="${board.gno}" /></p>
	<p><c:out value="${board.title}" /></p>
	<p><c:out value="${board.writer}" /><c:out value="${board.category}" /></p>
	<p>
		<img src="/display?fileName=${board.fullname}" width="600">
	</p>
	<p><c:out value="${board.content}" /></p>
	<p>
		<button onclick="location.href='/galleryboard/modify?gno=${board.gno}'">수정</button>
		<button onclick="location.href='/galleryboard/list'">목록</button>
		<form method="post" action="/galleryboard/remove">
			<input type="hidden" value="${board.gno}" name="gno" />
			<input type="hidden" value="${board.uploadpath}" name="uploadpath" />
			<input type="hidden" value="${board.filename}" name="filename" />
			<button type="submit">삭제</button>
		</form>
	</p>
</div>
	</div>	
<%@ include file="../includes/footer.jsp" %>