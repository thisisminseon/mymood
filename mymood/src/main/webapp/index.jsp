<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// トップページは商品一覧（未ログインでも閲覧可）
	response.sendRedirect("select-servlet");
%>
