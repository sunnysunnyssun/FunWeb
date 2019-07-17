
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
<!-- 메인이미지 시작-->
<div id="sub_img_center"></div>
<!-- 메인이미지 끝-->
<!-- 왼쪽메뉴 시작-->
<nav id="sub_menu">
<ul>
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 끝-->

<!-- 게시판  시작-->

<%
// 한글처리
// 파라미터값 가져와서 변수에 저장
// BoardBean bb 객체 생성
// bb 멤버변수 <- 파라미터 값 저장
// BoardDAO bdao 객체 생성
// int check = numCheck(num,pass) 메서드 호출
// check ==1 이면 updateBoard(bb)호출 content.jsp?num=값&pageNum=값
// check ==0 이면 "비밀번호 틀림" 뒤로 이동


request.setCharacterEncoding("utf-8");
String id = (String)session.getAttribute("id");

String numStr = request.getParameter("num");
String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(numStr);

String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

BoardBean bb = new BoardBean();
bb.setNum(num);
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);

BoardDAO bdao = new BoardDAO();

int check = bdao.numCheck(num, pass);

if(check==0){
%>	
	<script type="text/javascript">			
	alert('비밀번호가 틀렸습니다.');
	alert('다시 입력해주세요.');	
	history.back();
	</script><% 	
}
else if (check==-1){
%>	
	<script type="text/javascript">			
	alert('게시글 수정 오류');	
	history.back();
	</script><% 	
}
else if (check==1){
	int result = bdao.updateBoard(bb);
	if(result>=0){
		%>
		<script type="text/javascript">		
			alert('게시글이 수정되었습니다.');
			location.href="content.jsp?num=<%=num %>&pageNum=<%=pageNum%>";
		</script>
		<% 
	}else{
		%>
		<script type="text/javascript">		
			alert('게시글 수정 오류 :<%=result %>');
			history.back();
		</script>
		<% 
	}
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