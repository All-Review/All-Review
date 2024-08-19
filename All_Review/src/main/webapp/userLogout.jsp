<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
	session.invalidate();
// 	response.sendRedirect("index.jsp");
%>
<script>
	location.href = 'index.jsp';
</script>