<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String sessionid;
int level;
if (session.getAttribute("sessionid") != null) { //세션에서 받아온 id가 null이 아니면
	sessionid = (String) session.getAttribute("sessionid"); //sessionid에 id값 저장
	level = (int) session.getAttribute("level"); //level에 level값 저장
	out.println("id : <strong>" + sessionid + "</strong>님 반갑습니다."); 
} else {
	response.sendRedirect("login.jsp");
	return;
}
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String driver = "org.mariadb.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/testdb3";

try {
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "java", "java");

	String sql = "SELECT * FROM member";
	pstmt = conn.prepareStatement(sql);

	rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버리스트</title>
</head>
<body>
	<%
	if (level == 5) { //loginProcess에서 세션으로 받아온 level이 5라면 관리자모드 이므로 테이블 보여줌
	%>
	<table border="1">
		<caption>회원목록</caption>
		<thead>
			<tr>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이메일</th>
				<th>휴대번호</th>
				<th>생년월일</th>
				<th>등록일자</th>
			</tr>
		</thead>
		<tbody>
			<%
			while (rs.next()) {
				String id = rs.getString("id");
				String pass = rs.getString("pass");
				String email = rs.getString("email");
				String phone = rs.getString("phone");
				String birth = rs.getString("birth");
				String regdate = rs.getString("regdate");
			%>
			<tr>
				<td><%=id%></td>
				<td><%=pass%></td>
				<td><%=email%></td>
				<td><%=phone%></td>
				<td><%=birth%></td>
				<td><%=regdate%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
	<%
	} else { //아니면 그냥 환영합니다 띄움
	%>
	<h3>환영합니다!</h3>
	<%
	}
	%>
	<a href="logout.jsp">로그아웃</a>
</body>
</html>
<%
} catch (ClassNotFoundException e) {
e.printStackTrace();
} catch (SQLException e) {
e.printStackTrace();
} catch (Exception e) {
e.printStackTrace();
} finally {
try {
	rs.close();
	pstmt.close();
	conn.close();
} catch (SQLException e) {
	e.printStackTrace();
}
}
%>