package com.visit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;

@WebServlet("/visit/*")
public class VisitServlet extends MyServlet{

	private static final long serialVersionUID = 1L;
	
	VisitDAO dao=new VisitDAO();

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		HttpSession seccion= req.getSession();
		SessionInfo info=(SessionInfo)seccion.getAttribute("member");
		
		String uri=req.getRequestURI();
		// String cp = req.getContextPath();
		
		
		if(uri.indexOf("visit.do")!=-1) {
			forward(req, resp, "/WEB-INF/views/visit/visit.jsp");
		}
		else if(uri.indexOf("visit_ok.do")!=-1) {
			
			VisitDTO dto = new VisitDTO();
			if(info==null) 
				dto.setUserId("guest");
			else
				dto.setUserId(info.getUserId());
		
			dto.setContent(req.getParameter("content"));
			
			dao.insertVisit(dto);
			
			forward(req, resp, "/WEB-INF/views/visit/visit.jsp");
		}
		else if(uri.indexOf("delete.do")!=-1) {
			int num =Integer.parseInt(req.getParameter("num"));
			String pageNum=req.getParameter("page");
			
			dao.deleteVisit(num);
			
			forward(req, resp, "/WEB-INF/views/visit/visit.jsp?page="+pageNum);
			
		}
	}
	
	
	

}