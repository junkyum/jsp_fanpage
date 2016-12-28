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

 
h1, h2, h3, h4, h5, h6, a {
  margin:10px auto; padding:10;
}
.member-info {

  margin:70px auto;
  max-width:700px;
 

}
.member-header {
  color:#f#f;
  text-align:center;
  font-size:300%;
}
.member-header h1 {
   text-shadow: 0px 5px 15px #000;
}
.member-form {
  border:2px solid #999;
  background: white;/* 안에 공백색갈*/
  border-radius:10px;
  box-shadow:0px 0px 10px #000;
}
.member-form h3 {
  text-align:center;
  margin-left:40px;
  color:#fff;
}
.member-form {
  box-sizing:border-box;
  padding-top:15px;
  margin:50px auto;
  text-align:center;
	overflow: hidden;
}

.member-info  input[type="text"],
.member-info  input[type="password"], 
.member-info  input[type="email"],
.member-info  input[type="file"],
.member-info  input[type="hidden"]{
  width: 100%;
	max-width:400px;
  height:30px;
  font-family: 'Ubuntu', sans-serif;
  margin:10px auto;
  border-radius:5px;
  border:2px solid #f2f2f2;
  outline:none;
  padding-left:10px;
}
.Phon{

 
  max-width:400px;
  height:30px;
  font-family: 'Ubuntu', sans-serif;
  margin:10px auto;
  outline:none;
  padding-left:40px; 

}
.mymy{
  width: 100%;
  max-width:400px;
  height:30px;
  font-family: 'Ubuntu', sans-serif;
  margin:10px auto;
  border-radius:5px;
  border:2px solid #f2f2f2;
  outline:none;
  padding-left:10px;

}

.member-info  input[type="checkbox"]{
  width: 100px;
  max-width:100px;
  height:30px;
  font-family: 'Ubuntu', sans-serif;
  margin:10px 0;
  border-radius:5px;
  border:2px solid #f2f2f2;
  outline:none;
  padding-left:10px;
}


.member-formm option{
  width: 100%;
	max-width:400px;
  height:30px;
  font-family: 'Ubuntu', sans-serif;
  margin:10px 0;
  border-radius:5px;
  border:2px solid #f2f2f2;
  outline:none;
  padding-left:10px;
}

.member-formm button[type="button"]
 {
  height:30px;
  width:100px;
  background:#fff;
  border:1px solid #f2f2f2;
  border-radius:20px;
  color: slategrey;
  text-transform:uppercase;
  font-family: 'Ubuntu', sans-serif;
  cursor:pointer;
}
.member-formm button[type="submit"]
 {
  height:30px;
  width:100px;
  background:#fff;
  border:1px solid #f2f2f2;
  border-radius:20px;
  color: slategrey;
  text-transform:uppercase;
  font-family: 'Ubuntu', sans-serif;
  cursor:pointer;
}
.file{
  height:30px;
  width:100px;
  background:#fff;
  border:1px solid #f2f2f2;
  border-radius:20px;
  color: slategrey;
  text-transform:uppercase;
  font-family: 'Ubuntu', sans-serif;
  cursor:pointer;
}
.no-access {
  color:#E86850;
  margin:20px 0px 20px auto;
  text-decoration:underline;
  cursor:pointer;
}

/*Media Querie*/
@media only screen and (min-width : 150px) and (max-width : 530px){
  .member-form h3 {
    text-align:center;
    margin:0;
  }
  .btn btn-info {
    margin-bottom:10px;
  }
  .btn btn-primary btn-lg {
    margin-bottom:10px;
  }
}
 
