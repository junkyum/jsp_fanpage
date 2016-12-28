package com.visit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class VisitDAO {
	private Connection conn=DBConn.getConnection();
	
	public int insertVisit(VisitDTO dto) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="INSERT INTO visit(num, userId, userName, content) VALUES (visit_seq.NEXTVAL, ?, ?, ?)";
			
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserName());
			pstmt.setString(3, dto.getContent());
			
			result=pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	public int dataCount() {
		// 전체 데이터 개수 구하기
		int result=0;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql;
		
		try {
			sql="select nvl(count(*), 0) from visit";
			pstmt=conn.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	
	public List<VisitDTO> listVisit(int start, int end) {
		List<VisitDTO> list=new ArrayList<VisitDTO>();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		StringBuffer sb=new StringBuffer();
		
		try {
			sb.append("select * from (");
			sb.append("  select rownum rnum, tb.* from (");
			sb.append("    select num, userId, userName, content, to_char(created, 'YYYY-MM-DD') created ");
			sb.append("    from visit");
			sb.append("    order by num DESC");
			sb.append("  ) tb where rownum <=?");
			sb.append(") where rnum >= ?");

			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setInt(1, end);
			pstmt.setInt(2, start);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				VisitDTO dto=new VisitDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	
	public int deleteVisit(int num) {
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		
		try {
			sql="DELETE FROM visit WHERE num=?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			result=pstmt.executeUpdate();
			pstmt.close();
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	
	public int updateVisit(VisitDTO dto) {
		 int result=0;
         PreparedStatement pstmt = null;
         String sql;
         
         try {
            sql ="UPDATE visit SET content=? where num=?";
            pstmt =conn.prepareStatement(sql);
            
            pstmt.setString(1, dto.getContent());
            pstmt.setInt(2, dto.getNum());
            
            
            result=pstmt.executeUpdate();
            pstmt.close();
            
         } catch (Exception e) {
            System.out.println(e.toString());
         }
         return result;
	}
	
	
}
