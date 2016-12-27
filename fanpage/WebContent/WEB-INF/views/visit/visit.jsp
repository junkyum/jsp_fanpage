<%@page import="com.visit.VisitDTO"%>
<%@page import="com.visit.VisitDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List"%>
<%@page import="com.util.MyUtil"%>

<%
	request.setCharacterEncoding("utf-8");

	String cp = request.getContextPath();
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

<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}

body {
	font-size: 9pt;
	font-family: 돋움;
}

a {
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}

a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}

.title {
	font-weight: bold;
	font-size: 13pt;
	margin-bottom: 10px;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
}

.btn {
	font-size: 12px;
	color: #333;
	font-weight: 500;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	border: 1px solid #ccc;
	background-color: #FFF;
	vertical-align: middle;
	text-align: text-align;
	cursor: cursor;
	padding: 4px 8px;
	border-radius: 4px;
	margin-bottom: 3px;
}

.btn:active, .btn:focus, .btn:hover {
	background-color: #e6e6e6;
	border-color: #adadad;
	color: #333;
}

.boxTF {
	border: 1px solid #999;
	padding: 4px 6px;
	border-radius: 4px;
	background-color: #ffffff;
	font-family: 나눔고딕, 맑은 고딕, 돋움, sans-serif;
	font-size: 9pt;
}

.boxTA {
	border: 1px solid #999;
	height: 150px;
	padding: 3px 6px;
	border-radius: 4px;
	background-color: #ffffff;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
	font-size: 9pt;
}
</style>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function sendVisit() {
    var f = document.visitForm;

    var str = f.content.value;
    if(!str) {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return;
    }

    f.action = "<%=cp%>/visit/visit_ok.do";
    f.submit();
}

function deleteVisit(num)  {
	if (confirm("위 자료를 삭제하시겠습니까 ?")) {
		var url="delete.do?num="+num;
			location.href = url;
		}
	}
	
function updateVisit(num)  {
	if (confirm("위 자료를 수정하시겠습니까 ?")) {
		var url="update.do?num="+num;
			location.href = url;
		}
	}
</script>

</head>

<body>
	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<table
		style="width: 560px; margin: 0px auto; margin-top: 30px; border-spacing: 0px;">
		<tr height="40">
			<td align="left" class="title">더 좋은 디자인 없나??</td>
		</tr>
	</table>
	<br>

	<form name="visitForm" method="post" action="">
		<table style="width: 560px; margin: 0px auto; border-spacing: 0px;">

			<tr>
				<td colspan="2" height="2" bgcolor=#41D9CD></td>
			</tr>

			<tr>
				<td width="20%" height="40" bgcolor="#FFFFFF"
					style="padding-left: 20px;" align="left">작성자</td>
				<td width="80%" style="padding-left: 10px;" align="left">
				<c:if test="${empty sessionScope.member}">
					<!-- <input type="text" name="name" size="35" maxlength="20" class="boxTF" value="guest"> -->
					<p class="form-control-static">guest</p><br>
					*비회원일 경우 id는 Guest로 등록이 되오니 참고 바랍니다.
				</c:if>
				
				<c:if test="${sessionScope.member.userName!='null'}">
					<p class="form-control-static">${sessionScope.member.userName}</p>
				</c:if>
				</td>
			</tr>

			<tr>
				<td colspan="2" height="1" bgcolor="#41D9CD"></td>
			</tr>

			<tr>
				<td width="20%" bgcolor="#FFFFFF"
					style="padding-left: 20px; padding-top: 5px;" valign="top"
					align="left">내&nbsp;&nbsp;용</td>
				<td width="80%" valign="top" style="padding: 5px 0px 5px 10px;"
					align="left"><textarea name="content" cols="72" rows="12"
						class="boxTA" style="height: 70px;"></textarea>
						<br><c:if test="${empty sessionScope.member}">
						* 비회원일 경우 글 작성 후 수정과 삭제가 안되오니 참고 바랍니다.
						</c:if></td>
			</tr>

			<tr>
				<td colspan="2" height="1" bgcolor="#ccc"></td>
			</tr>
		</table>

		<table style="width: 560px; margin: 0px auto; border-spacing: 0px;">
			<tr align="right">
				<td height="45"><input type="button" value=" 등록하기 "
					onclick="sendVisit();" class="btn"></td>
			</tr>
		</table>
	</form>

	<table style="width: 560px; margin: 10px auto 0px; table-layout: fixed; word-break: break-all; border-spacing: 0px;">
		
		<c:forEach var="dto" items="${list}">
			<tr>
				<td colspan='2' bgcolor='#41D9CD' height='2'></td>
			</tr>
			
			<tr height="30">
				<td width='260' style='padding-left: 10px;' align="left">작성자 | ${dto.userName}
				</td>
				<td width='300' align='right' style='padding-right: 10px;'>${dto.created}
				 	<c:if test="${not empty sessionScope.member}">
				 				
						<c:if test="${sessionScope.member.userId==dto.userId}">
								| <a href="javascript:updateVisit('${dto.num}');">수정</a>
						</c:if>
						
						<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
								| <a href="javascript:deleteVisit('${dto.num}');">삭제</a>
						</c:if>
						
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan='2' bgcolor='#41D9CD' height='1'></td>
			</tr>
	
			<tr>
				<td colspan='2' height='50' valign="top"
					style='white-space: pre; padding: 5px 10px 5px 10px;' align="left">${dto.content}</td>
			</tr>
			
			<tr>
				<td colspan='2' bgcolor='#41D9CD' height='1'></td>
			</tr>
		
		</c:forEach>
		
		<!-- 검색?? -->

		<tr height="35">
			<td colspan="2" align="center">${paging}</td>
		</tr>
	</table>

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
