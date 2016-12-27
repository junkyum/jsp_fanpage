package com.member;

import java.io.File;
import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.util.FileManager;
import com.util.MyServlet;
@WebServlet("/member/*")
public class MemberServlet extends MyServlet{

	private static final long serialVersionUID = 1L;
	private String pathname;
	private SessionInfo info;
	@Override
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String cp= req.getContextPath();
		String uri= req.getRequestURI();//member
		///////////////////////////////////////////////////////



		if(uri.indexOf("login.do")!=-1) { login(req, resp); }

		else if(uri.indexOf("login_ok.do")!=-1) { login_chk(req, resp); }//���ο��� ȸ������ ��������login_chk(req, resp);}

		else if(uri.indexOf("logout.do")!=-1) { logout( req, resp); }//ȸ�������Է� ���ϰ� �Ϸᴩ������


		else if(uri.indexOf("member.do")!=-1) { memberK(req, resp); }//���ο��� ȸ������ ��������

		else if(uri.indexOf("member_ok.do")!=-1) { memberK_chk(req, resp); }//ȸ�������Է� ���ϰ� �Ϸᴩ������

		///////////////////���δ� ��  ���� ���Խ� �Ⱦ�.

		else if(uri.indexOf("update.do")!=-1) { update( req, resp); }//ȸ�������Է� ���ϰ� �Ϸᴩ������

		else if(uri.indexOf("update_ok.do")!=-1) { update_ok( req, resp); }//ȸ�������Է� ���ϰ� �Ϸᴩ������

