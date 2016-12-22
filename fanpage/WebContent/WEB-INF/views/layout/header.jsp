<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
  <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">fanpage</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#">소개</a>
                    </li>
                    <li>
                        <a href="#">공지사향</a>
                    </li>
                    <li>
                        <a href="#">일반게시판</a>
                    </li>
                    <li>
                        <a href="#">포토게시판</a>
                    </li>
                    <li>
                        <a href="#">방명록</a>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">내정보 <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="#">회원정보보기</a>
                            </li>
                            <li>
                                <a href="#">회원정보수정</a>
                            </li>
                            <li>
                                <a href="#">회원탈퇴</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

<div class="login header-login">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login.do"><span class="glyphicon glyphicon-log-in"></span> 로그인</a> <i></i>
                <a href="<%=cp%>/member/member.do"><span class="glyphicon glyphicon-user"></span> 회원가입</a>
            </c:if>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.userName}</span>님 <i></i>
                <c:if test="${sessionScope.member.userId=='admin'}">
                    <a href="<%=cp%>/admin/main.do">관리자</a> <i></i>
                </c:if>
                <a href="<%=cp%>/member/logout.do"><span class="glyphicon glyphicon-log-out"></span> 로그아웃</a>
            </c:if>
</div>