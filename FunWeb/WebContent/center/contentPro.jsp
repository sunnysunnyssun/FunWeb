<%@page import="comment.CommentDAO"%>
<%@page import="comment.CommentDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%
	request.setCharacterEncoding("utf-8");
int pageNum = Integer.parseInt(request.getParameter("pageNum"));
int boardNum = Integer.parseInt(request.getParameter("boardNum"));

Timestamp date = new Timestamp(System.currentTimeMillis());
String content = request.getParameter("content");
// String name = request.getParameter("id"); 
String name = request.getParameter("name"); 

System.out.println(name);
CommentDTO cdto = new CommentDTO(name, content, date, boardNum);
CommentDAO cdao = new CommentDAO();
int result = cdao.insertComment(cdto);
if(result==1){
%>
    <script type="text/javascript">     
        alert('댓글이 등록되었습니다.');
        location.href="content.jsp?num=<%=boardNum%>&pageNum=<%=pageNum%>";
    </script>
    <% 
}else{
    %>
    <script type="text/javascript">     
        alert('댓글 작성 실패');
        history.back();
    </script>
    <% 
}
%>


</body>
</html>