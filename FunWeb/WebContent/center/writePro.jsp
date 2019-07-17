
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />

<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->


<nav id="sub_menu">
<ul>
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->"src/member/MemberDAO.java"

<%
	// center/writePro.jsp
// 한글처리
// 파라미터값 가져와서 변수에 저장
// BoardBean bb 객체 생성
// 멤버변수 <- 파라미터 값 저장
// BoardDAO bdao 객체 생성

// insertBoarad(bb) 메서드 호출
// notice.jsp 이동

String id = (String)session.getAttribute("id");
request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

BoardBean bb = new BoardBean();

bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);


BoardDAO bdao = new BoardDAO();

int result = bdao.insertBoard(bb);

if (result==1) {
	response.sendRedirect("notice.jsp");
}
else{
%> 
	<script type="text/javascript">		
	alert('글쓰기 오류 발생');
	history.back();
// 	location.href='../member/login.jsp';
	</script>
	<%	
}


%>
<article>
<h1>Notice Pro</h1>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->

<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />

<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>