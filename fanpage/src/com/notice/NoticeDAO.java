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
			sql = "insert into notice(num,notice,subject,content,savefileName, originalFilename, filesize) values(notice_seq.NextVAL,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNotice());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSavefileName());
			pstmt.setString(5, dto.getOriginalfileName());
			pstmt.setLong(6, dto.getFileSize());
			
			res = pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}		
		return res;
	}
	
	public int dataCount(){
		int result=0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql; 
		
		try {
			sql = "select count(*) from notice";
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
	
/*	public int dataCount(String searchKey, String searchValue){
		int result=0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "";
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}*/
	
	
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
			sb.append("   select num, notice, subject, content, to_char(created, 'yyyy-mm-dd')created, hitCount");
			sb.append("		, saveFilename from notice");
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
				dto.setNotice(rs.getInt("notice"));
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
	
	public List<NoticeDTO> listNotice(){
		List<NoticeDTO>list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		StringBuffer sb = new StringBuffer();
		
		try {
			sb.append("select num, subject, content, saveFilename, hitCount, to_char(created,'yyyy-dd-mm') created ");
			sb.append("from notice");
			sb.append("where notice=1");
			sb.append("order by num desc");
			
			pstmt = conn.prepareStatement(sb.toString());
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				NoticeDTO dto = new NoticeDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setSavefileName(rs.getString("savefileName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return list;
	}
	
	public NoticeDTO readNotice(int num){
		NoticeDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			sql = "select num, notice, subject, content, to_char(created,'yyyy-mm-dd') created, hitCount, savefilename, originalfilename";
			sql += " from notice where num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new NoticeDTO();
				dto.setNum(rs.getInt("num"));
				dto.setNotice(rs.getInt("notice"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setSavefileName(rs.getString("savefilename"));
				dto.setOriginalfileName(rs.getString("originalfilename"));
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
			sql = "update notice set subject=?, content=? where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNum());
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
