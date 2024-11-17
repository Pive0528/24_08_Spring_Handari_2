<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="글 수정"></c:set>
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>
<hr />

<script type="text/javascript">
	function ArticleModify__submit(form) {

		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용 써');
			editor.focus();
			return;
		}
		form.body.value = markdown;

		form.submit();
	}
</script>

<section class="mt-6 text-xl px-4">
	<div class="mx-auto max-w-screen-lg">
		<form onsubmit="ArticleModify__submit(this); return false;" action=" ../article/doModify" method="POST">
			<input type="hidden" name="id" value="${article.id}" /> <input type="hidden" name="body">
			<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
				<tbody>
					<tr>
						<th style="text-align: left; white-space: nowrap;">번호</th>
						<td style="text-align: left;">${article.id}</td>
					</tr>
					<tr>
						<th style="text-align: left;white-space: nowrap;">작성 날짜</th>
						<!-- 원래는 세부 날짜임 -->
						<td style="text-align: left;">${article.updateDate}</td>
					</tr>
					<tr>
						<th style="text-align: left; white-space: nowrap;">작성자</th>
						<td style="text-align: left;">${article.extra__writer}</td>
					</tr>
					<tr>
						<th style="text-align: left; white-space: nowrap;">제목</th>
						<td style="text-align: left;"><input name="title" value="${article.title}" type="text" autocomplete="off"
							placeholder="새 제목을 입력해주세요." class="input input-bordered input-primary w-full max-w-xs input-sm " /></td>
					</tr>
					<tr>
						<th style="text-align: left;">Body</th>
						<td style="text-align: left;">
							<%-- 							<input name="body" value="${article.body}" type="text" autocomplete="off" placeholder="새 내용을 입력해" --%>
							<!-- 								class="input input-bordered input-primary w-full max-w-xs input-sm " /> -->
							<div class="toast-ui-editor">
								<script type="text/x-template">${article.body }
      </script>
							</div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td style="text-align: center;">
							<button class="btn btn-primary">수정</button>
						</td>
					</tr>

				</tbody>
			</table>
		</form>
		<div class="btns">
			<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
			<c:if test="${article.userCanDelete }">
				<a class="btn" a onclick="if(confirm('정말 삭제 하시겠습니까?') == false) return false;"
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>

		</div>
	</div>
</section>

<%@ include file="../common/foot.jspf"%>
