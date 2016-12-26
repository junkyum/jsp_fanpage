<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
// test용
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>twice</title>

<link rel="stylesheet"
	href="<%=cp%>/res/jquery/css/smoothness/jquery-ui.min.css"
	type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet"
	href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css"
	type="text/css" />

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css"
	type="text/css" />

<script type="text/javascript"
	src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function updateNotice(num) {
	<c:if test="${sessionScope.member.userId==dto.userId}">
	     var url="<%=cp%>/notice/update.do?num="+num+"&page=${page}";
	     location.href=url;
	</c:if>
}

function deleteNotice(num) {
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
         if(confirm("게시물을 삭제 하시겠습니까 ?")) {
        	 var url="<%=cp%>/notice/delete.do?num="+num+"&page=${page}";
        	 location.href=url;
         }	
	</c:if>
}
 function download() {
	  if(confirm("다운로드? ?")) {
      }
} 
</script>
</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>
	<div class="container" role="main">
		<div class="bodyFrame col-sm-10"
			style="float: none; margin-left: auto; margin-right: auto;">

			<div class="body-title">
				<h3>
					<span class="glyphicon glyphicon-picture"></span> 공지사항
				</h3>
			</div>

			<div class="alert alert-info">
				<i class="glyphicon glyphicon-info-sign"></i> 공지사항.
			</div>

			<div class="table-responsive" style="clear: both;" >
				<div class="notice-article" >
					<table class="table" >
						<thead>
							<tr>
								<th colspan="2" style="text-align: center;">제목:
									${dto.subject}</th>
							</tr>
						<thead>
						<tbody >
							<tr>
								<%-- <td style="text-align: left;">
	                         		   이름 : ${dto.userName}
	                         	</td> --%>
								<td style="text-align: left;">작성일: ${dto.created}</td>
								<td style="text-align: right;">조회수: ${dto.hitCount }</td>

							</tr>
							<%-- <tr style="border-bottom: none;">
								<td colspan="2"><img
									src="<%=cp%>/uploads/notice/${dto.savefileName}"
									style="max-width: 100%; height: auto; resize: both;"></td>
							</tr> --%>
							<tr>
								<td colspan="2" style="min-height: 30px;">${dto.content}</td>
							</tr>
							<tr>
								<td colspan="2" style="min-height: 30px;" >첨부파일 : <input
									type="button" name="다운로드" value="다운로드" onclick="download();">
								</td>
							</tr>

						</tbody>
						<tfoot>
							<tr>
								<td>
									<%-- <c:if test="${sessionScope.member.userId=='admin'}"> --%>
									<button type="button" class="btn btn-default btn-sm wbtn"
										onclick="updateNotice(${dto.num});">수정</button> <%--  </c:if> --%>
									<%--  <c:if test="${sessionScope.member.userId=='admin'}">  --%>
									<button type="button" class="btn btn-default btn-sm wbtn"
										onclick="deleteNotice(${dto.num});">삭제</button> <%--  </c:if> --%>
								</td>
								<td align="right">
									<button type="button" class="btn btn-default btn-sm wbtn"
										onclick="javascript:location.href='<%=cp%>/notice/list.do?page=${page}';">
										목록으로</button>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>

		</div>
	</div>

	<div>
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>

	<script type="text/javascript"
		src="<%=cp%>/res/jquery/js/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="<%=cp%>/res/jquery/js/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript"
		src="<%=cp%>/res/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>