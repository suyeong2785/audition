<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../part/head.jspf"%>
<div class="con mx-auto px-4">
	<div class="grid grid-columns-showCommonMyPage">
		<div
			class="flex justify-center items-center flex-grow border-t border-black py-8">Actor</div>
		<div
			class="flex flex-col items-center flex-grow border-t border-gray-300 ml-2.5 py-8">
			<div>
				<a href="/usr/home/showMyPage">내정보(연기자)</a>
			</div>
			<div class="my-8">
				<a href="/usr/home/showMyAudition">내가 지원한 오디션</a>
			</div>
			<div>
				<a href="">관심오디션</a>
			</div>
		</div>
	</div>

	<div class="grid grid-columns-showCommonMyPage">
		<div
			class="flex justify-center items-center flex-grow border-t border-b border-black py-8">Director</div>
		<div
			class="flex flex-col items-center flex-grow border-t border-b border-gray-300 ml-2.5 py-8">
			<div>
				<a href="">내정보(캐스팅 담당자)</a>
			</div>
			<div class="my-8">
				<a href="../../adm/actingRole/artworkList">진행중인 캐스팅</a>
			</div>
			<div>
				<a href="../../adm/home/showMyPage">진행중인 오디션</a>
			</div>
		</div>
	</div>
</div>
<%@ include file="../part/foot.jspf"%>