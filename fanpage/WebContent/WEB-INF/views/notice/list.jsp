<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
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

<link rel="stylesheet" href="<%=cp%>/res/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css" type="text/css"/>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/notice/list.do";
	f.submit();
}

</script>
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
</head>
<body>
<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
    <div class="bodyFrame">
        <div class="body-title">
        <span class="glyphicon glyphicon-bullhorn"></span>&nbsp;
          <img src="<%=cp%>/res/images/notice_btn.gif" 
          onclick="javascript:location.href='<%=cp%>/notice/list.do';"></div>
        
    
        <div>
 			<table class="table">
					<thead>
						<tr>
							<th class="text-center" style="width: 150px;">번호</th>
							<th class="text-center">제목</th>
							<th class="text-center" style="width: 150px;">날짜</th>
							<th class="text-center" style="width: 100px;">조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="dto" items="${list }">
							<tr>
							 <td class="text-center">${dto.num }</td>
							<td>
							<a href="${articleUrl }&num=${dto.num}">${dto.subject }	&nbsp;
							  <c:if test="${not empty dto.savefileName}">
							  <span class="glyphicon glyphicon-download-alt"></span>
							  	<%-- <img src="<%=cp%>/res/images/disk.gif"> --%>
							  </c:if></a>
							</td>
								<td class="text-center">${dto.created }</td>
								<td class="text-center">${dto.hitCount }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	        
	    </div>
	    <div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
	           <c:if test="${dataCount==0 }">등록된 게시물 없습니다</c:if>
	           <c:if test="${dataCount!=0 }">${paging }</c:if>
	    </div>  
	    <div style="clear: both;">
	        		<div style="float: left; width: 20%; min-width: 85px;">
	        		    <button type="button" class="btn btn-primary btn-sm bbtn" 
	        		    onclick="javascript:location.href='<%=cp%>/notice/list.do';">새로고침</button>
	        		</div>
	        		<div style="float: left; width: 60%; text-align: center;">
	        		     <form name="searchForm" method="post" class="form-inline">
							  <select class="form-control input-sm" name="searchKey" >
							      <option value="subject">제목</option>
							      <option value="content">내용</option>
							      <option value="created">등록일</option>
							  </select>
							  <input type="text" class="form-control input-sm input-search" name="searchValue">
							  <input type="hidden" name="rows" value="${rows }">
							  <button type="button" class="btn btn-primary btn-sm bbtn" onclick="searchList();"><span class="glyphicon glyphicon-search"></span>검색</button>
	        		     </form>
	        		</div>
	        		<c:if test="${sessionScope.member.userId=='admin'}"> 
	        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
	        		    <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/notice/created.do';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 글쓰기</button>
	        		</div></c:if>
	        </div>
	    
	    
	    
        </div>
    </div>


<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/res/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>