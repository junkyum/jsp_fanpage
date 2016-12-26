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

</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
    <div class="bodyFrame">
   		<div class="page-header" style = "text-align:center;">
  		<h1>새로운 글</h1>
  		<small>회원들과 새로운 정보를 나누세요!</small>
		</div>
   		
   		<div >
		    <table class="table table-striped" style = "height: 400px;">
		    
		    <tr>
			<td style = "width: 20%; background: darkgrey; color: white; border:1px solid #ccc;" class="text-center" >
			작성자명
			</td>
			<td style = "width: 80%; background: darkgrey; color: white; border:1px solid #ccc;" class="text-center">
			준겸
			</td>
			<tr>
			<td style = "width: 20%; border:1px solid #ccc;" class="text-center" >
			제목
			</td>
			<td style = "width: 80%; border:1px solid #ccc;">
			<input type = "text" name = "uesrName" class="form-control">
			</td>
			</tr>
			<tr style = "height: 370px;">
			<td style = "width: 20%; border:1px solid #ccc;" class="text-center">
			내용
			</td>
			<td style = "width: 80%; border:1px solid #ccc;">
			<textarea class="form-control" style = "height: 100%; "></textarea>
			</td>
			</tr>
			</table>
		</div>
		<hr>
		<div style="float: right; min-width: 85px; text-align: right;">
	      <button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/board/created.do';"> 글쓰기</button>
			<button type="button" class="btn btn-primary btn-sm bbtn" onclick="javascript:location.href='<%=cp%>/board/list.do';"> 취소</button>	    
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