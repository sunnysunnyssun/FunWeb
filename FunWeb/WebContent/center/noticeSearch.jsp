<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
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

<%
request.setCharacterEncoding("utf-8");
String search=request.getParameter("search");
int type = Integer.parseInt(request.getParameter("type"));
BoardDAO bdao = new BoardDAO();

//검색어를 포함하는 게시판 글개수
// 메서드 오버로딩
int count=bdao.getBoardCount(search,type);
int pageSize = 10;

String pageNum = request.getParameter("pageNum");
if(pageNum==null){pageNum="1";}
int currentPage = Integer.parseInt(pageNum);

int startRow = (currentPage-1) * pageSize +1;
int endRow = startRow * pageSize;
List<BoardBean> boardList = null;
if(count!=0){
	boardList = bdao.getBoardList(startRow, pageSize, search,type);
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");	

int num = count-(currentPage-1)*pageSize;	

%>
<!-- 게시판 --><article>
<h1>Notice [전체 글 개수 : <%=count%> ]</h1>
<table id="notice">
	<tr><th class="tno">No.</th>
	    <th class="ttitle">Title</th>
	    <th class="twrite">Writer</th>
	    <th class="tdate">Date</th>
	    <th class="tread">Read</th>
	</tr>	  
	  
	<!-- 반복문     -->
	<%
		if(count!=0){
			for(int i=0; i<boardList.size(); i++){	
			BoardBean bb = boardList.get(i);
	%>
		<tr>
			<td><%= num-- %></td>
			<td class="left"><%= bb.getSubject()%></td>
			<td><%= bb.getName()%></td>
			<td><%= sdf.format(bb.getDate())%></td>
			<td><%= bb.getReadcount()%></td>
		</tr>
	<% }} %>
</table>
<div id="table_search">  <!-- 목록 -->
<input type="button" name="list" class="btn" onclick="location.href='notice.jsp'" value="list">
</div>


<div id="table_search">	
<form action="noticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>

<div class="clear"></div>
<div id="page_control">
<%
String id = (String)session.getAttribute("id");
if(id!=null){	// 로그인되어있으면 글쓰기버튼 활성
%> 
	<!-- 글쓰기 버튼 -->
	<div id="table_search">	
	<input type="button" value="글쓰기" class="btn" onclick="location.href='writeForm.jsp'">
	</div>
<%
}


if(count!=0){
	int pageCount = count/pageSize==0? count/pageSize: (count/pageSize)+1;
	int pageBlock = 10; 
	
	/////////////////////////////////// 
	int startPage =(currentPage-1)/pageBlock*pageBlock +1;	
	int endPage = startPage + pageBlock-1;
	
	if(pageCount<endPage){
		endPage=pageCount;
	}
	
	
	/////////////////////////// 수정////////////////////////////////////////////////
	
	if(startPage>pageBlock){ 	
		// 이전페이지 버튼 활성
		%><a href="noticeSearch.jsp?pageNum=<%=startPage-pageBlock%>&serach=<%=search%>">
		Prev</a>
		<%
	}
	for(int i = startPage; i<=endPage; i++){
		if(i==currentPage){ 
			%><b><a href="noticeSearch.jsp?pageNum=<%=i %>&serach=<%=search%>"><%=i %></a></b><%
		}
		else{
			%><a href="noticeSearch.jsp?pageNum=<%=i %>&serach=<%=search%>"><%=i %></a><%
		}
	}
	if(endPage>pageBlock){ 	
		%><a href="noticeSearch.jsp?pageNum=<%=startPage+pageBlock%>&serach=<%=search%>">
		Next</a>
		<%		
	}
}
%>

</div>
</article>


<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />

<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>