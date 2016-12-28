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
		<div class="bodyFrame">
			<div style="margin: 20px auto; width: 80%;">
				<img src="<%=cp%>/res/images/twice.jpg"
					style="width: 100%; height: 100%;">
		
				<p class="text-center">12시 방향에서부터 시계방향으로 지효, 쯔위, 정연, 미나, 채영, 나연,	모모, 사나, 다현</p>
				<hr>
			</div>
			<div class="text-center">
				<h3 >1. 개요</h3>
				<p>
				연예기획사 JYP 엔터테인먼트에서 미쓰에이 이후 5년 만에 선보인 9인조 다국적 걸그룹이다.<br>
				팀명의 의미는 귀로 한 번, 눈으로 한 번 매력을 느낀다는 뜻. 2015년 7월 10일 TWICE공식 인스타그램을 개설했다.<br>
			    2015년 5월 5일부터 7월 7일까지 엠넷에서 방영된 서바이벌 프로그램 SIXTEEN에서 16명의 JYP 연습생들 중 치열한 경쟁을 통해 뽑힌 9명으로 이루어져 있다.<br> 
				멤버는 나이 순서대로 나연, 정연, 모모,	사나, 지효, 미나, 다현, 채영, 쯔위. <br>
				엄청난 기록[4]과 폭발적인 성장세를 보이며 최고의 아이돌 그룹 중 하나로 자리매김했다.</p>
				
				<a href="https://namu.wiki/w/TWICE">자세한 정보</a>
			</div>
		</div>
		<hr>
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