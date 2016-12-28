<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
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
.bs-write table {
	width: 100%;
	border: 0;
	border-spacing: 0;
}

.table tbody tr td {
	border-top: none;
	font-weight: normal;
	font-family: NanumGothic, 나눔고딕, "Malgun Gothic", "맑은 고딕", 돋움, sans-serif;
}

.bs-write table td {
	padding: 3px 3px 3px 3px;
}

.bs-write .td1 {
	min-width: 100px;
	min-height: 30px;
	color: #666;
	vertical-align: middle;
}

.bs-write .td2 {
	
}

.bs-write .td3 {
	
}

.bs-write .td4 {
	
}
</style>

<script type="text/javascript"
	src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
  function check() {
        var f = document.noticeForm;

    	var str = f.subject.value;
        if(!str) {
        	alter("제목을 입력하세요");
            f.subject.focus();
            return false;
        }

    	str = f.content.value;
        if(!str) {
        	alter("내용을 입력하세요");
            f.content.focus();
            return false;
        }

        var mode="${mode}";	        
    	if(mode=="created")
    		f.action="<%=cp%>/notice/created_ok.do";
    	else if(mode=="update")
    		f.action="<%=cp%>/notice/update_ok.do";
		return true;
		
  }
  
  <c:if test="${mode=='update'}">
  	function deleteFile(num){
  		var url ="<%=cp%>/notice/deleteFile.do?num=" + num + "&page=${page}";
		location.href = url;
	}
	</c:if>

</script>

</head>
<body>


	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<div class="container">
		<div class="bodyFrame">
			<div class="page-header" style="text-align: center;">
				<h1>새로운 글</h1>
				<small>회원들에게 새로운 정보를 알려주세요</small>
			</div>

<div>
				<form name="boardForm" method="post" onsubmit="return check();">
					<div class="bs-write">
						<table class="table">
							<tbody>							
								<tr>
									<td class="td1" width="100" style="text-align: center">제목</td>
									<td colspan="3" class="td3"><input type="text"
										name="subject" class="form-control input-sm"
										value="${dto.subject}" required="required"></td>
								</tr>
								<tr>
									<td width="100" style="text-align: center">내용</td>
									<td class="td1" colspan="3" style="padding-bottom: 0px;"></td>
								</tr>
								<tr>
									<td colspan="4" class="td4"><textarea name="content"
											class="form-control" rows="13" required="required">${dto.content}</textarea>
									</td>
								</tr>
								
								<tr>
									<td width="100" style="text-align: center">첨부</td>
									<td colspan="3">
									<input type="file" name="upload" class="boxTF" size="61" style="height: 40px;"></td>
								</tr>
								
								<c:if test="${mode=='update'}">
									<tr>
										<td>첨부된파일</td>
										<td><c:if test="${not empty dto.savefileName}"> ${dto.originalfileName}
								   | <a href="javascript:deleteFile('${dto.num}');">삭제</a>
											</c:if></td>
									</tr>
								</c:if>
							</tbody>
							
							
							<!-- 
								<tr align="left" height="40">
									<td style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
									<td colspan="2" style="padding-left: 10px;"><input
										type="file" name="upload" class="boxTF" size="61"
										style="height: 40px;"></td>
								</tr>
									<c:if test="${mode=='update'}">
									<tr align="left" height="40">
										<td width="100" style="text-align: center;">첨부된파일</td>
										<td width="500" style="padding-left: 10px;"><c:if
												test="${not empty dto.savefileName}">
								   ${dto.originalfileName}
								   | <a href="javascript:deleteFile('${dto.num}');">삭제</a>
											</c:if></td>
									</tr>
								</c:if>
							</tbody> -->
							
							
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center; padding-top: 15px;">
										<c:if test="${mode=='reply'}">
											<input type="hidden" name="groupNum" value="${dto.groupNum }">
											<input type="hidden" name="depth" value="${dto.depth }">
											<input type="hidden" name="orderNo" value="${dto.orderNo }">
											<input type="hidden" name="parent" value="${dto.boardNum }">
											<input type="hidden" name="page" value="${page }">
										</c:if> <c:if test="${mode=='update'}">
											<input type="hidden" name="boardNum" value="${boardNum }">
											<input type="hidden" name="page" value="${page }">
											
										</c:if>
										<button type="submit" class="btn btn-primary btn-sm bbtn">
											확인
										</button>
										<button type="button" class="btn btn-primary btn-sm bbtn"
											onclick="javascript:location.href='<%=cp%>/board/list.do';">
											취소</button>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</form>
			</div>


			<%-- <div style="width: 600px; margin: 10px auto; margin-top: 30px;">
				<form name="noticeForm" method="post" onsubmit="return check();"
					enctype="multipart/form-data">
					<div class="bs-write">
						<table class="table">
							<tbody>
								<tr align="left" height="40">
									<td width="100" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
									<td colspan="2" width="500" style="padding-left: 10px;"><input
										type="text" name="subject" size="75" maxlength="100"
										class="boxTF" value="${dto.subject}"></td>
								</tr>

								<tr align="left" height="40">
									<td width="100" style="text-align: center;">작성자</td>
									<td colspan="2" width="400" style="padding-left: 10px;">
										${sessionScope.member.userName}</td>
								</tr>

								<tr align="left">
									<td width="100" style="text-align: center; padding-top: 5px;"
										valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
									<td colspan="2" width="500" valign="top"
										style="padding: 5px 0px 5px 10px;"><textarea
											name="content" cols="75" rows="12" class="boxTA">${dto.content}</textarea>
									</td>
								</tr>

								<tr align="left" height="40">
									<td style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
									<td colspan="2" style="padding-left: 10px;"><input
										type="file" name="upload" class="boxTF" size="61"
										style="height: 40px;"></td>
								</tr>
									<c:if test="${mode=='update'}">
									<tr align="left" height="40">
										<td width="100" style="text-align: center;">첨부된파일</td>
										<td width="500" style="padding-left: 10px;"><c:if
												test="${not empty dto.savefileName}">
								   ${dto.originalfileName}
								   | <a href="javascript:deleteFile('${dto.num}');">삭제</a>
											</c:if></td>
									</tr>
								</c:if>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="2" style="text-align: center; padding-top: 15px;">
										<button type="submit" class="btn btn-primary btn-sm bbtn">확인</button>
										<button type="button" class="btn btn-primary btn-sm bbtn"
											onclick="javascript:location.href='<%=cp%>/notice/list.do';">
											취소</button> <c:if test="${mode=='update'}">
											<input type="hidden" name="num" value="${dto.num}">
											<input type="hidden" name="savefileName"
												value="${dto.savefileName}">
											<input type="hidden" name="page" value="${page}">
										</c:if>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</form>

			</div> --%>
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