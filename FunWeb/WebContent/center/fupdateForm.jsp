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
	response.sendRedirect("fnotice.jsp");
}

String id = (String)session.getAttribute("id");
if (id != null){
	if(!id.equals(bb.getName())){
	%>
	<script type="text/javascript">		
		alert('글수정 권한이 없습니다.');
		location.href='fcontent.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
	</script>
	<% 
	}
}

String content=bb.getContent();


%>
<article>
<h1>Notice Content</h1>
<form action="fupdateFormPro.jsp?pageNum=<%=pageNum %>" method="post" enctype="multipart/form-data">
<!-- method="post" 아니라 get인경우 pageNUm= %=pageNum % 변수값을 가지고 가지 않음 -->
<input type="hidden" name="num" value="<%=num %>">

<table id="notice">
<tr>
	<th class="twrite">글번호</th><td class="ttitle"><%=pageNum %></td>
	<th class="twrite">비밀번호</th><td class="ttitle"><input type="password" name="pass"></td>
</tr>
<tr>
	<th class="twrite">작성자</th><td class="ttitle"><%=bb.getName() %></td>
	<th class="twrite">작성일</th><td class="ttitle"><%=bb.getDate() %></td>
</tr>
<tr>
	<th class="twrite">제목</th><td colspan="3"><input type="text" name="subject" size="78" value="<%= bb.getSubject()%>"></td>
</tr>
<tr>
	<th colspan="4" class="twrite">글내용</th>
</tr>
<tr>
	<td colspan="4" class="ttitle"><textarea name="content" rows="10" cols="58"><%=bb.getContent() %></textarea></td>
</tr>
<%
if(bb.getFile()==null){%>
<tr>
	<td class="twrite">파일</td>
    <td class="ttitle" colspan="3"><input type="file" name="file" size="62"></td>
</tr>    
<% 
}
else{%>
<tr>
<td class="twrite">파일</td> 
<td class="ttitle" colspan="3"><a href="../upload/<%=bb.getFile() %>"><img src="../upload/<%=bb.getFile() %>" width="200"></a><br>
<%=bb.getFile() %> <input type="hidden" name="orifile" value="<%=bb.getFile() %>">
</td>
</tr>    
<tr>
	<td class="twrite">파일수정</td>
    <td class="ttitle" colspan="3"><input type="file" name="file" size="62"></td>
</tr>   

<%	
}
%>





</table>

<div id="table_search">  <!-- 아이콘 -->
	<input type="submit" value="수정" class="btn">
	<input type="button" name="list" class="btn" onclick="location.href='fnotice.jsp?num=<%=num %> &pageNum=<%=pageNum %>'" value="list">
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