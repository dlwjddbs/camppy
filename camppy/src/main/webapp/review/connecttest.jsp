<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>MySQL ���� ����̹� �׽�Ʈ</title>
</head>
<body>
	<h1>MySQL ���� ����̹� �׽�Ʈ</h1>
	<%
		String jdbcUrl = "jdbc:mysql://itwillbs.com:3306/c1d2304t3";
		String dbId = "c1d2304t3";
		String dbPwd = "1234";
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			Connection connection = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);
			out.println("MySQL ���� ����");
		}
		catch (Exception ex)
		{
			out.println("���� �����Դϴ�. ���� �޽��� : " + ex.getMessage());
		}
	%>
</body>
</html>