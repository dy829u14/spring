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
	<h2>수정 페이지</h2>	
	<form class="galleryboard" action="/galleryboard/modify" method="post">
      <div class="form-group row">
      	<input type="hidden" name="gno" value="${board.gno}"/>
          <div class="col-sm-12">
              <input type="text" class="form-control" id="exampleFirstName"
                  placeholder="제목" name="title" value="${board.title}">
          </div>
          <div class="col-sm-12">
              <input type="text" class="form-control" id="exampleLastName"
                  placeholder="작성자" name="writer" value="${board.writer}">
          </div>
          <div class="col-sm-12">
          	<select name="category">
          		<option value="all">종류</option>
          		<option value="cat">cat</option>
          		<option value="dog">dog</option>
          	</select>
          </div>
          <div class="col-sm-12">                          	
		<div class="panel panel-default">
			<div class="panel-heading">이미지 첨부</div>
			<div class="panel-body">
				<div class="uploadDiv">
					<input type="file" name="uploadFile" />
				</div>
				<div class="uploadResult">
					<img src="/display?fileName=${board.fullname}" width="600" />
				</div>
			</div>
		</div>							
          </div>
      </div>
          
          <div class="form-group">
          	<textarea rows="" cols="" class="form-control" id="exampleInputEmail"
              name="content"></textarea>                                  
          </div>
          <div class="form-group row">
              <div class="col-sm-12">
              		<button type="submit" class="btn btn-primary btn-user">수정</button>
					<button type="reset" class="btn btn-primary btn-user">취소</button>                                       
              </div>                                    
          </div>                                
      </form>
</div>
	</div>
<script>
//html문서를 다 로드하면 실행
	$(document).ready(function(){
	
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
			let uploadul = $(".uploadResult");
			let str = "";
			$(uploadResultArr).each(function(i, obj){
				console.log(obj);
				let fileCallpath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				let fileFullpath = encodeURIComponent(obj.uploadPath+"\\"+obj.uuid+"_"+obj.fileName);
				str += "<p data-path='"+obj.uploadPath+"' data-filename='"+obj.uuid+"_"+obj.fileName+"'"
						+"data-fullname='"+fileFullpath+"'>"
						+"<img src='/display?fileName="+fileCallpath+"'/>"
						+"</p>";
			})
			uploadul.html(str);
		}
		
		//전송버튼 클릭시 실행
		$("button[type='submit']").on("click",function(e){
			//연결된 이벤트 제거(submit전송 제거)
			e.preventDefault();
			//폼선택
			let formObj = $("form.galleryboard");
			let imgp = $(".uploadResult p");
			let inputstr = "";
			inputstr += "<input type='hidden' name='filename' value='"+imgp.data("filename")+"'>"
			inputstr += "<input type='hidden' name='fullname' value='"+imgp.data("fullname")+"'>"
			inputstr += "<input type='hidden' name='uploadpath' value='"+imgp.data("path")+"'>"
			formObj.append(inputstr).submit();
		})
	})
</script>
<%@ include file="../includes/footer.jsp" %>