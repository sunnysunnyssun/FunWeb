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
<li><a href="../center/notice.jsp">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="../center/fnotice.jsp">Driver Download</a></li>
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

BoardDAO bdao = new BoardDAO();
BoardBean bb = new BoardBean();

bb = bdao.getBoard(num);

if(numStr==null){
	response.sendRedirect("notice.jsp");
}

String id = (String)session.getAttribute("id");
if (id != null){
	if(!id.equals(bb.getName())){
	%>
	<script type="text/javascript">		
		alert('글수정 권한이 없습니다.');
		location.href='content.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
	</script>
	<% 
	}
}

String content=bb.getContent();


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