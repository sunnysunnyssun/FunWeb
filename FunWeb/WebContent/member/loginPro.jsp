<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginPr.jsp</title>
</head>
<body>

<%
// member/loginPro.jsp
// 한글처리
// id,pass 파라미터 가져와서 변수에 저장

// MemberDAO mdao 객체 생성
// userCheck(함수처리할 때 필요한 ip,pass 가져가기)메서드 호출
// 함수 리턴값 check==1인 경우 아이디 비밀번호 일치, 권한부여 -> 세션값 생성, "id",id main/main.jsp 이동

// 함수 리턴값 check==0 "비밀번호틀림" 뒤로이동
// 함수 리턴값  check==-1 "아이디없음" 뒤로이동

request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pass = request.getParameter("pass");

MemberDAO mdao = new MemberDAO();

int check=mdao.userCheck(id, pass);


if(check==1){
	session.setAttribute("id", id);
	session.setAttribute("pass", pass);			
	%>
	<script type="text/javascript">			
		alert('<%=id%>님 환영합니다.');			
		location.href='../main/main.jsp';			
	</script>
	<%	
}
else if(check==0){ 	
	%> 
	<script type="text/javascript">			
	alert('비밀번호가 틀렸습니다.');
	alert('다시 입력해주세요.');	
	history.back();
	</script>	
	<%
}
else{
	%> 
	<script type="text/javascript">			
	alert('해당 아이디가 없습니다.');
	alert('다시 입력해주세요.');	
	history.back();
	</script>	
	<% 
}



%>


</body>
</html>