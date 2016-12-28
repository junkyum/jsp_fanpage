package com.visit;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/visit/*")
public class VisitServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	private SessionInfo info;

	VisitDAO dao=new VisitDAO();

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");

		String uri=req.getRequestURI();
		HttpSession session=req.getSession();

		info = (SessionInfo)session.getAttribute("member");

		if(uri.indexOf("visit.do")!=-1) {
			visit(req,resp);
		}
		else if(uri.indexOf("visit_ok.do")!=-1) {
			visit_ok(req, resp);
		}
		else if(uri.indexOf("delete.do")!=-1) {
			delete(req, resp);
		}
		else if(uri.indexOf("update.do")!=-1) {
			update(req, resp);
		}
	}

	private void visit(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

		String cp=req.getContextPath();
		MyUtil util=new MyUtil();

		String page=req.getParameter("page");
		int current_page=1;
		if(page!=null)
			current_page=Integer.parseInt(page);

		int dataCount;
		int numPerPage = 6;
		int total_page;

		dataCount=dao.dataCount();

		total_page = util.pageCount(numPerPage, dataCount);
		if(current_page>total_page)
			current_page=total_page;

		int start = (current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;

		List<VisitDTO> list=dao.listVisit(start, end);

		String listUrl=cp+"/visit/visit.do";
		String articleUrl=cp+"/visit/visit.do?page="+current_page;

		String paging=util.paging(current_page, total_page, listUrl);

		// visit.jsp 페이지에 넘길 데이터
		req.setAttribute("member", info);
		req.setAttribute("list", list);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("page", current_page);
		req.setAttribute("total_page", total_page);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("paging", paging);

		forward(req, resp, "/WEB-INF/views/visit/visit.jsp");
	}
	private void visit_ok(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		VisitDTO dto = new VisitDTO();
        if(info==null) {
           dto.setUserId("guest");
           dto.setUserName("guest");
        }
        else {
           dto.setUserId(info.getUserId());
           dto.setUserName(info.getUserName());
        }
     
        dto.setContent(req.getParameter("content"));
        
        dao.insertVisit(dto);
        
        // forward(req, resp, "/WEB-INF/views/visit/visit.jsp");
        // resp.sendRedirect("/WEB-INF/views/visit/visit.jsp");
        
        visit(req,resp);
	}

	private void delete(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

		int num =Integer.parseInt(req.getParameter("num"));
		String pageNum=req.getParameter("page");

		dao.deleteVisit(num);

		forward(req, resp, "/WEB-INF/views/visit/visit.jsp?page="+pageNum);

	}

	
	private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		VisitDTO dto = new VisitDTO();
		dto.setContent(req.getParameter("content"));
		
		String pageNum=req.getParameter("page");
		
		dao.updateVisit(dto);
		
		forward(req, resp, "/WEB-INF/views/visit/visit.jsp?page="+pageNum);

	}

}