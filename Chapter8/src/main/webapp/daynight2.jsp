<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie cookie = new Cookie("day", request.getParameter("day"));
	cookie.setMaxAge(60*60*24);
	response.addCookie(cookie);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	location.href = "daynight1.jsp";
</script>
</head>
<body>

</body>
</html>