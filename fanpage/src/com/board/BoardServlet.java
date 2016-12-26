package com.board;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
import com.util.MyServlet;
import com.util.MyUtil;

@WebServlet("/board/*")
public class BoardServlet extends MyServlet{

	private static final long serialVersionUID = 1L;
	
	private SessionInfo info;
	private String pathname;
	
	

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		HttpSession session = req.getSession();
		info = (SessionInfo)session.getAttribute("member");
		if(info==null)
		{
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		if(uri.indexOf("list.do")!=-1) {
			
			list(req, resp);
		}
		if(uri.indexOf("created.do")!=-1) {
			
			created(req, resp);
		}
		if(uri.indexOf("created_ok.do")!=-1) {
			
			created_ok(req, resp);
		}
		if(uri.indexOf("article.do")!=-1) {
			
			article(req, resp);
		}
		if(uri.indexOf("reply.do")!=-1) {
			
			reply(req, resp);
		}
		if(uri.indexOf("reply_ok.do")!=-1) {
			
			reply_ok(req, resp);
		}
		if(uri.indexOf("update.do")!=-1) {
			
			update(req, resp);
		}
		if(uri.indexOf("update_ok.do")!=-1) {
			
			update_ok(req, resp);
		}
		if(uri.indexOf("delete.do")!=-1) {
			
			delete(req, resp);
		}
	}

	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		BoardDAO dao = new BoardDAO();
		MyUtil util = new MyUtil();
		String cp = req.getContextPath();
		String page=req.getParameter("page");
		int current_page=1;
		if(page!=null)
			current_page=Integer.parseInt(page);

		String searchKey=req.getParameter("searchKey");
		String searchValue=req.getParameter("searchValue");
		if(searchKey==null) {
			searchKey="subject";
			searchValue="";
		}
		if(req.getMethod().equalsIgnoreCase("GET")) {
			searchValue=URLDecoder.decode(
					searchValue, "UTF-8");
		}

		int numPerPage=10;
		
		int dataCount, total_page;

		if(searchValue.length()==0)
			dataCount=dao.dataCount();
		else
			dataCount=dao.dataCount(searchKey, searchValue);

		total_page=util.pageCount(numPerPage, dataCount);
		if(current_page>total_page)
			current_page=total_page;

		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		List<BoardDTO> list;
		if(searchValue.length()==0)
			list=dao.listBoard(start, end);
		else
			list=dao.listBoard(start, end, searchKey, searchValue);

		int listNum, n=0;
		Iterator<BoardDTO> it=list.iterator();
		while(it.hasNext()) {
			BoardDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}

		String listUrl=cp+"/board/list.do";
		String articleUrl=cp+"/board/article.do?page="+
				current_page;
		if(searchValue.length()!=0) {
			listUrl+="&searchKey="+searchKey
					+"&searchValue="
					+URLEncoder.encode(searchValue, "UTF-8");
			articleUrl+="&searchKey="+searchKey
					+"&searchValue="
					+URLEncoder.encode(searchValue, "UTF-8");
		}

		String paging=util.paging(current_page,
				total_page, listUrl);

		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("total_page", total_page);
		req.setAttribute("paging", paging);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("rows", numPerPage);
		req.setAttribute("searchKey", searchKey);
		req.setAttribute("searchValue", searchValue);
		forward(req, resp, "/WEB-INF/views/board/list.jsp");
		
	}
	private void created(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/board/created.jsp");
		
	}
	private void created_ok(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		BoardDTO dto = new BoardDTO();
		dto.setUserId(info.getUserId());
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));
		dao.insertBoard(dto, "created");

		resp.sendRedirect(cp+"/board/list.do");
		
	}
	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		//게시물번호,페이지번호,rows(서치키,서치벨류)
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");

		if(searchKey==null){
			searchKey="subject";
			searchValue="";
		}
		searchValue=URLDecoder.decode(searchValue,"UTF-8");

		//조회수증가
		dao.updateHitCount(boardNum);
		//데이터가져오기
		BoardDTO dto = dao.readBoard(boardNum);
		//없으면 list로
		if(dto==null){
			resp.sendRedirect(cp+"/board/list.do?page="+page);
			return;
		}
		// 이전글 다음글
		BoardDTO preReadDto=dao.preReadBoard(dto.getGroupNum(), dto.getOrderNo(), 
				searchKey, searchValue);
		BoardDTO nextReadDto=dao.nextReadBoard(dto.getGroupNum(), dto.getOrderNo(), 
				searchKey, searchValue);

		//포워딩 jsp에 넘길 데이터
		String params="page="+page;
		if(searchValue.length()!=0){
			params+="&searchKey="+searchKey;
			params+="&searchValue="+URLEncoder.encode(searchValue,"UTF-8");
		}
		req.setAttribute("dto",dto);
		req.setAttribute("page",page);
		req.setAttribute("params",params);
		req.setAttribute("preReadDto", preReadDto);
		req.setAttribute("nextReadDto", nextReadDto);
		
		forward(req, resp, "/WEB-INF/views/board/article.jsp");
	}
	private void reply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");
		BoardDTO dto = dao.readBoard(boardNum);
		String s="["+dto.getSubject()+"]에 대한 답변\n";
		dto.setContent(s);
		req.setAttribute("dto", dto);
		req.setAttribute("mode", "reply");
		req.setAttribute("page", page);
		forward(req, resp, "/WEB-INF/views/board/created.jsp");
		
	}
	private void reply_ok(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		//subject,content,groupNum(아버지),orderNo(아버지),Depth(아버지)
		//parent(아버지의 boardNum)
		//rows,page
		//userId<-로그인한 아이디
		BoardDTO dto = new BoardDTO();
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));
		dto.setGroupNum(Integer.parseInt(req.getParameter("groupNum")));
		dto.setDepth(Integer.parseInt(req.getParameter("depth")));
		dto.setOrderNo(Integer.parseInt(req.getParameter("orderNo")));
		dto.setParent(Integer.parseInt(req.getParameter("parent")));
		dto.setUserId(info.getUserId());
		
		String page = req.getParameter("page");
		
		dao.insertBoard(dto, "reply");
		resp.sendRedirect(cp+"/board/list.do?page="+page);
		
		
	}
	private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");
		req.setAttribute("mode", "update");
		req.setAttribute("boardNum", boardNum);
		req.setAttribute("page", page);
		forward(req, resp, "/WEB-INF/views/board/created.jsp");
	}
		
	
	private void update_ok(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		BoardDTO dto = new BoardDTO();
		dto.setBoardNum(Integer.parseInt(req.getParameter("boardNum")));
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));
		String page = req.getParameter("page");
		dao.updateBoard(dto);
		resp.sendRedirect(cp+"/board/list.do?page="+page);
		
	}
	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		BoardDAO dao = new BoardDAO();
		String cp = req.getContextPath();
		int boardNum = Integer.parseInt(req.getParameter("boardNum"));
		String page = req.getParameter("page");

		BoardDTO dto = dao.readBoard(boardNum);
		if(dto!=null&&(info.getUserId().equals("admin")||dto.getUserId().equals(info.getUserId())))
		{
			dao.deleteBoard(boardNum);
			
		}
		resp.sendRedirect(cp+"/board/list.do?page="+page);
		
	}
	
	
}
