<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../part/head.jspf"%>
<div class="con mx-auto ">
	<div class="grid grid-columns-showCommonMyPage">
		<div
			class="flex justify-center items-center flex-grow border-t border-b border-black py-8 text-xl">${loginedMember.name}</div>
		<div
			class="flex flex-col items-center flex-grow border-t border-b border-gray-300 ml-2.5 py-8">
			<a href="/usr/home/showMyPage">
				<div class="py-4">내정보(연기자)</div>
			</a>
			<a href="/usr/home/showMyAudition">
				<div class="py-4">내가 지원한 오디션</div>
			</a>
			<a href="">
				<div class="py-4">관심오디션</div>
			</a>
			<a href="">
				<div class="py-4">내정보(캐스팅 담당자)</div>
			</a>
			<a href="../../adm/actingRole/artworkList">
				<div class="py-4">진행중인 캐스팅</div>
			</a>
			<a href="../../adm/home/showMyPage">
				<div class="py-4">진행중인 오디션</div>
			</a>
		</div>
	</div>


</div>
<%@ include file="../part/foot.jspf"%>