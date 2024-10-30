<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
    if (session != null) {
        session.invalidate();
    }

    // 클라이언트 측 쿠키 삭제
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("JSESSIONID")) {
                cookie.setMaxAge(0); // 쿠키 만료
                cookie.setPath("/"); // 쿠키가 유효한 경로 설정
                response.addCookie(cookie);
            }
        }
    }

    // 브라우저 캐시 방지
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.

    response.sendRedirect("index.jsp");
%>
