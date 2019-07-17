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

<%
// 전체 글 개수
// BoardDAO bado
// int count=getBoardCount() 함수 생성 - 전체 글의 개수 

BoardDAO bdao = new BoardDAO();
int count = bdao.getBoardCount();
// 현페이지 글 가져오기

// 한페이지에 가져올 글 개수
int pageSize = 10;

// pageNum 가져오기
// pageNum이 없으면 "1" 설정
String pageNum = request.getParameter("pageNum");

if(pageNum==null){
	pageNum="1";
}

// int currentPage = pageNum 정수형 
int currentPage = Integer.parseInt(pageNum);

// int startRow = 구하기
// int endRow = 구하기
int startRow = (currentPage-1) * pageSize +1;
int endRow = startRow * pageSize;

// 게시판 글 있으면
// List<BoardBean> boardList = getBoardList(시작행, 가져올 글 개수)

List<BoardBean> boardList = null;

if(count!=0){
	boardList = bdao.getBoardList(startRow, pageSize);
}
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");	// 내장객체 날짜형태 교환하는 자바 내장객체 

// 화면에 보여지는 글번호 구하기
// int num = count =
// 전체글개수 20이라 가정 (count)
// count 	currentPage(pageNum) 	 pageSize 	 				  시작 글 번호 							끝 글번호
// 	20				1					10		 20 -0   => 20-(currentpage-1)*10	= 20			20-10
// 	20				2					10		 20 -10  => 20-(currentpage-1)*10	= 10			10-10

int num = count-(currentPage-1)*pageSize;	// 게시판에서 디비의 num이 아니라 노출되는 게시글 수에 따라 매겨지도록 한 넘버링






%>

<!-- 게시판 -->
<article>
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
<%
// String id = 세션값 가져오기
// 세션값이 있으면 (로그인이 되어 있으면) 글쓰기 버튼 보이기
String id = (String)session.getAttribute("id");

if(id!=null){
%> 
<div id="table_search">	<!-- 글쓰기 버튼 복사 -->
<input type="button" value="글쓰기" class="btn" onclick="location.href='writeForm.jsp'">
</div>
<%
}


// 게시판에 글이 있으면 전체 페이지 수 구하기
// int pageCount = 전체글 개수 / 한화면에 보여줄 글 개수+(조건?참:거짓);
if(count!=0){
int pageCount = count/pageSize==0? count/pageSize: (count/pageSize)+1;

// 페이지 단위. 10개 페이지 보여줌
int pageBlock = 10; 


//한화면에 보여줄 시작페이지 번호 
// 한화면에 보여줄 페이지의 끝 번호 구하기

/////////////////////////////////// 얘가 젤 이해안됨................
int startPage =(currentPage-1)/pageBlock*pageBlock +1;	
int endPage = startPage + pageBlock-1;


// 만약 페이지 갯수가 페이지 끝페이지보다 작다면, 끝페이지는 페이지 갯수만큼으로 줄인다.
if(pageCount<endPage){
	endPage=pageCount;
}


// 시작하는 페이지가 페이지 노출단위보다 크면 시작하는 페이지가 11인데 노출단위는 10이면
// 이전 페이지 버튼를 보여줄 것.
if(startPage>pageBlock){ 	
	// 이전페이지 버튼 활성
	%><a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">
	이전</a>
	<%
}

// else{ // 시작하는 페이지가 페이지 노출단위보다 작다면?
// 	// 이전페이지버튼 비활성
// }


// 페이지 번호 노출

	for(int i = startPage; i<=endPage; i++){
		if(i==currentPage){ // 현재페이지가 스타트 페이지와 같다면? -> 현재 활성페이지
				// 굵은 표시	
			%><b><a href="notice.jsp?pageNum=<%=i %>"><%=i %></a></b><%
		}
		else{
			// 아닌 것은 그냥 표시만
			%><a href="notice.jsp?pageNum=<%=i %>"><%=i %></a><%
		}
	}
if(endPage>pageBlock){ 	// 끝페이지보다 페이지 블럭이 크다면?
		// 다음페이지 버튼 활성
	%><a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">
	다음</a>
	<%		
}

// else{ // 이건 위에 이미 같게 활성을 시켰으니, 같은경우임. 그럼 
// 	// 다음페이지 비활성
// }
}
%>

<div id="table_search">	
<form action="noticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
</div>


<!-- 
<div class="clear"></div>
<div id="page_control">
<a href="#">Prev</a>
<a href="#">1</a><a href="#">2</a><a href="#">3</a>
<a href="#">4</a><a href="#">5</a><a href="#">6</a>
<a href="#">7</a><a href="#">8</a><a href="#">9</a>
<a href="#">10</a>
<a href="#">Next</a>
</div> -->


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