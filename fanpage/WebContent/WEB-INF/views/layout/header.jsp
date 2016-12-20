<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<div class="container">
    <div id="page-header">
        <div class="header-brand"><a href="<%=cp%>/"><span class="logo">Twice</span></a></div>
        <div class="login header-login">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a> <i></i>
                <a href="<%=cp%>/member/member.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.userName}</span>님 <i></i>
                <a href="<%=cp%>/member/logout.do"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a>
            </c:if>
        </div>
    </div>
</div>

<div class="container">
         <nav class="navbar navbar-default">
             <div class="container-fluid">
                  <div class="navbar-header">
                      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                          <span class="sr-only">Toggle navigation</span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                          <span class="icon-bar"></span>
                      </button>
                </div>
                
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="#">트와이스 소개</a></li>
                      	<li><a href="#">트와이스 일정</a></li>
                        <li><a href="#">트와이스 갤러리</a></li>
                        <li><a href="#">트와이스 게시판</a></li>
                        <li><a href="#">트와이스 방명록</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                    
                        <c:if test="${not empty sessionScope.member}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">마이페이지<span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">정보확인</a></li>
                                    <li role="separator" class="divider"></li>
                                    <li><a href="<%=cp%>/">정보수정</a></li>
                                    <li><a href="<%=cp%>/">회원탈퇴</a></li>
                                </ul>
                            </li>
                        </c:if>
                        <li><a href="#"><span class="glyphicon glyphicon-th"></span></a></li>
                    </ul>
                </div>
            </div>
        </nav>
</div>