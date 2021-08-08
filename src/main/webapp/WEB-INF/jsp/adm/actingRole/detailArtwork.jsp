<%@ page import="com.quantom.audition.util.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../part/head.jspf"%>

<div class="con">
	<div class=" flex flex-col">
		<div class="flex items-center justify-center max-h-96 overflow-hidden">
			<img src="/resource/img/banner1.jpg" alt="" />
		</div>
		<div class="p-6">
			<div>
				<span>번호</span>
				<span>${artwork.id}</span>
			</div>
			<div>
				<span>name</span>
				<span>${artwork.name}</span>
			</div>

			<div>
				<span>productionName</span>
				<span>${artwork.productionName}</span>
			</div>

			<div>
				<span>directorName</span>
				<span>${artwork.directorName}</span>
			</div>
			<div class="pt-4 text-sm">
				<span>${artwork.regDate}</span>
			</div>
		</div>
	</div>
</div>
<div class="bg-gray-100">
	<div class="con p-6">
		<span class="text-sm">내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용
			내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용
			내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용 내용
			내용 내용 내용 내용 </span>
		<span>${artwork.etc}</span>
	</div>
</div>


<div class="btn-box con margin-top-20">
	<a class="btn btn-info"
		href="modifyArtwork?id=${artwork.id}&listUrl=${Util.getUriEncoded(listUrl)}">수정</a>
	<a class="btn btn-danger"
		href="doDeleteArtwork?id=${artwork.id}&listUrl=${Util.getUriEncoded(listUrl)}"
		onclick="if ( confirm('삭제하시겠습니까?') == false ) return false;">삭제</a>

	<a href="${listUrl}" class="btn btn-info">목록</a>
</div>


<%@ include file="../part/foot.jspf"%>