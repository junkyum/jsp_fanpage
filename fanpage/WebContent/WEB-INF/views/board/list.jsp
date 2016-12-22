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

</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

		

	<div class="container" role="main">
	   <div style="margin-bottom: 10px;">
		<form name="searchForm" method="post" class="form-inline">
			<select class="form-control input-sm" name="searchKey" >
			 <option value="#">일반</option>
		     <option value="#">인기</option>
		     <option value="#">추천</option>
		    </select>
		</form>
        		
	   </div>
	   <div>
		<table class="table" >
		
		<tr>
		<td>번호</td>
		<td>제목</td>
		<td>이름</td>
		<td>조회수</td>
		</tr>
		
		<tr>
		<td>1</td>
		<td>냐냐</td>
		<td>준겜</td>
		<td>10</td>
		</tr>	
		</table>
	  </div>
	  <div style="clear: both;">
	        		<div style="float: left; width: 20%; min-width: 85px;">
	        		    <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/board/list.do';">리스트갱신</button>
	        		</div>
	        		<div style="float: left; width: 60%; text-align: center;">
	        		     <form name="searchForm" method="post" class="form-inline">
							  <select class="form-control input-sm" name="searchKey" >
							      <option value="subject">제목</option>
							      <option value="userName">작성자</option>
							      <option value="content">내용</option>
							      <option value="created">등록일</option>
							  </select>
							  <input type="text" class="form-control input-sm input-search" name="searchValue" placeholder="검색어">
							  <button type="button" class="btn btn-primary btn-sm bbtn" onclick="searchList();"><span class="glyphicon glyphicon-search"></span> 검색</button>
	        		     </form>
	        		</div>
	        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
	        		    <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/board/created.do';"> 글쓰기</button>
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