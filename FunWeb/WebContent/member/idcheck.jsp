<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function ok(){
	id=document.fr.id.value;
// 	join.jsp페이지 id.vale = idcheck.jsp페이지  fid.value 후 창닫기

// 	join.jsp창.document.fr.id.value=document.wfr.fid.value;
// 	window 내장객체 멤벼변수 opener 변수 -> 창을 오픈하게 해준 페이지 -> join.jsp에서 연 페이지이므로 해당 변수의 값은 join.jsp가 된다
//	window.opner.document.fr.id
	opener.id = id;
	window.close();	
}
function check(){
	id=document.fr.id;
	if(id.value==""){
		alert("아이디를 입력하세요");
		id.focus();
		return;		
	}
	else if (id.value.length<4 || !id.value.length>7){		
		alert("id는 4~7자로 입력해주세요");
		id.focus();
		return;
	}
	else{
		document.fr.submit();
	}
}	
</script>
</head>
<body style="background-color: white">
<div class="id_ch">
<%
String id = request.getParameter("id");
MemberDAO mdao = new MemberDAO();

%>
<form action="idcheck.jsp" name="fr" method="get" onsubmit="return check()">
<input type="text" name="id" value=<%=id %>><input type="submit" value="중복확인"><br>
</form>
<%
int check = mdao.userCheck(id,"");
	if(check==0 || check==1){
		%> <span class="xid">중복된 아이디입니다.</span> <%
	}else if(check==-1){
		%> <span class="oid">사용가능한 아이디입니다.</span> <br>
		   <input type="button" value="아이디 사용하기" onclick="ok()">
		<%
	}
%>

</div>
</body>
</html>