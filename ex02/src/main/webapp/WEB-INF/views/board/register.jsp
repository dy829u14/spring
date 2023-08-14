<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<h2>등록 페이지</h2>	
	<form class="user" action="/board/register" method="post">
                      <div class="form-group row">
                          <div class="col-sm-6 mb-3 mb-sm-0">
                              <input type="text" class="form-control form-control-user" id="exampleFirstName"
                                  placeholder="제목" name="title">
                          </div>
                          <div class="col-sm-6">
                              <input type="text" class="form-control form-control-user" id="exampleLastName"
                                  placeholder="작성자" name="writer">
                          </div>
                      </div>
                      <div class="form-group">
                      	<textarea rows="" cols="" class="form-control form-control-user" id="exampleInputEmail"
                          name="content"></textarea>                                  
                      </div>
                      <div class="form-group row">
                          <div class="col-sm-6 mb-3 mb-sm-0">
                          	<button type="submit" class="btn btn-primary btn-user">등록</button>
							<button type="reset" class="btn btn-primary btn-user">취소</button>                                       
                          </div>                                    
                      </div>                                
                  </form>
</div>
	<!-- 새로 추가되는 부분 -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">파일 첨부</div>
				<div class="panel-body">
					<div class="uploadDiv">
						<input type="file" name="uploadFile" multiple />
					</div>
					<div class="uploadResult">
						<ul>
							
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
<script>
//html문서를 다 로드하면 실행
	$(document).ready(function(){
		//전송버튼 누를때 파일 관련 데이터도 같이 전송
		$("button[type='submit']").on("click", function(e){
			//연결된 이벤트 제거(submit전송 제거)
			e.preventDefault();
			
			//폼 선택 formObj 할당
			let formObj = $("form.user");
			console.log("submit클릭")
			let str = "";
			$(".uploadResult ul li").each(function(i, obj){
				let jobj = $(obj);
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"' />";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"' />";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"' />";
			})
			//폼에 데이터 추가 append()메소드 submit() 전송하기
			formObj.append(str).submit();
		})
		//input태그중 type이 file요소 선택
		//요소의 변경이 있으면 콜백함수실행
		$("input[type='file']").change(function(){
			//가상의 폼을 생성(폼태그)
			let formData = new FormData();
			let inputFile = $("input[name='uploadFile']");
			let files = inputFile[0].files;
			for(let i=0; i<files.length; i++){
				formData.append("uploadFile", files[i]);
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: "POST",
				dataType: 'json',
				success: function(result){
					console.log(result);
					showUploadResult(result);
				}
			})
		})
		function showUploadResult(uploadResultArr){
			//결과 배열이 null이거나 길이가 0이면 함수 종료
			if(!uploadResultArr || uploadResultArr.length==0) {return;}
			let uploadul = $(".uploadResult ul");
			let str = "";
			$(uploadResultArr).each(function(i, obj){
				console.log(obj);
				let fileCallpath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"'"
						+"data-uuid='"+obj.uuid+"' data-type='"+obj.image+"'>"
						+"<img src='/display?fileName="+fileCallpath+"'/>"
						+ "<button class='btn' data-file=\'"+fileCallpath+"\' data-type='image'>"
						+"삭제</button>"
				+"</li>";
			})
			uploadul.append(str);
		}
		//삭제 버튼 추가하기
		$(".uploadResult").on("click", "button", function(e){
			console.log("삭제 클릭");
			//이벤트를 발생시키면 이벤트 발생키신 객체를 this(button)가 가르킴
			//커스텀 속성 dataset ---> data("키이름")
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			let targetLi = $(this).closest("li");
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type: type},
				dataType: 'text',
				type: 'POST',
				success: function(result) {
					alert(result)
				}
			})
			targetLi.remove();
		})
	})
</script>
<%@ include file="../includes/footer.jsp" %>










