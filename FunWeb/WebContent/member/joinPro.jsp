<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// 회원가입

// request 한글 처리
request.setCharacterEncoding("utf-8");
//파라미터 
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String postCode = request.getParameter("postCode");
String roadAddr = request.getParameter("roadAddress");
String detailAddr = request.getParameter("detailAddress");
String mobile = request.getParameter("mobile");
String address = "("+postCode+")"+roadAddr+" "+detailAddr;
Timestamp reg_date = new Timestamp(System.currentTimeMillis());
// --Timestamp : java.sql

// 패키지 member 파일이름 MemberBean
// id pass name reg_date email address phone mobile

// MemberBean mb 객체 생성
MemberBean mb = new MemberBean();

// mb 멤버변수 <= 파라미터 저장
	mb.setAddress(address);
	mb.setEmail(email);
	mb.setId(id);
	mb.setMobile(mobile);
	mb.setName(name);
	mb.setPass(pass);
	mb.setReg_date(reg_date);	

// 패키지 member 파일이름 MemberDAO
MemberDAO mdao = new MemberDAO();

// insertMember(mb)
int result = mdao.insertMember(mb);

	if (result==1){	// insert 성공
	// login.jsp 이동 %>		
		<script type="text/javascript">		
		alert('회원가입이 완료되었습니다. 로그인 해주십시오.');
		location.href='login.jsp';
		</script>
		<%		
	}else{	// insert 실패 %>	
		<script type="text/javascript">		
		alert('오류가 발생하였습니다.');
		history.back();
		</script>
	<% 	
	}
%>


</body>
</html>