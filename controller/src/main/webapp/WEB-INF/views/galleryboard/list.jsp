<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
		<!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                
                
                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>
          
					<h2>갤러리 리스트 페이지 입니다.</h2>
                    <ul>
                    	<c:forEach items="${list }" var="board">
	                    	<li>
	                    		<a href="/galleryboard/view?gno=${board.gno }">
	                    		<img src="/display?fileName=${board.fullname }" width="300px" height="300px"/>
	                    		<p><c:out value="${board.title }"></c:out></p>
	                    		<p><c:out value="${board.writer }"></c:out></p>
	                    		</a>
	                    	</li>
	                    </c:forEach>
                    </ul>
                        
                    

                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
        </div>
 <%@ include file="../includes/footer.jsp" %>