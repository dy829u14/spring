<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp" %>
<style>
.sno {display: none;}
.inner {
	display: flex;
	flex-wrap: wrap;
}
.bot{
	display: flex;
	justify-content: space-between;
	width: 100%;
}
</style>
<div id="wrap">
	<h1>리스트페이지</h1>
	<div class="inner">
	<div class="container px-4 px-lg-5 mt-5">
	<div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
		<c:forEach items="${list}" var="board">
         <div class="col mb-5">                    							
             <div class="card h-100">
                 <!-- Product image-->
                 <!-- Product details-->
                 <div class="card-body p-4">
                     <div class="text-center">
                         <!-- Product name-->
                         <div data-sno="${board.sno }" class="sno"><c:out value="${board.sno }"></c:out></div>
                         <h5 class="fw-bolder"><a href="/sell/get?sno=${board.sno}&pageNum=${pageMaker.cri.pageNum}
                         &amount=${pageMaker.cri.amount}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
						<c:out value="${board.STitle }"/></a></h5>
                         <!-- Product price-->
                         <div><c:out value="${board.SPrice }"></c:out>원</div>
                     </div>
                 </div>
                 <!-- Product actions-->
                 <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                     <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                 </div>
             </div>                        
         </div>
         </c:forEach>
	</div>
	</div>
	<div id="img"></div>
	
	<div class="bot">
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
	<sec:authorize access="isAuthenticated()">
	<p><button onclick="location.href='/sell/register'">게시글등록</button></p>
	</sec:authorize>
	</div>
</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	(function(){
		let sno = [];
		$('.sno').each(function(i, obj){
			let jobj = $(obj);
			sno[i] = jobj.data("sno");
			$.getJSON("/sell/getAttachList",
				{sno:sno[i]},
				function(arr){
					// 이미지 나타내기
					let attach = arr[0]; // 첫 번째 첨부 파일만 선택
					if (attach) {
						let fileCallpath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
						let str = "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'";
						str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
						str += "<a href='/sell/get?sno=" + sno[i] +"'>";
						str += "<img class='card-img-top' src='/upload/display?fileName="+fileCallpath+"'/>";
						str += "</a></li>";
						$(".card").eq(i).prepend(str);
					}
				})
		})
	})();
});
</script>
<%@ include file="../includes/footer.jsp" %>