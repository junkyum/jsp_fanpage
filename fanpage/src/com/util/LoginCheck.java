package com.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import com.member.SessionInfo;

// @WebFilter("/*")
public class LoginCheck implements Filter {

	/*
	 * cp
	 * cp/main.do
	 * cp/index.jsp
	 * cp/member/login.do
	 * cp/member/login_ok.do
	 * cp/member/member.do
	 * cp/member_ok.do
	 */
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		
		
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		if(req instanceof HttpServletRequest){
			HttpServletRequest requset=(HttpServletRequest)req;
			HttpSession sesion=requset.getSession();
			SessionInfo info=(SessionInfo)sesion.getAttribute("member");
			
			String uri=requset.getRequestURI();
			String cp=requset.getContextPath();
			
			String [] uris={
					cp+"/main.do",
					cp+"/res/",
					cp+"/member/login.do",
					cp+"/member/login_ok.do",
					cp+"/member/member.do",
					cp+"/member/member_ok.do"};
	
			boolean b= false;
			for(String chk : uris){
				if(uri.startsWith(chk)){
					b=true;
					break;
				}
			}
			if(info!=null || uri.equals(cp+"/")) b=true;
			
			if(b){
				chain.doFilter(req, resp);
			}else{
				RequestDispatcher rd=requset.getRequestDispatcher("/WEB-INF/views/member/login.jsp");
				rd.forward(req, resp);
			}
			
		}
		
		
	}
	
	@Override
	public void destroy() {
		
		
	}



}
