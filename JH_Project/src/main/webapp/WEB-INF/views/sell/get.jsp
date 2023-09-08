<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@ include file="../includes/header.jsp" %>
<script src="./js/jquery.js"></script>
<script src="../resources/js/slick.min.js"></script>

<link rel="stylesheet" href="../resources/css/slick.css" />
<link rel="stylesheet" href="../resources/css/slick-theme.css" />
<style>
	.bigPictureWrapper{
		position:absolute;
		top:0;
		left:0;
		width:100%;
		height:100vh;
		background:rgba(0,0,0,0.5);
		display:none;
		justify-content:center;
		align-items:center;
		color:#fff;
	}
</style>
<div id="wrap">
<h2>상세조회 페이지</h2>
	<div class="inner">	
<div class="bigPictureWrapper">
	<div class="bigPicture">
		
	</div>
</div>
</div>
<button class="btn btn-outline-dark flex-shrink-0" 
		 onclick="location.href='/sell/list?pageNum=${cri.pageNum}&amount=${cri.amount }&type=${cri.type}&keyword=${cri.keyword}'">목록</button>
<!-- Product section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5">
                    <div class="insertImg col-md-6"></div>
                    <div class="col-md-6">
                        <div class="small mb-1"><c:out value="${board.SCate }"></c:out></div>
                        <h1 class="display-5 fw-bolder"><c:out value="${board.STitle }"></c:out></h1>
                        <div class="fs-5 mb-5">                            
                            <span><c:out value="${board.SPrice }"></c:out>원</span>
                        </div>
                        <p class="lead"><c:out value="${board.SContent }"></c:out></p>
                        <div class="d-flex">
                            <input class="form-control text-center me-3" id="inputQuantity" type="num" value="1" style="max-width: 3rem" />
                            <button class="btn btn-outline-dark flex-shrink-0" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                Add to cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
<div class="btnAlign">        
		<!-- 변수등록 -->
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
		
		<!-- 로그인한 사용자랑 글쓴이가 같아야함 -->
		<c:if test="${pinfo.username eq board.MId }">
		<button class="btn btn-outline-dark flex-shrink-0" 
		onclick="location.href='/sell/modify?sno=${board.sno}&pageNum=${cri.pageNum}
		&amount=${cri.amount }&type=${cri.type}&keyword=${cri.keyword}'">수정</button>
		<form method="post" action="/sell/remove">
			<input type="hidden" value="${board.sno }" name="sno"/>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			<button class="btn btn-outline-dark flex-shrink-0" type="submit" onclick="del();">삭제</button>
		</form>
		</c:if>
		</sec:authorize>
</div>
        </section>
        <!-- Related items section-->
        <section class="py-5 bg-light">
            <div class="container px-4 px-lg-5 mt-5">
                <h2 class="fw-bolder mb-4">Related products</h2>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Fancy Product</h5>
                                    <!-- Product price-->
                                    $40.00 - $80.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">View options</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Special Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$20.00</span>
                                    $18.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Sale badge-->
                            <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Sale Item</h5>
                                    <!-- Product price-->
                                    <span class="text-muted text-decoration-line-through">$50.00</span>
                                    $25.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="col mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder">Popular Item</h5>
                                    <!-- Product reviews-->
                                    <div class="d-flex justify-content-center small text-warning mb-2">
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                        <div class="bi-star-fill"></div>
                                    </div>
                                    <!-- Product price-->
                                    $40.00
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
	
</div>
<script>
$(document).ready(function(){
	//페이지가 로드되면 스스로 실행되는 함수
	(function(){
		let sno = '<c:out value="${board.sno}"/>';
		$.getJSON("/sell/getAttachList",{sno:sno},
			function(arr){
				//이미지 나타내기
				let str = "";
				$(arr).each(function(i, attach){
					let fileCallpath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
					str += "<div data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'";
					str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
					str += "<img class='object-cover card-img-get' src='/upload/display?fileName="+fileCallpath+"'/>";
					str += "</div>";
				})
				$(".insertImg").html(str);
				$('.insertImg').slick();
			})//end getJSON
	})();
	//li를 클릭하면 bigPictureWrapper나타나게 하고
	//.bigPicture의 html 내용에 이미지가 나타나도록 지정
	$(".uploadResult").on("click", "div", function(e){
		console.log("view image");
		let liObj = $(this);
		let path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
		showImage(path.replace(new RegExp(/\\/g),"/"));
	})
	function showImage(fileCallPath){		
		$(".bigPictureWrapper").css("display","flex");
		$(".bigPicture").html("<img src='/upload/display?fileName="+fileCallPath+"' width='500'/><span>X</span>");
	}
	$(".bigPictureWrapper").on("click","span", function(e){
		$(".bigPictureWrapper").css("display","none");
	})
	
});
function del(sno) {
		var chk = confirm("정말 삭제하시겠습니까?");
		if (chk) {
			location.href='delete?sno='+sno;
		}
	}

</script>
<%@ include file="../includes/footer.jsp" %>