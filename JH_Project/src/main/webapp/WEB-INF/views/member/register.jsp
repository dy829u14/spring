<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입</h2>
	<form action="/member/register" method="post" class="member_register">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mId"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="mPw"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="mName"></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td>
					<select class="box" id="birth-year">
						<option>생년</option>
					</select>
					<select class="box" id="birth-month">
						<option>월</option>
					</select>
					<select class="box" id="birth-day">
						<option>일</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="mPhone" placeholder="' - ' 제외한 숫자만 입력"></td>
			</tr>
			<tr class="address">
				<td>주소</td>
				<td>
					<input type="text" id="sample6_postcode" placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample6_address" placeholder="주소"><br>
					<input type="text" id="sample6_detailAddress" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" placeholder="참고항목">
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="mEmail"></td>
			</tr>
			<tr>
				<td>
					<button type="submit">가입</button>
					<button type="reset">취소</button>
				</td> 			
			</tr>
		</table>
	</form>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function(){
	//전송버튼 누를때 파일 관련 데이터도 같이 전송
	$("button[type='submit']").on("click", function(e){
		//연결된 이벤트 제거(submit전송 제거)
		e.preventDefault();
		
		var input1Value = $('#sample6_postcode').val();
        var input2Value = $('#sample6_address').val();
        var input3Value = $('#sample6_detailAddress').val();
        var input4Value = $('#sample6_extraAddress').val();
        
        var birthY = $('#birth-year').val();
        var birthM = $('#birth-month').val();
        var birthD = $('#birth-day').val();
        
        var combinedValue = input1Value +" "+ input2Value +" "+ input3Value +" "+ input4Value;
        var mAddress = combinedValue.toString();
        var birthValue = birthY+"/"+birthM+"/"+birthD;
        
        var input1 = $('#sample6_postcode');
        var locaNumber = input1.text();
        var stringLoca = locaNumber.toString();
        var location = stringLoca.substring(0,2);
		
		//폼 선택 formObj 할당
		let formObj = $("form.member_register");
		
		// 조합한 값을 hidden input에 저장
        $('<input>').attr({
            type: 'hidden',
            id: 'mAddress',
            name: 'mAddress',
            value: mAddress
        }).appendTo(formObj);		
		
        $('<input>').attr({
            type: 'hidden',
            id: 'mBirth',
            name: 'mBirth',
            value: birthValue
        }).appendTo(formObj);
        
        $('<input>').attr({
            type: 'hidden',
            id: 'mLocation',
            name: 'mLocation',
            value: location
        }).appendTo(formObj);
        
		formObj.unbind('submit').submit();
	});
});
	
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
    
 	// '출생 연도' 셀렉트 박스 option 목록 동적 생성
    const birthYearEl = document.querySelector('#birth-year')
    // option 목록 생성 여부 확인
    isYearOptionExisted = false;
    birthYearEl.addEventListener('focus', function () {
      // year 목록 생성되지 않았을 때 (최초 클릭 시)
      if(!isYearOptionExisted) {
        isYearOptionExisted = true
        for(var i = 1940; i <= 2022; i++) {
          // option element 생성
          const YearOption = document.createElement('option')
          YearOption.setAttribute('value', i)
          YearOption.innerText = i
          // birthYearEl의 자식 요소로 추가
          this.appendChild(YearOption);
        }
      }
    });

 // '출생 연도' 셀렉트 박스 option 목록 동적 생성
    const birthMonthEl = document.querySelector('#birth-month')
    // option 목록 생성 여부 확인
    isMonthOptionExisted = false;
    birthMonthEl.addEventListener('focus', function () {
      // year 목록 생성되지 않았을 때 (최초 클릭 시)
      if(!isMonthOptionExisted) {
        isMonthOptionExisted = true
        for(var i = 1; i <= 12; i++) {
          // option element 생성
          const MonthOption = document.createElement('option')
          MonthOption.setAttribute('value', i)
          MonthOption.innerText = i
          // birthYearEl의 자식 요소로 추가
          this.appendChild(MonthOption);
        }
      }
    });
 // '출생 연도' 셀렉트 박스 option 목록 동적 생성
    const birthDayEl = document.querySelector('#birth-day')
    // option 목록 생성 여부 확인
    isDayOptionExisted = false;
    birthDayEl.addEventListener('focus', function () {
      // year 목록 생성되지 않았을 때 (최초 클릭 시)
      if(!isDayOptionExisted) {
        isDayOptionExisted = true
        for(var i = 1; i <= 31; i++) {
          // option element 생성
          const DayOption = document.createElement('option')
          DayOption.setAttribute('value', i)
          DayOption.innerText = i
          // birthYearEl의 자식 요소로 추가
          this.appendChild(DayOption);
        }
      }
    });
</script>
</html>