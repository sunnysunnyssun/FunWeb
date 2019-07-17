<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateForm</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

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
<!-- 게시판 -->

<!-- 게시판 -->

<%
// num , pageNum 가져오기
// boardDAO 
// BoardBean bb = getBoard(num); 메서드 호출 


String numStr = request.getParameter("num");
String pageNum = request.getParameter("pageNum");
int num = Integer.parseInt(numStr);
String pass= request.getParameter("pass");

BoardDAO bdao = new BoardDAO();


if(numStr==null){
	response.sendRedirect("notice.jsp");
}

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
	alert('게시글 삭제 오류');	
	history.back();
	</script><% 	
}
else if (check==1){
	int result = bdao.deleteBoard(num,pass);
	if(result>=0){
		%>
		<script type="text/javascript">		
			alert('게시글이 삭제되었습니다.');
			location.href="notice.jsp?pageNum=<%=pageNum%>";
		</script>
		<% 
	}else{
		%>
		<script type="text/javascript">		
			alert('게시글 삭제 오류 :<%=result %>');
			history.back();
		</script>
		<% 
	}
}
%>
<article>
<h1>Notice Content</h1>
<form action="deleteFormPro.jsp?pageNum=<%=pageNum %>" method="post" name="">
<!-- method="post" 아니라 get인경우 pageNUm= %=pageNum % 변수값을 가지고 가지 않음 -->
<input type="hidden" name="num" value="<%=num %>">

<table id="notice">
<tr>
	<th>글번호</th><td class="ttitle"><%=pageNum %></td>
</tr>
<tr>
	<th>비밀번호</th><td class="ttitle"><input type="password" name="pass"></td>
</tr>

</table>

<div id="table_search">  <!-- 아이콘 -->
	<input type="submit" value="삭제" class="btn">
	<input type="button" name="list" class="btn" onclick="location.href='notice.jsp?num=<%=num %> &pageNum=<%=pageNum %>'" value="list">
</div>

</form>


<div class="clear"></div>
<div id="page_control">
</div>
</article>
<!-- 게시판 끝 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>