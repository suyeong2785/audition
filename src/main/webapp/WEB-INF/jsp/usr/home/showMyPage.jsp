<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="마이 페이지" />
<%@ include file="../part/head.jspf"%>

<h2 class="con">프로필</h2>


<div class="profile-box con border-2 border-black box-border">gg</div>

<h2 class="con">지원한 공고들</h2>

<div class="list-box con">
	<div class="flex justify-center border-2 border-black box-border p-4">
		<div class="text-center ">알림</div>
	</div>
</div>
<div class="list-box con">
	<c:forEach items="${applymentResults}" var="applymentResult">
		<div class="toggle">
			<div class="flex border-2 border-black box-border p-4">
				<div class=" flex-1">${applymentResult.forPrintApplymentResult}</div>
				
			</div>
		</div>
	</c:forEach>
</div>
<%@ include file="../part/foot.jspf"%>