<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
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
<%
// 전체 글 개수
// BoardDAO bado
// int count=getBoardCount() 함수 생성 - 전체 글의 개수 

// 현페이지 글 가져오기



%>

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

<%
String id = (String)session.getAttribute("id");

if(id==null){
%> 
	<script type="text/javascript">		
	alert('글쓰기 권한이 없습니다. 로그인해주십시오.');
	location.href='../member/login.jsp';
	</script>
<%	
}
%>
<article>
<h1>Notice Write</h1>
<form action="writePro.jsp" method="post" name="">
<input type="hidden" name="type" value="0">

<table id="notice">
<tr><td class="twrite">글쓴이</td>
   <td class="ttitle">
   <input type="text" name="name" value="<%=id%>" readonly></td>
	<td class="twrite">비밀번호</td>
    <td class="ttitle"><input type="password" name="pass"></td></tr>
<tr><td class="twrite">제목</td>
    <td class="ttitle" colspan="3"><input type="text" name="subject" size="78"></td></tr>
<tr><td class="twrite" >글내용</td>
    <td class="ttitle" colspan="3"><textarea name="content" rows="10" cols="58"></textarea></td></tr>
</table>

<div id="table_search">	
<input type="submit" value="글쓰기" class="btn">
</div>

</form>


<div class="clear"></div>

<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />

<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>