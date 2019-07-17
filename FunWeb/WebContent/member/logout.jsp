<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginPr.jsp</title>
</head>
<body>

<%
session.invalidate();
%>
<script type="text/javascript">
	alert('로그아웃 되었습니다.');
	location.href="../main/main.jsp";
// 	history.back(); 이거하니깐 세션값이 안없어짐.
</script>

</body>
</html>