<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
  <!-- Navigation -->
    <nav class="navbar navbar-inverse" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <a class="navbar-brand" href="<%=cp%>/">teamproj</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#">소개</a>
                    </li>
                    <li>
                        <a href="#">공지사항</a>
                    </li>
                    <li>
                        <a href="<%=cp%>/board/list.do">일반게시판</a>
                    </li>
                    <li>
                        <a href="#">포토게시판</a>
                    </li>
                    <li>
                        <a href="#">방명록</a>
                    </li>
                    <c:if test="${empty sessionScope.member}">
                   
                    <li>
                    <a href="#"><span class="glyphicon glyphicon-log-in"></span>로그인</a>
                    </li>
                    <li>
                    <a href="#"><span class="glyphicon glyphicon-user"></span>회원가입</a>
                    </li>
                    </c:if>
                    <c:if test="${not empty sessionScope.member}">
                	<li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">내정보 <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#">정보보기</a>
                            </li>
                            <li>
                                <a href="#">정보수정</a>
                            </li>
                            <li>
                                <a href="#">탈퇴</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                	<a href="#"><span style="color:blue;">${sessionScope.member.userName}</span>준겸님</a>
                	<c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin/main.do"> 관리자</a>
               	    </c:if>
               	    </li>
               	    <li>
              		<a href="<%=cp%>/member/logout.do"><span class="glyphicon glyphicon-log-out"></span>로그아웃</a>
                    </li>
                    </c:if>
                    <li>
                    </li>
                    <li>
              		<a href="#"><span class="glyphicon glyphicon-cloud"></span>사이트맵</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

