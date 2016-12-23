package com.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.MyServlet;

@WebServlet("/board/*")
public class BoardServlet extends MyServlet{

	private static final long serialVersionUID = 1L;

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		if(uri.indexOf("list.do")!=-1) {
			
			forward(req, resp, "/WEB-INF/views/board/list.jsp");
		}
		if(uri.indexOf("created.do")!=-1) {
			
			forward(req, resp, "/WEB-INF/views/board/created.jsp");
		}
		if(uri.indexOf("article.do")!=-1) {
			
			forward(req, resp, "/WEB-INF/views/board/article.jsp");
		}
	}

}
