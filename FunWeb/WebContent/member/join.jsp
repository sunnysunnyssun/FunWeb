<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="../script/jquery-3.4.1.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
function post(){
    new daum.Postcode({
        oncomplete: function(data) {
   
        	// 도로명 주소의 노출 규칙에 따라 주소를 조합한다
        	// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기한다.
        	
        	var fullAddr = data.address; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수
        	
        	// 기본 주소가 도로명 타입일 때 
        	if(data.addressType === 'R'){
        		// 법정동명이 있을 경우 추가
        		if(data.bname !== ''){
        			extraAddr += data.bname;
        		}
        		// 건물명이 있을 경우 추가
        		if(data.buildingName !== ''){
        			extraAddr += (extraAddr !=='' ? ', ' + data.buildingName : data.buildingName);
        			// extraAddr 데이터 값이 있으면 " , 빌딩네임" 추가 없으면 바로 "빌딩네임" 추가
        		}
        		
        		// 조합형주소의 우뮤에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다 (없으면 널스트링)
        		fullAddr += (extraAddr !=='' ? '(' + extraAddr + ')' : '');
        		
        		// 우편번호 주소 정보를 해당 필드에 넣는다
        		
        	}        		
        	else if (data.addressType === 'J'){
        		// 건물명이 있을 경우 추가
        		if(data.buildingName !== ''){
        			extraAddr += (extraAddr !=='' ? ', ' + data.buildingName : data.buildingName);
        			// extraAddr 데이터 값이 있으면 " , 빌딩네임" 추가 없으면 바로 "빌딩네임" 추가
        		}
        		// 조합형주소의 우뮤에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다 (없으면 널스트링)
        		fullAddr += (extraAddr !=='' ? '(' + extraAddr + ')' : '');
        	}
         		document.getElementById('postCode').value = data.zonecode; // 5자리 새 우편번호 사용
        		document.getElementById('roadAddress').value = fullAddr;
        		document.getElementById('detailAddress').focus();
        }
    }).open();
}


function idcheck(){
	// id 상자가 비어있으면 "아이디 입력" 제어
	// 아이디 입력되어있으면 새창열기 "idcheck.jsp"
	
	// 자바스크립트는 null아니고 ""이면.
	
	fid=document.fr.id.value;
// 	document.getElementByClass("id").length // document.fr.id.value.length 두가지 방법
	
	if(fid==""){
		alert("아이디를 입력하세요");
		document.fr.id.focus();
		return;		
	}
	else if (fid.length<4 || !fid.length>7){		
		alert("id는 4~7자로 입력해주세요");
		document.fr.id.focus();
		return;
	}
	else{
// 		window.open("파일이름","창이름","옵션");
		window.open("idcheck.jsp?id="+fid,"","width=400,height=200");
// 		"idcheck.jsp?fid="+fid -> 조인 -> "문자열" + 자바스크립트변수
	}
}


function pass2(){
 	var pass = document.fr.pass;
	var pass2 = document.fr.pass2;
	if(pass.value==='' || pass.value.length<3 || 8<pass.value.length ){
		pass.style.border = "3px solid red";
		document.getElementById('passOk').innerHTML = ' 비밀번호는 3~8자로 입력해주세요';
		document.getElementById('passOk').style.color = 'red';
	}
	else{
		document.getElementById('passOk').innerHTML = '';
		pass.style.border = "1px solid #999";
		
	}

		if(pass.value!==pass2.value){
			pass2.style.border = "3px solid red";
			document.getElementById('same').innerHTML = ' 비밀번호가 일치하지 않습니다';
			document.getElementById('same').style.color = 'red';

		}
		else{
			document.getElementById('same').innerHTML = ' 비밀번호가 일치합니다';
			document.getElementById('same').style.color = 'blue';
			document.getElementById('same').innerHTML = '';
			pass2.style.border = "1px solid #999";
		} 

}

$(document).ready(function(){
	$('.dup').click(function(){
	    
	    if($('#id').val()==""){
	        alert("아이디를 입력하세요");
	        $('#id').focus();
	        return;     
	    }
	    $.ajax('idcheck2.jsp',{
	        data:{id:$('#id').val()},
	        success : function(data){
	            console.log(data);
	            $('#idCheckText').html(data);

	        }
	    });
	});  // 아이디 중복 체크 버튼을 클릭햇을 때.


});

</script>


<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Do+Hyeon|Nanum+Gothic+Coding|Noto+Sans+KR|Noto+Serif+KR&display=swap" rel="stylesheet">

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />

<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<!-- <h1>Join Us</h1> -->
<h1>회원 가입</h1>

<form action="joinPro.jsp" id="join" method="post" name="fr">
<fieldset>
<legend>기본사항</legend>
<label>아이디</label>
<input type="text" name="id" class="id" id="id" required="required" placeholder="아이디는 4~7자 ">
<!-- <input type="button" value="아이디중복확인" class="dup" onclick="idcheck()"><br> -->

<input type="button" value="아이디중복확인" class="dup" id="idCheck"><span id="idCheckText"></span><br>

<label>비밀번호</label>
<input type="password" name="pass" required="required" placeholder="비밀번호 3~8자의 영문자" onkeyup="pass2()"> <span id="passOk"></span><br>
<label>비밀번호 확인</label>
<input type="password" name="pass2" required="required" placeholder="비밀번호 입력 확인" onkeyup="pass2()"> <span id="same"></span><br>	
<label>이름</label>
<input type="text" name="name" required="required" placeholder="이름을 입력하세요"><br>
<label>E-Mail</label>
<input type="email" name="email" required="required" placeholder="이메일을 입력하세요"><br>
<!-- <label>Retype E-Mail</label> -->
<!-- <input type="email" name="email2"><br> -->
</fieldset>

<fieldset>
<legend>추가 사항</legend>
<label>우편번호</label>
<!-- <input type="text" name="address"><br> -->

<input type="text" id="postCode" name="postCode" id="postCode" placeholder="우편번호" maxlength="8">
<input type="button" value="우편번호 찾기" onClick="post()" class="dup"><br>		
<label>주소</label>									
<input type="text" id="roadAddress" name="roadAddress" id="roadAddress" placeholder="도로명주소" size="50"><br>
<label>상세주소</label>									
<input type="text" id="detailAddress" name="detailAddress" id="detailAddress" placeholder="상세주소" size="50"><br>
<label>휴대폰번호</label>
<input type="number" name="mobile"><br>

</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
<input type="reset" value="취소" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />

<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>