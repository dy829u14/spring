<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<%@ include file="../includes/header.jsp" %>
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
	<p>번호 : <c:out value="${board.sno }"></c:out></p>
	<p>제목 : <c:out value="${board.STitle }"></c:out></p>
	<p>내용 : <c:out value="${board.SContent }"></c:out></p>
	<p>작성자 : <c:out value="${board.MId }"></c:out></p>
	<div class="uploadResult">
		<div></div>
	</div>
	<div class="slider single-item slick-initialized slick-slider slick-dotted">
		<div class="slick-list draggable">
			<div class="slick-track">
			
			</div>
		</div>
	</div>
	
	<p>
		<button onclick="location.href='/sell/list?pageNum=${cri.pageNum}&amount=${cri.amount }&type=${cri.type}&keyword=${cri.keyword}'">목록</button>
		<!-- 변수등록 -->
		<sec:authentication property="principal" var="pinfo"/>
		<sec:authorize access="isAuthenticated()">
		
		<!-- 로그인한 사용자랑 글쓴이가 같아야함 -->
		<c:if test="${pinfo.username eq board.MId }">
		<button onclick="location.href='/sell/modify?sno=${board.sno}&pageNum=${cri.pageNum}&amount=${cri.amount }&type=${cri.type}&keyword=${cri.keyword}'">수정</button>
		<form method="post" action="/sell/remove">
			<input type="hidden" value="${board.sno }" name="sno"/>
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
			<button type="submit" onclick="del();">삭제</button>
		</form>
		</c:if>
		</sec:authorize>
	</p>
<div class="bigPictureWrapper">
	<div class="bigPicture">
		
	</div>
</div>
</div>
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
					str += "<div class='slick-slide' data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'";
					str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
					str += "<img src='/upload/display?fileName="+fileCallpath+"'/>";
					str += "</div>";
				})
				$(".slick-track").html(str);
			})//end getJSON
	})();
	//li를 클릭하면 bigPictureWrapper나타나게 하고
	//.bigPicture의 html 내용에 이미지가 나타나도록 지정
	$(".uploadResult").on("click", "li", function(e){
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

	$('.single-item').slick();
});
function del(sno) {
		var chk = confirm("정말 삭제하시겠습니까?");
		if (chk) {
			location.href='delete?sno='+sno;
		}
	}

</script>
<%@ include file="../includes/footer.jsp" %>