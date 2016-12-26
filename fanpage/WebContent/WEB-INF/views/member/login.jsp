<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
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

<link rel="stylesheet" href="<%=cp%>/res/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css" type="text/css"/>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<style type="text/css">

body {
  background-color:#fff;
  -webkit-font-smoothing: antialiased;
  font: normal 14px Roboto,arial,sans-serif;
}



.form-login {
    background-color: #EDEDED;
    padding-top: 10px;
    padding-bottom: 20px;
    padding-left: 15px;
    padding-right: 20px;
    border-radius: 15px;
    border-color:#d2d2d2;
    border-width: 5px;
    box-shadow:0 1px 0 #cfcfcf;
}

h4 { 
 border:0 solid #fff; 
 border-bottom-width:1px;
 padding-bottom:10px;
 text-align: center;
}

.form-control {
    border-radius: 10px;
}

.wrapper {
    text-align: center;
}
</style>

<script type="text/javascript">

	function login(){
		var f= document.loginForm;
		
		var kim= f.userId.value;
		
		if(!kim){
			alert("이름 없다 이름줘");
			f.userId.focus();
            return false;
		}
		
		kim= f.userPw.value;
		if(!kim){
			alert("비번없다 비번줘");
			f.userId.focus();
            return false;
		}
		
		f.action= "<%=cp%>/member/login_ok.do";
		f.submit();
		
	}



</script>

</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>



<form name="loginForm" method="post">
<div class="container">
    <div class="row">
        <div class="col-md-offset-5 col-md-3" style = "height:600px;">
        
	            <div class="form-login" style = "margin: auto auto;" >
	            <h4>로그인 창입니다.</h4>
	            
	            <label for="userId" class="lbl">아이디</label>
	            <input type="text" id="userId" name="userId" class="form-control input-sm chat-input" placeholder="userId" />
	            <br>
	            <label for="userPwd"  class="lbl">패스워드</label>
	            <input type="password" id="userPw" name="userPw" class="form-control input-sm chat-input" placeholder="userPw" />
	            
	            <br>
	            <div class="wrapper">
		            <span class="group-btn">     
		              <button type="button" class="btn btn-primary btn-md" onclick="login();"> login <i class="fa fa-sign-in"></i></button>
		            </span>
		        </div>
	        
	        	<!-- 실패했을시 메세지-->
	        	<div>${message}</div>
	        
            </div>  
        </div>
    </div>
</div>
</form>



<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/res/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>