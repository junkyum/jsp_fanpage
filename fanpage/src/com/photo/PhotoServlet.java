package com.photo;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.SessionInfo;
/*import com.member.SessionInfo;
*///import com.member.SessionInfo;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
import com.util.MyUtil;

import sun.nio.cs.HistoricallyNamedCharset;
@WebServlet("/photo/*")
public class PhotoServlet extends MyServlet {
	private static final long serialVersionUID = 1L;
	private SessionInfo info;
	private	String pathname;
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		String uri=req.getRequestURI();
		String cp=req.getContextPath();
		HttpSession session = req.getSession();
		info = (SessionInfo)session.getAttribute("member");
		if(info==null)
		{
			resp.sendRedirect(cp+"/member/login.do");
			return;
		}
		String root = session.getServletContext().getRealPath("/");
		pathname = root+File.separator+"uploads"+File.separator+"photo";
		File f = new File(pathname);
		if(!f.exists())
		{
			f.mkdirs();
		}
		if(uri.indexOf("list.do")>-1)
		{
			list(req,resp); 
		}
		if(uri.indexOf("created.do")>-1)
		{
			created(req,resp);
		}
		if(uri.indexOf("created_ok.do")>-1)
		{
			created_ok(req,resp);
		}
		if(uri.indexOf("article.do")>-1)
		{
			article(req,resp);
		}
		if(uri.indexOf("update.do")>-1)
		{
			update(req,resp);
		}
		if(uri.indexOf("update_ok.do")>-1)
		{
			update_ok(req,resp);
		}
		if(uri.indexOf("delete.do")>-1)
		{
			delete(req,resp);
		}
		if(uri.indexOf("insertReply.do")!=-1) 
		{
			insertReply(req, resp);
		} 
		if(uri.indexOf("deleteReply.do")!=-1) 
		{
			deleteReply(req, resp);
		}
	}
	
	private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		MyUtil util = new MyUtil();
		String cp=req.getContextPath();
		PhotoDAO dao = new PhotoDAO();
		String page=req.getParameter("page");
		int current_page=1;
		if(page!=null)
			current_page=Integer.parseInt(page);
		int numPerPage=6;
		int dataCount, total_page;
		
		dataCount=dao.dataCount();
		
		total_page=util.pageCount(numPerPage, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;

		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		
		List<PhotoDTO> list;
			list=dao.listPhoto(start, end);
			
		
		int listNum, n=0;
		Iterator<PhotoDTO> it=list.iterator();
		while(it.hasNext()) {
			PhotoDTO dto=it.next();
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}

		String listUrl=cp+"/photo/list.do";
		String articleUrl=cp+"/photo/article.do?page="+
				current_page;
	
		String paging=util.paging(current_page,
				total_page, listUrl);

		req.setAttribute("list", list);
		req.setAttribute("page", current_page);
		req.setAttribute("dataCount", dataCount);
		req.setAttribute("total_page", total_page);
		req.setAttribute("paging", paging);
		req.setAttribute("articleUrl", articleUrl);

		forward(req,resp,"/WEB-INF/views/photo/list.jsp");
	}
	
	private void created(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		req.setAttribute("mode","created");
		forward(req,resp,"/WEB-INF/views/photo/created.jsp");
	}
	private void created_ok(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		String cp=req.getContextPath();
		
		String encType = "UTF-8";
		int maxSize = 5*1024*1024;
		MultipartRequest mreq=new MultipartRequest(req, pathname, maxSize,encType, new DefaultFileRenamePolicy());
		String saveFileName=mreq.getFilesystemName("upload");
		saveFileName=FileManager.doFilerename(pathname, saveFileName);
		PhotoDAO dao = new PhotoDAO();
		PhotoDTO dto = new PhotoDTO();
		
		dto.setUserId(info.getUserId());
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		dto.setImageFilename(saveFileName);
		
		dao.insertPhoto(dto);
		
		resp.sendRedirect(cp+"/photo/list.do");
	}
	
	private void article(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		PhotoDTO dto;
		PhotoDAO dao = new PhotoDAO();
		MyUtil util = new MyUtil();
		
		int num = Integer.parseInt(req.getParameter("num"));
		//조회수

		dao.updateHitCount(num);
		
		
		int current_page=1;
		String pageNo=req.getParameter("pageNo");
		if(pageNo!=null)
			current_page=Integer.parseInt(pageNo);
		
		int dataCountReply=dao.dataCountReply(num);
		int numPerPage=5;
		int total_page=util.pageCount(numPerPage, dataCountReply);
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*numPerPage+1;
		int end=current_page*numPerPage;
		
		List<ReplyPhotoDTO> listReply=dao.listReply(num, start, end);
		
		Iterator<ReplyPhotoDTO>it=listReply.iterator();
		while(it.hasNext()) {
			ReplyPhotoDTO rdto=it.next();
			rdto.setContent(rdto.getContent().replaceAll("\n", "<br>"));
		}
		
		String pagingReply=util.paging(current_page, total_page);
		
		
		String page=req.getParameter("page");
		
		String params="page="+page;
		
		
		dto=dao.readPhoto(Integer.parseInt(req.getParameter("num")));
		
		req.setAttribute("page", page);
		req.setAttribute("dto", dto);
		req.setAttribute("params", params);
		req.setAttribute("listReply", listReply);
		req.setAttribute("pageNo", current_page);
		req.setAttribute("dataCountReply", dataCountReply);
		req.setAttribute("pagingReply", pagingReply);
		
		
		
		
		forward(req,resp,"/WEB-INF/views/photo/article.jsp");
		
		
		
		
		
		
	}
	
	private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		PhotoDAO dao = new PhotoDAO();
		PhotoDTO dto = dao.readPhoto(Integer.parseInt(req.getParameter("num")));
		String page = req.getParameter("page");
		req.setAttribute("mode","update");
		req.setAttribute("page", page);
		req.setAttribute("dto", dto);
		forward(req,resp,"/WEB-INF/views/photo/created.jsp");
	}
	
	private void update_ok(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		MyUtil util = new MyUtil();
		PhotoDAO dao = new PhotoDAO();
		HttpSession session = req.getSession();
		String cp=req.getContextPath();
		String root = session.getServletContext().getRealPath("/");
		pathname = root+File.separator+"uploads"+File.separator+"photo";
		String encType = "UTF-8";
		int maxSize = 5*1024*1024;
		MultipartRequest mreq=new MultipartRequest(req, pathname, maxSize,encType, new DefaultFileRenamePolicy());
		String oldfile = mreq.getParameter("imageFilename");
		PhotoDTO dto = dao.readPhoto(Integer.parseInt(mreq.getParameter("num")));
		String saveFileName=mreq.getFilesystemName("upload");
		
		if(saveFileName==null)
			saveFileName=oldfile;
		
		if(!oldfile.equals(saveFileName))
			FileManager.doFiledelete(pathname, oldfile);
		
		saveFileName=FileManager.doFilerename(pathname, saveFileName);
		
		dto.setSubject(mreq.getParameter("subject"));
		dto.setContent(mreq.getParameter("content"));
		dto.setImageFilename(saveFileName);
		String page = mreq.getParameter("page");
		dao.updatePhoto(dto);
		resp.sendRedirect(cp+"/photo/list.do?page="+page);
	}
	
	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/");
		pathname = root+File.separator+"uploads"+File.separator+"photo";
		String filename=req.getParameter("imageFilename");
		FileManager.doFiledelete(pathname, filename);
		String cp=req.getContextPath();
		String page = req.getParameter("page");
		PhotoDAO dao = new PhotoDAO();
		
		dao.deletePhoto(Integer.parseInt(req.getParameter("num")));
		resp.sendRedirect(cp+"/photo/list.do?page="+page);
	}
	//
	
	private void insertReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리플 저장하기 ---------------------------------------
		String cp = req.getContextPath();
		
		HttpSession session = req.getSession();
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		PhotoDAO dao = new PhotoDAO();
		
		int num=Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		PhotoDTO dto=dao.readPhoto(num);
		if(dto==null) {
			resp.sendRedirect(cp+"/photo/list.do?page="+page);
			return;
		}
		
		ReplyPhotoDTO rdto=new ReplyPhotoDTO();
		rdto.setNum(num);
		rdto.setUserId(info.getUserId());
		rdto.setContent(req.getParameter("content"));
		
		dao.insertReply(rdto);
		
		String path=cp+"/photo/article.do?num="+num+"&page="+page;
		resp.sendRedirect(path);
	}	
//
	private void deleteReply(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 리플 삭제 ---------------------------------------
		String cp = req.getContextPath();
		PhotoDAO dao = new PhotoDAO();
	
		int replyNum=Integer.parseInt(req.getParameter("replyNum"));
		int num=Integer.parseInt(req.getParameter("num"));
		String page=req.getParameter("page");
		String pageNo=req.getParameter("pageNo");
		
		dao.deleteReply(replyNum);
		
		String path=cp+"/photo/article.do?num="+num+"&page="+page+"&pageNo="+pageNo;
		resp.sendRedirect(path);
	}
}
