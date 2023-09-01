<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="./includes/header.jsp" %>
<style>
.sno {display: none;}
}
</style>
	 <!-- Section-->	 
        <section class="py-5">
        	<div class="inner">
				
			</div>
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
        </section>
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
<%@ include file="./includes/footer.jsp" %>