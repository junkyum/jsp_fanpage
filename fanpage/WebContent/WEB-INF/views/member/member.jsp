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
<!-- DB로 가는 정보를 쏴주는 구간. -->
<script type="text/javascript">

function check(){
	var f=document.memberForm;
	var kim;
	var chk;
	var mode="${mode}";


	kim=f.userId.value;
	if(mode=="created"){
		if(kim.match(/^[a-z]+[0-9a-zA-Z]{4,10}\w*/g)!=kim){
			alert("ID 를 다시 입력하세요");
			f.userId.focus();
			return false;
		}
	}

	kim=f.userName.value;
	if(!kim){
		alert("이름을 입력하세요");
		f.userName.focus();
		return false;
	}
	
	
	kim= f.userPw.value;
	if(kim.match(/^[a-z][0-9a-zA-Z]{5,10}\w*/g)!=kim){
		alert("비밀번호를 입력하세요");
		f.userPw.focus();
		return false;
	}
	chk=f.userPwCheck.value;
	if(chk != kim){
		alert("비밀번호 확인이 틀렷습니다");
		f.userPwCheck.focus();
		return false;
	}

	
		var num1=f.userPhone1.value;
	if(!num1){
		alert("번호를 선택하세요");
		f.userPhone1.focus();
		return false;
	}
	
    
	num1 = f.userPhone2.value;
    if(!/^(\d+)$/.test(num1)) {
        f.userPhone2.focus();
        return false;
    }
    
	num1 = f.userPhone3.value;
    if(!/^(\d+)$/.test(num1)) {
        f.userPhone3.focus();
        return false;
    }
    
    kim = f.userEmail.value;
    if(kim.match(/[a-z0-9A-Z]+@[0-9A-Za-z]+(.[a-z]+)+/g)!=kim){
		alert("Email 다시입력");
        f.userEmail.focus();
        return false;
	} 

    kim = f.myPhoto.value;
	  if(mode=="created") {
	  		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(kim)) {
	  			alert('이미지 파일만 가능합니다. !!!');
	  			f.upload.focus();
	  			return false;
	  		}
	  	  }

	
	if(mode=="created"){
		f.action="<%=cp%>/member/member_ok.do";
	}
	else if(mode=="update"){
		f.action="<%=cp%>/member/update_ok.do";
	}
	
	return true;   
}

</script>

