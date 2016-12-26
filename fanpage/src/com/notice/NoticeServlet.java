package com.notice;

import java.io.File;
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
import com.notice.NoticeDAO;
import com.notice.NoticeDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.MyServlet;
import com.util.MyUtil;
@WebServlet("/notice/*")
public class NoticeServlet extends MyServlet{
	private static final long serialVersionUID = 1L;

	private SessionInfo info;
	private String pathname;

	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String uri = req.getRequestURI();
		HttpSession session = req.getSession();
		info=(SessionInfo)session.getAttribute("member");

		/*if(info==null){
			resp.sendRedirect(cp+"/member/login.do");
		}*/
		
		String root = session.getServletContext().getRealPath("/");
		pathname = root + File.separator+"uploads"+File.separator+"notice";
		
		File f = new File(pathname);
		if(! f.exists())
			f.mkdirs();
		
		if(uri.indexOf("list.do")!=-1){
			list(req, resp);			
		}else if(uri.indexOf("created.do")!=-1){
			created(req, resp);
		}else if(uri.indexOf("created_ok.do")!=-1){
			created_ok(req, resp);
		}else if(uri.indexOf("update.do")!=-1){
			update(req, resp);
		}else if(uri.indexOf("update_ok.do")!=-1){
			update_ok(req, resp);
		}else if(uri.indexOf("delete.do")!=-1){
			delete(req, resp);
		}else if(uri.indexOf("article.do")!=-1){
			article(req, resp);
		}
		
		
	}
	
	private void list(HttpServletRequest req, HttpServletResponse resp ) throws IOException, ServletException { //cp�� ������ �Ҷ��ּ� 
		NoticeDAO dao = new NoticeDAO();
		MyUtil util = new MyUtil();
		String cp = req.getContextPath();
		
		String page = req.getParameter("page");
		int current_page =1;
		if(page!=null)
			current_page=Integer.parseInt(page);
		
		String searchKey = req.getParameter("searchKey");
		String searchValue = req.getParameter("searchValue");
		if(searchKey==null){
			searchKey="subject";
			searchValue="";
		}
		if(req.getMethod().equalsIgnoreCase("GET")){
			searchValue=URLDecoder.decode(searchValue, "UTF-8");
		}
		
		int numPerPage = 6;
		int dataCount, total_page;
		
	/*	if(searchValue.length()!=0){
			dataCount = dao.dataCount(searchKey, searchValue);
		}else */		
			dataCount=dao.dataCount();
		
		total_page = util.pageCount(numPerPage, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start = (current_page-1)*numPerPage+1;
		int end = current_page*numPerPage;
		
		List<NoticeDTO> list;
		//if(searchValue.length()==0)
		list = dao.listNotice(start, end);
		//else 
			//list = dao.listNotice(start, end, searchKey, searchValue);
		
		//���� �� --? 
		List<NoticeDTO> listNotice = null;
		listNotice = dao.listNotice();
		Iterator<NoticeDTO> itNotice = listNotice.iterator();
		while(itNotice.hasNext()){
			NoticeDTO dto = itNotice.next();
			dto.setCreated(dto.getCreated().substring(0,10));
		}
		
/*		int listNum, n = 0;
		Iterator<NoticeDTO> it = list.iterator();
		while(it.hasNext()){
			NoticeDTO dto = it.next();
			listNum = dataCount-(start+n-1);
			dto.setNum(listNum);
			n++;
		}*/
				
		String listUrl=cp+"/notice/list.do";
		String articleUrl=cp+"/notice/article.do?page="+current_page;
		
		if(searchValue.length()!=0){
			listUrl += "$searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
			articleUrl += "&searchKey="+searchKey+"&searchValue="+URLEncoder.encode(searchValue, "UTF-8");
		}
		
		String paging=util.paging(current_page,	total_page, listUrl);
		
		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("total_page", total_page);
		req.setAttribute("articleUrl", articleUrl);
		req.setAttribute("paging", paging);
		req.setAttribute("searchKey", searchKey);
		
		forward(req,resp,"/WEB-INF/views/notice/list.jsp");
	}
	
	private void created(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
		req.setAttribute("mode", "created");
		forward(req, resp, "/WEB-INF/views/notice/created.jsp");
	}
	
	private void created_ok(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
		String cp = req.getContextPath();
		
		String encType="utf-8";
		int maxSize = 5*1024*1024;
		MultipartRequest mreq = new MultipartRequest(req, pathname, maxSize, encType, new DefaultFileRenamePolicy());
		
		//String saveFilename = mreq.getFilesystemName("upload");
		//saveFilename = FileManager.doFilerename(pathname,saveFilename);
				
		NoticeDTO dto = new NoticeDTO();
		NoticeDAO dao = new NoticeDAO();
		
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		if(mreq.getFile("upload")!=null){
			dto.setSavefileName(mreq.getFilesystemName("upload"));
			dto.setOriginalfileName(mreq.getOriginalFileName("upload"));
			dto.setFileSize(mreq.getFile("upload").length());
			
		}		
		dao.insertNotice(dto, "created");
		resp.sendRedirect(cp+"/notice/list.do");
	}
	private void article(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException{
		NoticeDAO dao = new NoticeDAO();
		NoticeDTO dto;
		
		int num = Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		
		dao.updateHitCount(num);
		dto = dao.readNotice(num);
				
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		req.setAttribute("dto", dto);
		req.setAttribute("page", page);
		
		forward(req,resp,"/WEB-INF/views/notice/article.jsp");
	}
	
	private void update(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException{
		int num = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		
		req.setAttribute("mode", "update");
		req.setAttribute("num", num);
		req.setAttribute("page", page);
		forward(req, resp, "/WEB-INF/views/notice/created.jsp");
	}
	
	private void update_ok(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException{
		NoticeDTO dto = new NoticeDTO();
		NoticeDAO dao = new NoticeDAO();
		String cp = req.getContextPath();
		String page = req.getParameter("page");
		
		dto.setNum(Integer.parseInt(req.getParameter("num")));
		dto.setSubject(req.getParameter("subject"));
		dto.setContent(req.getParameter("content"));
		dao.updateNotice(dto);
		resp.sendRedirect(cp+"/notice/list.do?page="+page);
	}
	
	private void delete(HttpServletRequest req, HttpServletResponse resp)throws IOException, ServletException{
		NoticeDAO dao = new NoticeDAO();
		NoticeDTO dto;
		
		int num = Integer.parseInt(req.getParameter("num"));
		String page = req.getParameter("page");
		dto = dao.readNotice(num);
		/*if(dto!=null && info.getUserId().equals("admin")){
			dao.deleteNotice(num);
		}*/
		
	}
}