		else if(uri.indexOf("delete.do")!=-1) { delete( req, resp); }//Ż�� ����������  ����


	}

	//�α��� â ���������� �׼�
	private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}

	private void login_chk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		MemberDAO dao=new MemberDAO();
		String cp=req.getContextPath();


		String userId= req.getParameter("userId");//���̵�
		String userPw= req.getParameter("userPw");//�佺����



		MemberDTO dto =dao.readMember(userId);

		if(dto==null || !dto.getUserPw().equals(userPw)){
			req.setAttribute("message", "ID �� PW Ʋ����>_<");
			forward(req, resp, "/WEB-INF/views/member/login.jsp");
			return;
		}

		HttpSession sesion= req.getSession();
		SessionInfo info = new SessionInfo();

		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());
		info.setUserPhone(dto.getUserPhone());
		info.setUserEmail(dto.getUserEmail());
		info.setUserBirth(dto.getUserBirth());
		info.setUserHobby(dto.getUserHobby());
		info.setMyPhoto(dto.getMyPhoto());
		
		
		sesion.setAttribute("member",info);


		resp.sendRedirect(cp);

	}




	//���ο��� ȸ�������� ���������� ����.
	private void memberK(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		req.setAttribute("mode", "created");

		forward(req, resp, "/WEB-INF/views/member/member.jsp");
	}

	//ȸ�� ���� �Է��ϰ� ȸ�������� ��������.
	private void memberK_chk(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		MemberDTO dto= new MemberDTO();
		MemberDAO dao= new MemberDAO();
		int result=0;
		
			//////////////////////////////////////////////
		HttpSession sesion = req.getSession();
		String root= sesion.getServletContext().getRealPath("/");
		pathname=root+File.separator+"uploads"+File.separator+"myPhoto";
	
		File f= new File(pathname);
		if(!f.exists())
			f.mkdirs();
	
			
		String cp= req.getContextPath();
			
		String encType="UTF-8";
		int maxSize=5*1024*1024;
		MultipartRequest mreq=new MultipartRequest(req, pathname, maxSize, encType, new DefaultFileRenamePolicy());
			
		String saveFile = mreq.getFilesystemName("myPhoto");
		saveFile=FileManager.doFilerename(pathname, saveFile);
	
		dto.setMyPhoto(saveFile);			
		dto.setUserId(mreq.getParameter("userId"));
		dto.setUserName(mreq.getParameter("userName"));
		dto.setUserPw(mreq.getParameter("userPw"));
		dto.setUserEmail(mreq.getParameter("userEmail"));
		dto.setUserBirth(mreq.getParameter("userBirth"));

		String [] ss= mreq.getParameterValues("userHobby");
		String hobby=" ";

		if(ss !=null ){
			for (int i = 0; i < ss.length; i++) {
				hobby+=ss[i];
			}
		}
		
		dto.setUserHobby(hobby);

		String userPhone1=mreq.getParameter("userPhone1");
		String userPhone2=mreq.getParameter("userPhone2");
		String userPhone3=mreq.getParameter("userPhone3");

		if(userPhone1!=null && userPhone1.length() !=0 && userPhone2!=null && userPhone2.length() !=0 &&
				userPhone3!=null && userPhone3.length() !=0 ){
			dto.setUserPhone(userPhone1+"-"+userPhone2+"-"+userPhone3);
		}//,��ȭ��ȣ
		
		result=dao.putMember(dto);
		
		String message=" ȸ�������ϼ���  ����ȭ������ ���ư�";

		req.setAttribute("title", "ȸ�� ����");
		req.setAttribute("userName", dto.getUserName());
		req.setAttribute("message", message);

		forward(req, resp, "/WEB-INF/views/member/congratulations.jsp");
	}

	private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		String cp=req.getContextPath();
		HttpSession sesion= req.getSession();	

		sesion.removeAttribute("member");
		sesion.invalidate();


		resp.sendRedirect(cp+"/main.do");
	}

	private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		MemberDTO dto = new MemberDTO(); 

		HttpSession sesion= req.getSession();
		//System.out.println(sesion.getAttribute("member"));
		SessionInfo info= (SessionInfo)sesion.getAttribute("member");
		
		String userId= info.getUserId();
		String userName = info.getUserName();
		String myPhoto=info.getMyPhoto();
		dto.setUserId(userId);
		dto.setUserName(userName);
		dto.setMyPhoto(myPhoto);

		req.setAttribute("mode","update");
		req.setAttribute("dto", dto);

		forward(req, resp, "/WEB-INF/views/member/member.jsp");
	}


	private void update_ok(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{

		String cp = req.getContextPath();

		MemberDTO dto = new MemberDTO();
		MemberDAO dao = new MemberDAO();
/////////////////////////////////////////////////////////
		HttpSession sesion = req.getSession();
		String root= sesion.getServletContext().getRealPath("/");
		pathname=root+File.separator+"uploads"+File.separator+"myPhoto";
		SessionInfo info = (SessionInfo)sesion.getAttribute("member");	
		String encType="UTF-8";
		int maxSize=5*1024*1024;
		MultipartRequest mreq=new MultipartRequest(req, pathname, maxSize, encType, new DefaultFileRenamePolicy());
			
		String saveFile = mreq.getFilesystemName("myPhoto");
		if(saveFile!=null){
			saveFile=FileManager.doFilerename(pathname, saveFile);
			dto.setMyPhoto(saveFile);	
			info.setMyPhoto(saveFile);

		}else {
			dto.setMyPhoto(mreq.getParameter("imgFile"));	
		}
//////////////////////////////////////////////////////////////
		dto.setUserId(mreq.getParameter("userId"));
		dto.setUserName(mreq.getParameter("userName"));
		dto.setUserPw(mreq.getParameter("userPw"));
		dto.setUserEmail(mreq.getParameter("userEmail"));
		dto.setUserBirth(mreq.getParameter("userBirth"));
		String [] ss= mreq.getParameterValues("userHobby");
		String hobby="";
		for (int i = 0; i < ss.length; i++) {
			hobby+=ss[i];
		}
		dto.setUserHobby(hobby);
		String userPhone1=mreq.getParameter("userPhone1");
		String userPhone2=mreq.getParameter("userPhone2");
		String userPhone3=mreq.getParameter("userPhone3");
		if(userPhone1!=null && userPhone1.length() !=0 && userPhone2!=null && userPhone2.length() !=0 &&
				userPhone3!=null && userPhone3.length() !=0 ){
			dto.setUserPhone(userPhone1+"-"+userPhone2+"-"+userPhone3);
		}
		//		String message="�����մϴ�   "+dto.getUserName()+" �� �������� �߽��ϴ�.";


		dao.updateUser(dto);

		resp.sendRedirect(cp+"/main.do");

	}
	
	
	//Ż�� �������� ��Ȳ
	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
		
		MemberDAO dao= new MemberDAO();
		HttpSession sesion= req.getSession();
		//System.out.println(sesion.getAttribute("member"));
		SessionInfo info= (SessionInfo)sesion.getAttribute("member");
		String userId= (String)info.getUserId();
		req.setAttribute("userId", userId);
		int check=dao.delete(userId);
		if(check==1)
			sesion.invalidate();
		
		
		
		forward(req, resp, "/WEB-INF/views/member/login.jsp");
	}
	
	
	
	

}
