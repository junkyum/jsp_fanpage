package com.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class NoticeDAO {
	private Connection conn = DBConn.getConnection();
	
	public int insertNotice(NoticeDTO dto, String mode){
		int res=0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "insert into notice(num,subject,content,savefileName, originalFilename, filesize, userid) values(?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			int num = maxNum()+1;
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSavefileName());
			pstmt.setString(5, dto.getOriginalfileName());
			pstmt.setLong(6, dto.getFileSize());
			pstmt.setString(7, dto.getUserId());
			res = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}		
		return res;
	}
	
	public int maxNum()
	{
		int result = 0;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = null;
		try {
			sql = "select nvl(max(num),0) from notice";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				result=rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	public int dataCount(){
		int result=0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql; 
		
		try {
			sql = "select NVL(count(*),0) from notice";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				result = rs.getInt(1);
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int dataCount(String searchKey, String searchValue){
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ;
		
		try {
			sql = "select count(*) from notice where ";
			if(searchKey.equals("subject"))
				sql += "subject like '%'||?||'%'";
			else if(searchKey.equals("content"))
				sql += "instr(content,?)>=1";
			else if(searchKey.equals("created"))
				sql += "to_char(created,'YYYY-MM-DD')=?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			rs = pstmt.executeQuery();
			if(rs.next())
				result = rs.getInt(1);
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	
	
	public int updateHitCount(int num){
		int result=0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "update notice set hitCount=hitCount+1 where num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}	
		return result;
	}
	
	public List<NoticeDTO> listNotice(int start, int end){
		List<NoticeDTO>list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("select * from(");
			sb.append("	select rownum rnum, tb.* from(");
			sb.append("   select num, subject, content, to_char(created, 'YYYY-MM-DD')created, hitCount, savefilename");
			sb.append("		from notice");
			sb.append("		order by num desc");
			sb.append("  )tb where rownum <=?");
			sb.append(")where rnum >=?");
						
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs = pstmt.executeQuery();
			while(rs.next()){
				NoticeDTO dto = new NoticeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setSavefileName(rs.getString("savefileName"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();	
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
	public List<NoticeDTO> listNotice(int start, int end, String searchKey, String searchValue){
		List<NoticeDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("select * from (select rownum rnum, tb.* from(");
			sb.append("	select num, subject, content, to_char(created, 'YYYY-MM-DD') created, hitCount");
			sb.append("		from notice ");
			sb.append("		where ");
			if(searchKey.equals("subject"))
				sb.append("subject like '%'||?||'%'");
			else if(searchKey.equals("content"))
				sb.append("instr(content,?) >=1");
			else if(searchKey.equals("created"))
				sb.append("to_char(created,'YYYY-MM-DD') =?");
			sb.append(" order by num desc)");
			sb.append("tb where rownum <=?) where rnum >=? ");
			
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2, end);
			pstmt.setInt(3, start);
			rs = pstmt.executeQuery();
			while(rs.next()){
				NoticeDTO dto = new NoticeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				
				list.add(dto);
			}
			rs.close(); 
			pstmt.close();			
		} catch (Exception e) {
			
		}
		
		return list;
	}
	
	public NoticeDTO readNotice(int num){
		NoticeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select num,subject, content, to_char(created,'YYYY-MM-DD') created, hitCount, savefilename, originalfilename, fileSize";
			sql += " from notice where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new NoticeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setSavefileName(rs.getString("savefilename"));
				dto.setOriginalfileName(rs.getString("originalfilename"));
				dto.setFileSize(rs.getLong("fileSize"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
		System.out.println(e.toString());
		}
		
		return dto;
	}
	
	public int updateNotice(NoticeDTO dto){
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			sql = "update notice set subject=?, content=?, ";
			sql += "savefileName=?, originalFilename=?, fileSize=? where num=? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getSavefileName());
			pstmt.setString(4, dto.getOriginalfileName());
			pstmt.setLong(5, dto.getFileSize());
			pstmt.setInt(6, dto.getNum());
			result = pstmt.executeUpdate();
			
			pstmt.close();			
		} catch (Exception e) {
			System.out.println(e.toString());
		}		
		return result;
	}
	
	public int deleteNotice(int num){
		int result=0;
		PreparedStatement pstmt = null;
		String sql;
		 
		try {
			sql = "delete from notice where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
}