</style>




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
	  			f.myPhoto.focus();
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


            	
	<form name="memberForm" method="post"  onsubmit="return check();" enctype="multipart/form-data">
		<div class="member-info">
			<div class="member-header">
		   		 <h1> ★ 회원 가입 ★ </h1>
		  	</div>
		  	
		  	
		  	
		  	<div class="member-form">
		  		 <h3>UserI.D</h3>
		  		 <input type="text" placeholder="아이디는 5~10자 ,첫글자=>소문자 부터." class="form-control" id="userId" name="userId" 
		      value="${dto.userId}"${mode=="update" ? "readonly='readonly' style='border:none;'":""}>
		      
		      		
		  		 <h3>UserName</h3>
		  		 <input type="text" placeholder="이름 입력해라" class="form-control" id="userName" name="userName" value="${dto.userName}">
		  		 
		  		 <h3>UserPW</h3>
		  		 <input type="password" placeholder="P.W=> 5~10자 & 특수@숫자포함" class="form-control" id="userPw" name="userPw" >
		  
		  	
					
					
		  		 <h3>userPwCheck</h3>
		  		  <input type="password" placeholder="P.W다시 입력" class="form-control" id="userPwCheck" name="userPwdCheck" >
		
		  	
		  	
	
		  		<h3>userPhone</h3>
		  		<div class="Phon">
		  		<div class="col-sm-3" style="width: 100px; padding-left: 2px; padding-right: 5px">
		      	<select class="mymy" id="userPhone1" name="userPhone1" >
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
					 <input class="form-control" id="userPhone2" name="userPhone2" type="text"  maxlength="4" value="${dto.userPhone2}">	
				  </div>
				  
				  <div class="col-lg-1" style="width: 10px; padding-left: 2px; padding-right: 5px">
			      	 <p class="form-control-static">-</p>
			      </div>
			      
			      <div class="col-lg-3" style="width: 100px; padding-left: 2px; padding-right: 5px">
					<input class="form-control" id="userPhone3" name="userPhone3" type="text" maxlength="4"  value="${dto.userPhone3}">	
				  </div>
		  		</div>
		  	 	<br>
		   <h3>userEmail</h3>
		  	  <input type="email" placeholder="이메일형식 => xxx@xxx.xx 입니다" class="form-control" id="userEmail" name="userEmail" value="${dto.userEmail}">
		   
		  	
		  

		  	<h3>userBirth</h3>
		  		 <input type="text" placeholder="생년월일은 2000-01-01 형식" class="form-control" id="userBirth" name="userBirth" value="${dto.userBirth}" >
		  	 
		  	
		  	

			
		  		 <h3>userHobby</h3>
			  		<input type="checkbox" name="userHobby" id="userHobby" value="쯔위">쯔위
			     	<input type="checkbox" name="userHobby" id="userHobby" value="채영">채영
			     	<input type="checkbox" name="userHobby" id="userHobby" value="다현">다현
			  		<input type="checkbox" name="userHobby" id="userHobby" value="미나">미나
			     	<input type="checkbox" name="userHobby" id="userHobby" value="지효">지효
			     	<input type="checkbox" name="userHobby" id="userHobby" value="사나">사나			  		
			     	<input type="checkbox" name="userHobby" id="userHobby" value="모모">모모
			     	<input type="checkbox" name="userHobby" id="userHobby" value="정연">정연
			     	<input type="checkbox" name="userHobby" id="userHobby" value="나연">나연
		  		 <h4 class="no-access">누가 좋아</h4>
		  	
		  	
		  
				<input type="file" name="myPhoto" id="myPhoto" class="file">
		      		<h3>myPhoto</h3>
					<c:if test="${mode=='update'}">
					<img  src="<%=cp%>/uploads/myPhoto/${dto.myPhoto}" style="width: 200px; height: 200px;">
					<input type="hidden" value="${dto.myPhoto}" name="myPhoto">
					<p class="help-block">등록된사진</p>
					<input type="hidden" name="imgFile" value="${dto.myPhoto}">
					</c:if>
		  			
				
				
		  	<div class="member-formm">
		  	
				    <c:if test="${mode=='created'}">
						<button type="submit" class="btn btn-info" name="sendB">회원가입</button>
						<button type="button" class="btn btn-info" onclick="javascript:location.href='<%=cp%>/';">가입취소</button>
					</c:if>
					
					<c:if test="${mode=='update'}">
					
						<button type="submit" class="btn btn-info" name="update">
						정보수정</button>
						<button type="button" class="btn btn-info" onclick="javascript:location.href='<%=cp%>/';">수정취소</button>			
					
					</c:if>
		  	</div>
		  	<br><br><br>
		  	
		  	
		  	
		  	</div>
		</div>
	</form>
        
        
        



<!-- -------------- -->
<div>
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/res/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>