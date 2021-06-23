<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 페이지</title>
</head>
<body>
	<h1>게시물 페이지</h1>
	
	<c:forEach var="article" items="${articles}" varStatus="status">
		<c:out value="${article}"></c:out>
		<br />
	</c:forEach>
</body>
</html>