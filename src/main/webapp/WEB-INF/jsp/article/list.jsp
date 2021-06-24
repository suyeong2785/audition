<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<c:set var="pageTitle" value="게시물 페이지"/>
<%@ include file="../part/head.jspf" %>

	<div class="table-box con">
		<table>
			<colgroup>
				<col width="100">
				<col width="200">
			</colgroup>
			<thead>
				<tr>
					<th>
					번호
					</th>
					<th>
					등록날짜
					</th>
					<th>
					제목
					</th>	
				</tr>
			</thead>
			<tbody>	
				<c:forEach var="article" items="${articles}" varStatus="status">
					<tr>
						<td>
							<c:out value="${article.id}"></c:out>		
						</td>
						<td>
							<c:out value="${article.regDate}"></c:out>		
						</td>
						<td>
							<c:out value="${article.title}"></c:out>		
						</td>		
					</tr>
				</c:forEach>
			</tbody>
		</table>	
	</div>
	
<%@ include file="../part/foot.jspf" %>