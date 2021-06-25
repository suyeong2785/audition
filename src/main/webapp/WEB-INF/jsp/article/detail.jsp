<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시물 상세페이지" />
<%@ include file="../part/head.jspf"%>

<div class="table-box con">
	<table>
		<tbody>
			<tr>
				<th>번호</th>
				<td>${article.id}</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${article.regDate}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${article.title}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${article.body}</td>
			</tr>
		</tbody>
	</table>
</div>

<c:if test="${isLogined}">
	<h2 class="con">댓글 작성</h2>

	<script>
		function ArticleWriteReplyForm__submit(form) {
			form.body.value = form.body.value.trim();
			if (form.body.value.length == 0) {
				alert('댓글을 입력해주세요.');
				form.body.focus();
				return;
			}
			$.post('./doWriteReplyAjax', {
				articleId : param.id,
				body : form.body.value
			}, function(data) {
				alert(data.msg);
			}, 'json');
			form.body.value = '';
		}
	</script>

	<form class="table-box con form1" action=""
		onsubmit="ArticleWriteReplyForm__submit(this); return false;">

		<table>
			<tbody>
				<tr>
					<th>내용</th>
					<td>
						<div class="form-control-box">
							<textarea maxlength="300" name="body" placeholder="내용을 입력해주세요."
								class="height-300"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>작성</th>
					<td><input type="submit" value="작성"></td>
				</tr>
			</tbody>
		</table>
	</form>
</c:if>

<h2 class="con">댓글 리스트</h2>

<button onclick="ArticleReplyList__drawReply()">추가</button>

<div class="article-reply-list-box table-box con">
	<table>
		<colgroup>
			<col width="80">
			<col width="180">
			<col width="180">
			<col>
			<col width="200">
		</colgroup>
		<thead>
			<tr>
				<td>번호</td>
				<td>날짜</td>
				<td>작성자</td>
				<td>내용</td>
				<td>비고</td>
			</tr>
		</thead>
		<tbody>

		</tbody>
	</table>
</div>


<script>
	var ArticleReplyList__$box = $('.article-reply-list-box');
	var ArticleReplyList__$tbody = ArticleReplyList__$box.find('tbody');

	var ArticleReplyList__lastLoadedId = 0;

	function ArticleReplyList__loadMore() {
		$.get('getForPrintArticleReplies', {
			articleId : param.id,
			from : ArticleReplyList__lastLoadedId + 1
		}, function(data) {
			if ( data.body.articleReplies && data.body.articleReplies.length > 0 ) {
				ArticleReplyList__lastLoadedId = data.body.articleReplies[data.body.articleReplies.length - 1].id;
				ArticleReplyList__drawReplies(data.body.articleReplies);
			}
			setTimeout(ArticleReplyList__loadMore, 10000);
		}, 'json');
	}
	
	function ArticleReplyList__drawReplies(articleReplies) {
		for ( var i = 0; i < articleReplies.length; i++ ) {
			var articleReply = articleReplies[i];
			ArticleReplyList__drawReply(articleReply);
		}
	}
	
	function ArticleReplyList__deleteReplyAjax(el) {
		var $tr = $(el).closest('tr');
		var id = $tr.attr('reply-id');
		
		$.post(
				"doDeleteArticleReplyAjax",
				{
					id:id
				},
				function (data){
					$tr.remove();
				},
				'json'
		);
		
	}

	function ArticleReplyList__drawReply(articleReply) {
		var html = '';
		html += '<tr reply-id='+ articleReply.id +'>';
		html += '<td>' + articleReply.id + '</td>';
		html += '<td>' + articleReply.regDate + '</td>';
		html += '<td>' + 11 + '</td>';
		html += '<td>' + articleReply.body + '</td>';
		html += '<td><button onclick="ArticleReplyList__deleteReplyAjax(this); return false;">삭제</button></td>';
		html += '</tr>';
		
		ArticleReplyList__$tbody.prepend(html);
	}
	
	ArticleReplyList__loadMore();
</script>

<%@ include file="../part/foot.jspf"%>