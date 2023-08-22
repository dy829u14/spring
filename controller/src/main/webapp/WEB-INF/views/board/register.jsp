<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>
		<!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>
          
					<h2>등록 페이지 입니다.</h2>
					
                    <form class="user" method="post" action="/board/register">
                    <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
                      <div class="form-group row">
                          <div class="col-sm-6 mb-3 mb-sm-0">
                              <input type="text" class="form-control form-control-user" id="exampleFirstName"
                                  placeholder="제목" name="title" required>
                          </div>
                          <div class="col-sm-6">
                              <input type="text" class="form-control form-control-user" id="exampleLastName"
                                  placeholder="글쓴이" value='<sec:authentication property="principal.username"/>' name="writer" required/>
                          </div>
                          <div class="col-sm-12">
								<textarea rows="" cols="" class="form-control form-control-user"
								 id="exampleLastName" name="content" placeholder="내용" required></textarea>
                          </div>
                          <div>
                          		<button type="submit" class="btn btn-primary btn-user" >등록</button>
								<button type="reset" class="btn btn-primary btn-user" >취소</button>
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
		</div>
		<script>
		$(document).ready(function(){
			//input태그중 type이 file요소 선택
			//요소의 변경이 있으면 콜백함수실행
			$("input[name='uploadFile']").change(function(){
				//가상의 폼을 생성(폼태그)
				let formData = new FormData();
				let inputFile = $("input[name='uploadFile']");
				let files = inputFile[0].files;
				console.log(files);
				for(let i=0; i<files.length; i++){
					formData.append("uploadFile",files[i]);
				}
				let csrfHeaderName = "${_csrf.headerName}";
				let csrfTokenValue = "${_csrf.token}";
				$.ajax({
					url: '/uploadAjaxAction',
					data: formData,
					type: 'POST',
					//ajax post 전송시 security 인증정보를 같이 넘겨줘야함
					beforeSend:function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					dataType: 'json',
					processData: false,
					contentType: false,
					success: function(result){
						console.log(result);
						showUploadResult(result);
					}
				});
			})
			
			function showUploadResult(uploadResultArr){
				//결과 배열이 null이거나 길이가 0이면 함수종료 
				if(!uploadResultArr || uploadResultArr.length==0) { return; }
				let uploadul = $(".uploadResult ul");
				let str = "";
				$(uploadResultArr).each(function(i, obj){
					console.log(obj);
					let fileCallpath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
					str += "<li data-path='"+obj.uploadPath+"' data-filename='"+obj.fileName+"'"
					+"data-uuid='"+obj.uuid+"' data-type='"+obj.image+"'>"
					+"<img src='/display?fileName="+fileCallpath+"'/>"
				    +"<button class='btn' data-file=\'"+fileCallpath+"\' data-type='image'>"
					+"삭제</button>"
				    +"</li>"
				})
				uploadul.append(str);
			}
			
			//전송버튼 누를때 파일 관련 데이터도 같이 전송
			$("button[type='submit']").on("click", function(e){
				//연결된 이벤트 제거(submit 전송 제거)
				e.preventDefault();
				let formObj = $("form.user");
				console.log("submit클릭");
				let str = "";
				$(".uploadResult ul li").each(function(i, obj){
					let jobj = $(obj);
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'/>";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'/>";
				})
				//폼에 데이터 추가 append(), submit() 전송하기
				formObj.append(str).submit();
			})
			
			
			//삭제버튼 추가하기
			$(".uploadResult").on("click", "button", function(e){
				console.log("삭제 클릭");
				//이벤트를 발생시키면 이벤트를 발생시킨 객체를 this가 가리킴
				//커스텀 속성 dataset ---> data("키이름")
				let targetFile = $(this).data("file");
				let targetLi = $(this).closest("li");
				let type = $(this).data("type");
				let csrfHeaderName = "${_csrf.headerName}";
				let csrfTokenValue = "${_csrf.token}";
				$.ajax({
					url: '/deleteFile',
					data: {fileName: targetFile, type: type},
					dataType: 'text',
					type: 'POST',
					beforeSend:function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success: function(result){
						alert(result);
					}
				})
				targetLi.remove();
			})
		})
			
		</script>
<%@ include file="../includes/footer.jsp" %>
