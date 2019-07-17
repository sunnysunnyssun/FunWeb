<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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

<%
//num , pageNum 파라미터 가져오기
//BoardDAO bdao 객체생성
//조회수 증가
//updateReadcount(num)
//BoardBean bb  =  getBoard(num) 메서드호출


%>


<!-- 게시판 -->

<%
// num , pageNum 가져오기
// boardDAO 
// 조회수 증가
// updateReadcount(num);
// BoardBean bb = getBoard(num); 메서드 호출 

String numStr = request.getParameter("num");
String pageNum = request.getParameter("pageNum");

if(numStr==null){
	response.sendRedirect("fnotice.jsp");
}

int num = Integer.parseInt(numStr);

BoardDAO bdao = new BoardDAO();
BoardBean bb = new BoardBean();

bb = bdao.getBoard(num);
bdao.updateReadcount(num);

String content=bb.getContent();
if(content!=null){
	//	\r\n (자바기반에서 엔터키 입력시 입력되는 문자열) => <br>로 바꿔서 나타나야함.
	//   문자열.replace("old문자열","new문자열")
	content=content.replace("\r\n", "<br>");	
}


%>
<article>
<h1>Notice Content</h1>
<form action="writePro.jsp" method="post" enctype="multipart/form-data">
<table id="notice">
<tr><th class="twrite">글번호</th><td class="ttitle"><%=num %></td><th class="twrite">조회수</th><td class="ttitle"><%=bb.getReadcount()+1 %></td></tr>
<tr><th class="twrite">작성자</th><td class="ttitle"><%=bb.getName() %></td><th class="twrite">작성일</th><td class="ttitle"><%=bb.getDate() %></td></tr>
<tr><th class="twrite">제목</th><td colspan="3"><%=bb.getSubject() %></td></tr>
<tr><th colspan="4" class="twrite">글내용</th></tr>
<tr><td colspan="4" class="ttitle"><%=content %></td></tr>
<tr><th class="twrite">파일</th><td colspan="3">
<a href="../upload/<%=bb.getFile() %>"><img src="../upload/<%=bb.getFile() %>" width="200"></a><br>
<%=bb.getFile() %> <a href="file_down.jsp?file_name=<%=bb.getFile() %>"> 파일다운받기 </a>	
<!-- 파일네임은 다 다르다. 만약 같은 파일이있으면 다른 이름으로 대처하도록 처음에 설정을 해놨음 -->
<!-- 이클립스는 가상으로 동작하기때문에 실제 upload파일에 파일이 있지 않고, 이클립스의 데이터 공간내에 upload파일에 저장되어있음. 무튼 저렇게 하면 알아서 경로찾아서 넣어줌 -->
<!-- 320페이지에 파일이 실행이 되지 않고 다운이 되도록 하는 것이 있음. -->
</td></tr>
</table>
<div id="table_search">  <!-- 목록 -->
<%
// 세션값 가져오기
// 세션값이 있으면
// 세션값과 글의 작성자와 비교하여 일치하면 글수정 글삭제 버튼이 보이기

String id = (String)session.getAttribute("id");
if (id != null){
	if(id.equals(bb.getName())){
	%>
	<input type="button" value="글수정" class="btn" onclick="location.href='fupdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<input type="button" value="글삭제" class="btn" onclick="location.href='fdeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<% 
	}
}
%>

<input type="button" name="list" class="btn" onclick="location.href='fnotice.jsp?num=<%=bb.getNum() %>&pageNum=<%=pageNum %>'" value="list">
</div>

<%
if(id!=null){	// 로그인되어있으면 글쓰기버튼 활성
%> 
	<!-- 글쓰기 버튼 -->
	<div id="table_search">	
	<input type="button" value="글쓰기" class="btn" onclick="location.href='fwriteForm.jsp'">
	</div>
<%} %>
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