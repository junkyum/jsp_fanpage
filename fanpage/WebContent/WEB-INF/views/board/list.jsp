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

<style type="text/css">
.table th, .table td {
	font-weight: normal;
	border-top: none;
}

.table thead tr th {
	border-bottom: none;
}

.table thead tr {
	border: #d5d5d5 solid 1px;
	background: #4C4C4C;
	color: white;
}

.table td {
	border-bottom: #d5d5d5 solid 1px;
}

.table td a {
	color: #000;
}
</style>
<script type="text/javascript"
	src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function searchList() {
		var f=document.searchForm;
		f.action="<%=cp%>/board/list.do";
		f.submit();
}
function selectList(){
	var f = document.selectListForm;
	f.action="<%=cp%>/board/list.do";
	f.submit();
}

</script>


</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>



	<div class="container" role="main">
		<div style="margin: 10px;">
			<form name="selectListForm" method="post" class="form-inline">
				<select class="form-control input-sm" name="sort" onchange="selectList();">
					<option value="b.boardnum">번호순</option>
					<option value="b.hitcount">인기순</option>
					<!-- <option value="#">추천순</option> -->
				</select>
			</form>

		</div>
		<div class="table-responsive" style="clear: both;">
			<table class="table table-hover">

				<thead>
					<tr>
						<th class="text-center" style="width: 100px;">번호</th>
						<th class="text-center">제목</th>
						<th class="text-center" style="width: 150px;">글쓴이</th>
						<th class="text-center" style="width: 150px;">날짜</th>
						<th class="text-center" style="width: 100px;">조회수</th>
					</tr>
				</thead>

				<c:forEach var="dto" items="${list}">
					<tr>
						<td class="text-center">${dto.listNum}</td>
						<td >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${dto.depth>0 }">
								<c:forEach var="i" begin="1" end="${dto.depth}">
	                        		
	                        		</c:forEach>
								<img src="<%=cp%>/res/images/re.gif">
						</c:if>
						<a href="${articleUrl}&boardNum=${dto.boardNum}">${dto.subject}</a></td>
						<td class="text-center">${dto.userName}</td>
						<td class="text-center">${dto.created}</td>
						<td class="text-center">${dto.hitCount}</td>
					</tr>
				</c:forEach>
			</table>

		</div>
		<div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
	         <c:if test="${dataCount==0}">
	         	등록된 게시물이 없습니다
	         </c:if>
	            <c:if test="${dataCount!=0}">
	         	${paging}
	         </c:if>
	    </div>
		<div style="clear: both;">
			<div style="float: left; width: 20%; min-width: 85px;">
				<button type="button" class="btn btn-primary btn-sm bbtn"
					onclick="javascript:location.href='<%=cp%>/board/list.do';">리스트갱신</button>
			</div>
			<div style="float: left; width: 60%; text-align: center;">
				<form name="searchForm" method="post" class="form-inline">
					<select class="form-control input-sm" name="searchKey">
						<option value="subject">제목</option>
						<option value="userName">작성자</option>
						<option value="content">내용</option>
						<option value="created">등록일</option>
					</select> <input type="text" class="form-control input-sm input-search"
						name="searchValue" placeholder="검색어">
					<button type="button" class="btn btn-primary btn-sm bbtn"
						onclick="searchList();">
						<span class="glyphicon glyphicon-search"></span> 검색
					</button>
				</form>
			</div>
			     
			<div
				style="float: left; width: 20%; min-width: 85px; text-align: right;">
				<button type="button" class="btn btn-primary btn-sm bbtn"
					onclick="javascript:location.href='<%=cp%>/board/created.do';">
					글쓰기</button>
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