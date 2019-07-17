
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FilFormPro</title>
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


<!-- 게시판 -->

<%
// 한글처리 필요없음. 
// 업로드하는 프로그램에 한글처리가 포함되어 있음
// cos.jar 설치 WEB-INF/lib/cos.jar 
// 업로드 폴더 만들기 (데이터베이스에는 파일이름만 저장, 업로드폴더에는 실제파일이 저장되도록)
// upload 물리적 경로
String realPath = request.getRealPath("/upload");
// System.out.println(realPath);	// 가상경로
// 업로드할 파일의 크기 제한
int maxSize = 5*1024*1024; // 5mb가로 파일 크기 제한

// MultipartRequest 객체 생성 하면 업로드 완룝
MultipartRequest multi = new MultipartRequest(request,realPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		

String id = (String)session.getAttribute("id");

String name = multi.getParameter("name");
String pass = multi.getParameter("pass");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
String file = multi.getFilesystemName("file");

BoardBean bb = new BoardBean();

bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setFile(file);

BoardDAO bdao = new BoardDAO();

int result = bdao.insertBoard(bb);

if (result==1) {
	response.sendRedirect("fnotice.jsp");
}
else{
%> 
	<script type="text/javascript">		
	alert('글쓰기 오류 발생');
	history.back();
// 	location.href='../member/login.jsp';
	</script>
	<%	
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