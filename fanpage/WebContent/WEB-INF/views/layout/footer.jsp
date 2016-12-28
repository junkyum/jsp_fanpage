<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<footer class="bs-docs-footer" role="contentinfo">
    <div class="container">
        <ul class="bs-docs-footer-links text-muted">
            <li><a href="<%=cp%>/">트와이스팬페이지</a></li>
            <li>&middot;</li>
            <li><a href="<%=cp%>/board/introduce.do">트와이스소개</a></li>
            <li>&middot;</li><br>
            <li>트와이스 팬페이지에서는 개인정보를 취급하지 않습니다.</li>
            <li>&middot;</li>
            <li>© Twice Corp.</li>
        </ul>
    </div>        
</footer>