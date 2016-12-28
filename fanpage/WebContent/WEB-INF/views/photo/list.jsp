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
<title>spring</title>

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
.imgLayout {
	width: 200px;
	height: 230px;
	padding: 5px 5px 5px;
	margin: 5px;
	border: 1px solid #DAD9FF;
	float: left;
}

.subject {
	width: 190px;
	height: 25px;
	line-height: 25px;
	margin: 5px auto 0px;
	border-top: 1px solid #DAD9FF;
	display: inline-block;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	cursor: pointer;
	text-align: center;
}

@import
	url("http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css")
	;

.panel-image {
	position: relative;
	
}

.panel-image img.panel-image-preview {
	width: 100%;
	border-radius: 4px 4px 0px 0px;
}

.panel-image label {
	display: block;
	position: absolute;
	top: 0px;
	left: 0px;
	height: 100%;
	width: 100%;
}

.panel-heading ~ .panel-image img.panel-image-preview {
	border-radius: 0px;
}

.panel-body {
	overflow: hidden;
}

.panel-image ~ input[type=checkbox] {
	position: absolute;
	top: - 30px;
	z-index: -1;
}

.panel-image ~ input[type=checkbox] ~ .panel-body {
	height: 0px;
	padding: 0px;
}

.panel-image ~ input[type=checkbox]:checked ~ .panel-body {
	height: auto;
	padding: 15px;
}

.panel-image ~ .panel-footer a {
	padding: 0px 10px;
	font-size: 1.3em;
	color: rgb(100, 100, 100);
}
</style>

<script type="text/javascript"
	src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	function article(num) {
		var url = "${articleUrl}&num=" + num;
		location.href = url;
	}
	$(function() {
	    $('.panel-image img.panel-image-preview').on('click', function(e) {
		    $(this).closest('.panel-image').toggleClass('hide-panel-body');
	    });
	});
</script>

</head>
<body>

	<div>
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>


	<div class="container" style="margin-top: 10px;">





		<div class="container" role="main">
			<div class="bodyFrame col-sm-10"
				style="float: none; margin-left: auto; margin-right: auto;">

				<div class="body-title">
					<h3>
						<span class="glyphicon glyphicon-picture"></span> PHOTO
					</h3>
				</div>
			
				<link href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" />
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	</head>

<body>


<div id="myCarousel" class="carousel slide" data-ride="carousel"> 
	
	<!--페이지-->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
	</ol>
	<!--페이지-->

	<div class="carousel-inner">
		<!--슬라이드1-->
		<div class="item active"> 
			<img  src="<%=cp%>/res/images/ww2.jpg"  style="width:100%" alt="First slide">
			<div class="container">
				<div class="carousel-caption">
				</div>
			</div>
		</div>
		<!--슬라이드1-->

		<!--슬라이드2-->
		<div class="item"> 
			<img  src="<%=cp%>/res/images/ww1.jpg"  style="width:100%" data-src="" alt="Second slide">
			<div class="container">
				<div class="carousel-caption">
					</div>
			</div>
		</div>
		<!--슬라이드2-->
		
		<!--슬라이드3-->
		<div class="item"> 
			<img src="<%=cp%>/res/images/ww3.jpg"  style="width:100%" data-src="" alt="Third slide">
			<div class="container">
				<div class="carousel-caption">
					</div>
			</div>
		</div>
		<!--슬라이드3-->
	</div>
	
	<!--이전, 다음 버튼-->
	<a class="left carousel-control" href="#myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> 
	<a class="right carousel-control" href="#myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a> 
</div>
  
			<hr>
				<div class="row form-group" style="margin-top: 40px;">

					<c:forEach var="dto" items="${list}" varStatus="status">

						<c:if test="${status.index==0}">
								<c:out
								value="<div style='clear: both; max-width:660px; margin: 0px auto;'>"
								escapeXml="false" />
						</c:if>
						<c:if test="${status.index!=0 && status.index%4==0}">
							<c:out
								value="</div><div style='clear: both; max-width:660px; margin: 0px auto;'>"
								escapeXml="false" />
						</c:if>
						<div class="col-xs-12 col-md-6">
							<div class="panel panel-default">

								<div class="panel-image" >
									<img src="<%=cp%>/uploads/photo/${dto.imageFilename}"
										class="panel-image-preview" /> <label for="toggle-1"></label>
								</div>
								<div class="panel-body">
									<h4>${dto.subject}</h4>
									<span class="subject"
										onclick="javascript:article('${dto.num}');">
										${dto.content} </span>
								</div>
								<div class="panel-footer text-center">
										<a href="#download"><span
										class="glyphicon glyphicon-download"></span></a> <a
										href="#facebook"><span class="glyphicon glyphicon-cloud"></span></a> <a
										href="#twitter"><span class="glyphicon glyphicon-envelope"></span></a> <a
										href="#share"><span class="glyphicon glyphicon-share-alt"></span></a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>

			</div>

		
				<div class="paging"
					style="text-align: center; min-height: 50px; line-height: 50px;">
					<c:if test="${dataCount==0 }">
	                  등록된 게시물이 없습니다.
	            </c:if>
					<c:if test="${dataCount!=0 }">
	                ${paging}
	            </c:if>
				</div>

				<div style="clear: both;">
					<div style="float: left; width: 20%; min-width: 85px;">
						&nbsp;</div>
					<div style="float: left; width: 60%; text-align: center;">
						&nbsp;</div>
					<div
						style="float: left; width: 20%; min-width: 85px; text-align: right;">
						<button type="button" class="btn btn-primary btn-sm bbtn"
							onclick="javascript:location.href='<%=cp%>/photo/created.do';">
							<span class="glyphicon glyphicon glyphicon-pencil"></span> 등록하기
						</button>
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