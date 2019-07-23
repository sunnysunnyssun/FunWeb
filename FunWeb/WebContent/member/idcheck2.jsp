<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String id = request.getParameter("fid");

MemberDAO mdao = new MemberDAO();

int check = mdao.userCheck(id,"");
    if(check==0 || check==1){
        %>중복된 아이디입니다. <%
    }else if(check==-1){
        %>사용가능한 아이디입니다.
        <%
    }
%>

