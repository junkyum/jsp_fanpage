<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<!-- Navigation -->
<div class="text-center" style="margin: 10px auto;">
	<a href="<%=cp%>/"><img src="<%=cp%>/res/images/logo.jpg"
		class="img-rounded"></a>
</div>
<nav class="navbar navbar-default" role="navigation"
	style="width: 1200px; margin: auto auto;">
	<div class="container">
		<!-- Brand and toggle get grouped for better mobile display -->

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-middle">
				<li><a href="#">소개</a></li>
				<li><a href="<%=cp%>/notice/list.do">공지사항</a></li>
				<li><a href="<%=cp%>/board/list.do">일반게시판</a></li>
				<li><a href="<%=cp%>/photo/list.do">포토게시판</a></li>
				<li><a href="<%=cp%>/visit/visit.do">방명록</a></li>



			</ul>
			<ul class="nav navbar-nav navbar-right">
				<c:if test="${empty sessionScope.member}">

					<li><a href="<%=cp%>/member/login.do"><span
							class="glyphicon glyphicon-log-in"></span>로그인</a></li>
					<li><a href="<%=cp%>/member/member.do"><span
							class="glyphicon glyphicon-user"></span>회원가입</a></li>
				</c:if>
				<c:if test="${not empty sessionScope.member}">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">내정보 <b class="caret"></b></a>
						<ul class="dropdown-menu">
							<li><a href="<%=cp%>/member/update.do">정보수정</a></li>
							<li><script type="text/javascript">
                               function dropUser() {
                           var url="<%=cp%>/member/delete.do";
                           if(confirm("탈퇴 가능?"))
                              location.href=url;
                        }
                            
                            </script> <a onclick="dropUser();">탈퇴</a></li>
						</ul></li>
					<li>
						<%-- <a href="#"><span style="color:blue;">${sessionScope.member.userName}</span>준겸님</a> --%>
						<button type="button" class="btn btn-danger navbar-btn dropdown-toggle"
							data-toggle="modal" data-target=".bs-example-modal-sm">${sessionScope.member.userName}</button>

						<div class="modal fade bs-example-modal-sm" tabindex="-1"
							role="dialog" aria-labelledby="mySmallModalLabel"
							aria-hidden="true">
							<div class="modal-dialog modal-sm">
								<div class="modal-content">
									<div class="list-group">
										<a class="list-group-item active"> <B>나의 정보</B><br> 
										    I D : ${member.userId}<br> NAME : ${member.userName}<br>
											H.P : ${member.userPhone}<br> MAIL : ${member.userEmail}<br>
											BIRTH : ${member.userBirth}<br> HOBBY : ${member.userHobby}<br>
										</a>
									</div>
								</div>
							</div>
						</div> <c:if test="${sessionScope.member.userId=='admin'}">
							<a href="<%=cp%>/admin/main.do"> 관리자</a>
						</c:if>
					</li>
					<li><a href="<%=cp%>/member/logout.do"><span
							class="glyphicon glyphicon-log-out"></span>로그아웃</a></li>
				</c:if>
				<li></li>
				<li><a href="#"><span class="glyphicon glyphicon-cloud"></span>사이트맵</a>
				</li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container -->
</nav>
