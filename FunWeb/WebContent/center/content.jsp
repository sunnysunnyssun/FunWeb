<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentDTO"%>
<%@page import="java.util.List"%>
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
	response.sendRedirect("notice.jsp");
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

SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h1>Notice Content</h1>
<table id="notice">
    
<tr><th class="twrite">글번호</th><td class="ttitle"><%=num%></td><th class="twrite">조회수</th><td class="ttitle"><%=bb.getReadcount()+1%></td></tr>
<tr><th class="twrite">작성자</th><td class="ttitle"><%=bb.getName()%></td><th class="twrite">작성일</th><td class="ttitle"><%=bb.getDate()%></td></tr>
<tr><th class="twrite">제목</th><td colspan="3"><%=bb.getSubject()%></td></tr>
<tr><th colspan="4" class="twrite">글내용</th></tr>
<tr><td colspan="4" class="ttitle"><%=content%></td></tr>
    
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
	<input type="button" value="글수정" class="btn" onclick="location.href='updateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<input type="button" value="글삭제" class="btn" onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<%
		}
		}
	%>

<input type="button" name="list" class="btn" onclick="location.href='notice.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>'" value="list">
</div>

<%
	if(id!=null){	// 로그인되어있으면 글쓰기버튼 활성
%> 
	<!-- 글쓰기 버튼 -->
	<div id="table_search">	
	<input type="button" value="글쓰기" class="btn" onclick="location.href='writeForm.jsp'">
	</div>
<%
	}
%>


<div class= "commentArea">

<!-- 댓글 작성 창 // 회원이 로그인 했을때만 활성화되거나 보임.-->

<%
	if(id!=null){   // 로그인되어있으면 글쓰기버튼 활성
%> 
<form action="contentPro.jsp" method="post" name="fr">
    <div class="commetnWrite">
		<input type="hidden" name="boardNum" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
        <input type="hidden" name="name" value="<%=id%>">
		
        <table id="CtWirte" style="margin: 0 auto;">
        
            <tr><td colspan="2">작성자 : <input type="text" name="id" value="<%=id%>" disabled></td></tr>
            <tr><td rowspan="2"><textarea rows="4" cols="60" placeholder="댓글 내용을 입력하세요" name="content"></textarea></td>
            <td><input type="submit" value="작성"></td></tr>
            <tr><td><input type="reset" value="취소"></td></tr>
            
        </table>
    </div>  <!--  commentWirte 완료 -->
</form>
 <%
 	}
 %>   
    
    <div class="commentList">
    
        <%
            	CommentDAO cdao = new CommentDAO();
                                List<CommentDTO> cList = new ArrayList<>();
                                cList = cdao.getCommentList(num);
            %>    
            <table style="margin: 0 auto; border-collapse: collapse; border: 1px solid #ddd">
        <%
        	if(cList!=null){ 
                    for(int i=0; i<cList.size(); i++){
        	        CommentDTO cdto = cList.get(i);
        %>
            <tr><td style="border: 1px solid #ddd;" >작성자 : <%=cdto.getName() %></td><td style="border: 1px solid #ddd;" >작성날짜 : <%=sdf.format(cdto.getDate()) %></td></tr>
	            <tr><td colspan="2" style="border: 1px solid #ddd;" ><%=cdto.getContnet() %></td></tr>
            <%}
          } %>        	
            </table>
   
    
        
    
    
    </div>  <!--  commentList 완료 -->


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