</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
    <div class="bodyFrame">
        <div class="body-title">
          <h3><span class="glyphicon glyphicon-tower"></span> 회원 가입 <small>아무나 오세요</small></h3>
        </div>
    <!--  ------------------------------>
        <div>
            	
	<form name="memberForm" method="post"  onsubmit="return check();" enctype="multipart/form-data">
	
		<div class="row" align="center">
		  <div class="col-lg-6">
		    <div class="input-group" style = "width:700px;" >
		      <span class="input-group-addon" style = "width:150px; height:50px;">
		        	아이디
		      </span>

		      <input type="text" placeholder="아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다." class="form-control" id="userId" name="userId" 
		      value="${dto.userId}"${mode=="update" ? "readonly='readonly' style='width:550px; height:50px;'":""} style = "width:550px; height:50px;">
		
		     <!--  <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p> -->
		      
		    </div>
		  </div>
		</div>
		
		<br><br>
		<div class="row">
		  <div class="col-lg-6" style = "width:700px;">
		    <div class="input-group" style = "width:700px;">
		      <span class="input-group-addon" style = "width:150px; height:50px;">
		        	이 름
		      </span>
		      <input type="text" placeholder="이름 입력해주세요." class="form-control" id="userName" name="userName" value="${dto.userName}" style = "width:550px; height:50px;">
		      <!-- <p class="help-block">이름 입력해주세요.</p> -->
		    </div>
		  </div>
		</div>
	
		<br><br>
		<div class="row">
		  <div class="col-lg-6">
		    <div class="input-group" style = "width:700px;">
		      <span class="input-group-addon" style = "width:150px; height:50px;">
		        	패스워드
		      </span>
		      <input type="password" placeholder="패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다." class="form-control" id="userPw" name="userPw" style = "width:550px; height:50px;">
		      <!-- <p class="help-block">패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p> -->
		    </div>
		  </div>
		</div>

		<br><br>
		<div class="row">
		  <div class="col-lg-6">
		    <div class="input-group" style = "width:700px;">
		      <span class="input-group-addon" style = "width:150px; height:50px;">
		        	패스워드 확인
		      </span>
		      <input type="password" placeholder="패스워드를 한번 더 입력해주세요." class="form-control" id="userPwCheck" name="userPwdCheck" style = "width:550px; height:50px;">
		      <!-- <p class="help-block">패스워드를 한번 더 입력해주세요.</p> -->
		    </div>
		  </div>
		</div>



		<br><br>
		<div class="row">
		  <div class="col-lg-6">
		    <div class="input-group"  style = "width:700px;">
		      <span class="input-group-addon" style = "width:150px; height:50px;">전화번호 </span>
		      
		      	<div class="col-sm-3" >
		      	<select class="form-control" id="userPhone1" name="userPhone1" style = "width:120px; height:50px;">
								<option value="">선 택</option>
								<option value="010" ${dto.userPhone1=="010" ? "selected='selected'" : ""}>010</option>
								<option value="011" ${dto.userPhone1=="011" ? "selected='selected'" : ""}>011</option>
								<option value="016" ${dto.userPhone1=="016" ? "selected='selected'" : ""}>016</option>
								<option value="017" ${dto.userPhone1=="017" ? "selected='selected'" : ""}>017</option>
								<option value="018" ${dto.userPhone1=="018" ? "selected='selected'" : ""}>018</option>
								<option value="019" ${dto.userPhone1=="019" ? "selected='selected'" : ""}>019</option>
				 </select>
		      </div>
		      <div class="col-lg-1" style="width: 10px; padding-left: 2px; padding-right: 5px">
		      	 <p class="form-control-static">-</p>
		      </div>
		      <div class="col-lg-3" style="width: 100px; padding-left: 2px; padding-right: 5px">
				 <input class="form-control" id="userPhone2" name="userPhone2" type="text"  maxlength="4" value="${dto.userPhone2}" style = "width:100px; height:50px;">	
			  </div>
			  <div class="col-lg-1" style="width: 10px; padding-left: 2px; padding-right: 5px">
		      	 <p class="form-control-static">-</p>
		      </div>
		      <div class="col-lg-3" style="width: 100px; padding-left: 2px; padding-right: 5px">
			<input class="form-control" id="userPhone3" name="userPhone3" type="text" maxlength="4"  value="${dto.userPhone3}" style = "width:100px; height:50px;">	
			  </div>
		      		
		    </div>
		  </div>
		</div>

		<br><br>
		<div class="row">
		  <div class="col-lg-6">
		    <div class="input-group" style = "width:700px;">
		      <span class="input-group-addon"  style = "width:150px; height:50px;">
		        	이메일
		      </span>
		      <input type="email" placeholder="이메일형식 => xxx@xxx.xx 입니다" class="form-control" id="userEmail" name="userEmail" value="${dto.userEmail}"  style = "width:550px; height:50px;">
		     
		    </div>
		  </div>
		</div>

		<br><br>
		<div class="row">
		  <div class="col-lg-6">
		    <div class="input-group" style = "width:700px;">
		      <span class="input-group-addon"  style = "width:150px; height:50px;">
		        	생년월일
		      </span>
		      <input type="text" placeholder="생년월일은 2000-01-01 형식" class="form-control" id="userBirth" name="userBirth" value="${dto.userBirth}" style = "width:550px; height:50px;">
		    
		    </div>
		  </div>
		</div>


		<br><br>
		<div class="row">
		  <div class="col-lg-6">
		    <div class="input-group" style = "width:700px;">
	    	  <span class="input-group-addon" style = "width:150px; height:50px; border">취미</span>
		     	<input type="checkbox" name="userHobby" id="userHobby" value="축구">축구
		     	<input type="checkbox" name="userHobby" id="userHobby" value="야구">야구
		     	<input type="checkbox" name="userHobby" id="userHobby" value="족구">족구
		      <p class="help-block">  취미를  입력하세요 [선택사항]</p>
			</div>
		  </div>
		</div>

		<br><br>
		<div class="row">
		  <div class="col-lg-6">
		    <div class="input-group">
	    	  <span class="input-group-addon" style = "width:150px;">회원사진</span>
				<input type="file" name="myPhoto" id="myPhoto" class="form-control" style = "height:50px;">
					<c:if test="${mode=='update'}">
					<img  src="<%=cp%>/uploads/myPhoto/${dto.myPhoto}" style="width: 200px; height: 200px;">
					<input type="hidden" value="${dto.myPhoto}" name="myPhoto">
					<p class="help-block">등록된사진</p>
					<input type="hidden" name="imgFile" value="${dto.myPhoto}">
					</c:if>
			</div>
		  </div>
		</div>



<!--------------------------------------------------------------------  -->
		<!-- 버튼 만든ㄴ다. -->

		<br><br>
		
		<div class="row" >
		  <div class="col-lg-6">
		    <div class="input-group">
		    
		    
		    <c:if test="${mode=='created'}">
				<button type="submit" class="btn btn-primary btn-lg" name="sendB">회원가입</button>
				<button type="button" class="btn btn-info" onclick="javascript:location.href='<%=cp%>/';">가입취소</button>
			</c:if>
			
			<c:if test="${mode=='update'}">
			
				<button type="submit" class="btn btn-primary btn-lg" name="update">
				정보수정</button>
				<button type="button" class="btn btn-info" onclick="javascript:location.href='<%=cp%>/';">수정취소</button>			
			
			</c:if>

		    </div>
		  </div>
		</div>

	</form>
        </div>
        
        
        <!-- ---------------- -->
    </div>
</div>




<!-- -------------- -->
<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/res/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>