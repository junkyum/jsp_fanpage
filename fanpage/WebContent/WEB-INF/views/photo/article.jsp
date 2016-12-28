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
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/res/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>

<link rel="stylesheet" href="<%=cp%>/res/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/res/css/layout/layout.css" type="text/css"/>
<style type="text/css">
.bbs-article .table {
    margin-top: 15px;
}
.bbs-article .table thead tr, .bbs-article .table tbody tr {
    height: 30px;
}
.bbs-article .table thead tr th, .bbs-article .table tbody tr td {
    font-weight: normal;
    border-top: none;
    border-bottom: none;
}
.bbs-article .table thead tr {
    border-top: #d5d5d5 solid 1px;
    border-bottom: #dfdfdf solid 1px;
} 
.bbs-article .table tbody tr {
    border-bottom: #dfdfdf solid 1px;
}
.bbs-article .table i {
    background: #424951;
    display: inline-block;
    margin: 0 7px 0 7px;
    position: relative;
    top: 2px;
    width: 1px;
    height: 13px;    
}
</style>

<script type="text/javascript" src="<%=cp%>/res/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function updatePhoto(num) {
	<c:if test="${sessionScope.member.userId==dto.userId}">
	     var url="<%=cp%>/photo/update.do?num="+num+"&page=${page}";
	     location.href=url;
	</c:if>
}

function deletePhoto(num) {
	<c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
         if(confirm("게시물을 삭제 하시겠습니까 ?")) {
        	 var url="<%=cp%>/photo/delete.do?num="+num+"&page=${page}";
        	 location.href=url;
         }	
	</c:if>
}

//리플 저장
function sendReply() {
	var uid="${sessionScope.member.userId}";
	if(uid=="") {
		alert("로그인 후 게시물을 등록 하세요. !!!");
		return;
	}
	
	var f=document.replyForm;
	if(! f.content.value) {
		alert("내용을 입력 하세요. !!!");
		f.content.focus();
		return;
	}
	
	f.action="<%=cp%>/photo/insertReply.do";
	f.submit();
}

function listPage(page) {
	var params="pageNo="+page+"&num=${dto.num}&${params}";
	location.href="<%=cp%>/photo/article.do?"+params;
}

//리플 삭제
function deleteReply(replyNum, userId) {
	var uid="${sessionScope.member.userId}";
	if(uid=="" || uid!=userId) {
		alert("게시물을 삭제할 수 없습니다. !!!");
		return;
	}
	
	if(! confirm("게시물을 삭제 하시겠습니까 ? "))
		return;
	
	var params="replyNum="+replyNum+"&pageNo=${pageNo}&num=${dto.num}&${params}";
	location.href="<%=cp%>/photo/deleteReply.do?"+params;
}
</script>
</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>



<div class="container" role="main">
    <div class="bodyFrame">
   		<div class="page-header" style = "text-align:center;">
  		<h1>PHOTO</h1>
  		<small>회원들과 새로운 사진를 나누세요!</small>
		</div>
   		
   		<div >
		    <table class="table table-striped" style = "height: 400px;">
		    
		    <tr >
			<td style = "width: 20%; background: darkgrey; color: white; border:1px solid #ccc;" class="text-center" >
			작성자명
			</td>
			<td style = "width: 70%; background: darkgrey; color: white; border:1px solid #ccc;" class="text-center" colspan="2">
			${dto.userName}      &nbsp;&nbsp;&nbsp;&nbsp;  ${dto.created} | 조회수  ${dto.hitCount}
			</td>
			
			
			 
			
			<tr>
			<td style = "width: 20%; border:1px solid #ccc;" class="text-center" >
			제목
			</td>
			<td style = "width: 80%; border:1px solid #ccc;">
			${dto.subject}
			</td>
			</tr>
			<tr style = "height: 370px;">
			<td style = "width: 20%; border:1px solid #ccc;" class="text-center" rowspan="2">
			내용
			</td>
			 <td colspan="1">
                                 <img src="<%=cp%>/uploads/photo/${dto.imageFilename}" style="max-width:100%; height:auto; resize:both;">
                </td>
             <tr>
             <td style = "width: 20%; border:1px solid #ccc;" >
					${dto.content}	
			</td>
			
              </tr> 
                <tr>
	                		<td>
		                     <c:if test="${sessionScope.member.userId==dto.userId}">		                		
				        <button type="button" class="btn btn-primary btn-sm bbtn" onclick="updatePhoto(${dto.num});">수정</button>
	                		    </c:if>
		                         <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">    
	                		         <button type="button" class="btn btn-primary btn-sm bbtn" onclick="deletePhoto(${dto.num});">삭제</button>
						   </c:if> 
	                		</td>
	                		<td align="right">
	                		    <button type="button" class="btn btn-primary btn-sm bbtn"
	                		                onclick="javascript:location.href='<%=cp%>/photo/list.do?page=${page}';"> 목록으로 </button>
	                		</td>
	                	</tr>      
			</table>
		</div>
		<hr>
		
		
    </div>
</div>

	<div style="width:100%;">
		    <div style="width:600px; height:25px; line-height:25px; margin:0px auto 0px;">
		        <img src="<%=cp%>/res/images/new.gif" alt="" style="padding-left: 0px; padding-right: 5px;">
	              리플 달기
		    </div>
		    
		    <form name="replyForm" method="post">
            <table style="width: 600px; margin: 0px auto; border-spacing: 0px;">
 		    <tr height="50">
			   <td width="520" align="left">
			      <textarea rows="5" cols="85" class="boxTF" name="content" id="content" style="width:520px; height: 45px;"></textarea>
			  </td>
			  <td width="80" align="right">
			     <button type="button" id="btnSend"
			           onclick="sendReply()" class="btn btn-primary btn-sm bbtn"
			           style="width: 60px; height: 52px;">등록</button> 
			           
			     <input type="hidden" name="num" value="${dto.num}">
			     <input type="hidden" name="page" value="${page}">
			     <input type="hidden" name="searchKey" value="${searchKey}">
			     <input type="hidden" name="searchValue" value="${searchValue}">
			  </td>
		  </tr>
          </table>
          </form>
        
          <div id="listReply" style="width:600px; margin: 0px auto 10px;">
				<table style='width: 600px; margin: 10px auto 0px; border-spacing: 0px; border-collapse: collapse;'>
				<tr height='30' bgcolor='#EEEEEE' style='border: 1px solid #DBDBDB;'>
				    <td width='50%' style='padding-left: 5px;'>
				        	이름
				    </td>
				    <td width='50%' align='right' style='padding-right: 5px;'>
				     	날짜 | 삭제
				     </td>
				     
				     </tr> 
				     
				<c:forEach var="dto" items="${listReply}">
				
				<tr height='30' bgcolor='#EEEEEE' style='border: 1px solid #DBDBDB;'>
				    <td width='50%' style='padding-left: 5px;'>
				        ${dto.userName}
				    </td>
				    <td width='50%' align='right' style='padding-right: 5px;'>
				        ${dto.created}
		 <c:if test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
								| <a onclick='deleteReply("${dto.replyNum}", "${dto.userId}");'>삭제</a>
          </c:if>								
				    </td>
				</tr>
				<tr height='50'>
				    <td colspan='2' style='padding: 5px;' valign='top'>
				       ${dto.content}
				    </td>
				</tr>
				</c:forEach>
				
				<tr height='30'>
				    <td colspan='2' align='center'>
				    ${pagingReply}
				    </td>
				</tr>    
				</table>
          
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