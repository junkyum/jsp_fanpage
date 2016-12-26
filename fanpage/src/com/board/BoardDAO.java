package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class BoardDAO {
	private Connection conn = DBConn.getConnection();
	public int insertBoard(BoardDTO dto, String mode)
	{
		int result=0;
		PreparedStatement pstmt=null;
		String sql;
		try {
			sql="insert into board(boardnum,userId,subject,content,groupnum,depth,orderno,parent) VALUES(?,?,?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			int boardNum = maxBoardNum()+1;
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			if(mode.equals("created"))
			{//일반인 경우
			pstmt.setInt(5, boardNum);
			pstmt.setInt(6, 0);
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 0);
			}
			else if(mode.equals("reply"))
			{//답변인 경우
			updateOrderNo(dto.getGroupNum(),dto.getOrderNo());
			dto.setDepth(dto.getDepth()+1);
			dto.setOrderNo(dto.getOrderNo()+1);
			
			pstmt.setInt(5, dto.getGroupNum());
			pstmt.setInt(6, dto.getDepth());
			pstmt.setInt(7, dto.getOrderNo());
			pstmt.setInt(8, dto.getParent());
			}
			pstmt.executeUpdate();
			pstmt.close();
		} 
		catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
	}
	public int maxBoardNum()
	{
		int result = 0;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = null;
		try {
			sql = "select nvl(max(boardNum),0) from board";
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
	public int dataCount()
	{
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql;
		try {
			sql="SELECT NVL(COUNT(*),0) FROM board";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null){
				try{
					pstmt.close();
				}
				catch(Exception e2){System.out.println(e2.toString());}
			}
			if(rs!=null){
				try{
					rs.close();
				}
				catch(Exception e2){System.out.println(e2.toString());}
			}
			pstmt=null;
			rs=null;
		}
		return result;
	}
	public int dataCount(String searchKey,String searchValue)
	{
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql;
		try {
			sql="SELECT COUNT(*) FROM board b join member1 m on b.userid = m.userid where ";
			if(searchKey.equals("userName"))
				sql+= "instr(userName,?) = 1";
			else if(searchKey.equals("subject"))
				sql+= "subject like '%'||?||'%'";
			else if(searchKey.equals("content"))
				sql+= "instr(content,?) >= 1";
			else if(searchKey.equals("created"))
				sql+= "to_char(created,'YYYY-MM-DD') = ?";
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,searchValue);
			rs=pstmt.executeQuery();
			if(rs.next())
				result=rs.getInt(1);
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			if(pstmt!=null){
				try{
					pstmt.close();
				}
				catch(Exception e2){System.out.println(e2.toString());}
			}
			if(rs!=null){
				try{
					rs.close();
				}
				catch(Exception e2){System.out.println(e2.toString());}
			}
			pstmt=null;
			rs=null;
		}
		return result;
	}
	public List<BoardDTO> listBoard(int start, int end){
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("select * from(select ROWNUM rnum , tb.* from(");
			sb.append("select boardNum, userName, subject, content, to_char(created,'YYYY-MM-DD') created, hitCount, groupNum, depth, orderNo ");
			sb.append("from board b join member1 m1 on m1.userid = b.userid  order by groupNum DESC,orderNo ASC )");
			sb.append("tb where ROWNUM <=?) where rnum >= ?");

			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1,end);
			pstmt.setInt(2,start);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				BoardDTO dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			rs=null;
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	public List<BoardDTO> listBoard(int start, int end,String searchKey,String searchValue){
		List<BoardDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("select * from(select ROWNUM rnum , tb.* from(");
			sb.append("select boardNum, userName, subject, content, to_char(created,'YYYY-MM-DD') created, hitCount, groupNum, depth, orderNo ");
			sb.append("from board b join member1 m1 on m1.userid = b.userid where ");
			if(searchKey.equals("userName"))
				sb.append("instr(userName,?) = 1");
			else if(searchKey.equals("subject"))
				sb.append("subject like '%'||?||'%'");
			else if(searchKey.equals("content"))
				sb.append("instr(content,?) >= 1");
			else if(searchKey.equals("created"))
				sb.append("to_char(created,'YYYY-MM-DD') = ?");
			sb.append(" order by groupNum DESC ,orderNo ASC )");
			sb.append("tb where ROWNUM <=?) where rnum >= ?");

			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setString(1, searchValue);
			pstmt.setInt(2,end);
			pstmt.setInt(3,start);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				BoardDTO dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setCreated(rs.getString("created"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
				list.add(dto);
			}
			rs.close();
			pstmt.close();
			rs=null;
			pstmt=null;
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return list;
	}
	public BoardDTO readBoard(int boardNum){
		BoardDTO dto=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("SELECT boardNum,b.userId,userName,subject,content,hitCount,");
			sb.append(" to_char(created,'YYYY-MM-DD') created,groupNum, depth, orderNo,parent ");
			sb.append(" from board b join member1 m on m.userId=b.userId where boardNum=?");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, boardNum);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				dto = new BoardDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				dto.setGroupNum(rs.getInt("groupNum"));
				dto.setDepth(rs.getInt("depth"));
				dto.setOrderNo(rs.getInt("orderNo"));
				dto.setParent(rs.getInt("parent"));
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}
	public BoardDTO preReadBoard(int groupNum, int orderNo, String searchKey, String searchValue){
	     BoardDTO dto=null;
		 PreparedStatement pstmt=null;
	        ResultSet rs=null;
	        StringBuffer sb = new StringBuffer();

	        try {
	            if(searchValue!=null && searchValue.length() != 0) {
	                sb.append("SELECT ROWNUM, tb.* FROM (SELECT boardNum, subject FROM board b ");
	    			sb.append(" JOIN member1 m ON b.userId=m.userId");
	    			if(searchKey.equals("created"))
	    				sb.append("           WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ? ) AND ");
	    			else if(searchKey.equals("userName"))
	    				sb.append("           WHERE (INSTR(userName, ?) = 1 ) AND ");
	    			else
	    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1 ) AND ");
	    			
	                sb.append("     (( groupNum = ? AND orderNo < ?) ");
	                sb.append("         OR (groupNum > ? )) ");
	                sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

	                pstmt=conn.prepareStatement(sb.toString());
	                
	                pstmt.setString(1, searchValue);
	                pstmt.setInt(2, groupNum);
	                pstmt.setInt(3, orderNo);
	                pstmt.setInt(4, groupNum);
				} else {
	                sb.append("SELECT ROWNUM, tb.* FROM ( ");
	                sb.append("     SELECT boardNum, subject FROM board b JOIN member1 m ON b.userId=m.userId ");                
	                sb.append("  WHERE (groupNum = ? AND orderNo < ?) ");
	                sb.append("         OR (groupNum > ? ) ");
	                sb.append("         ORDER BY groupNum ASC, orderNo DESC) tb WHERE ROWNUM = 1 ");

	                pstmt=conn.prepareStatement(sb.toString());
	                pstmt.setInt(1, groupNum);
	                pstmt.setInt(2, orderNo);
	                pstmt.setInt(3, groupNum); 
				}

	            rs=pstmt.executeQuery();

	            if(rs.next()) {
	                dto=new BoardDTO();
	                dto.setBoardNum(rs.getInt("boardNum"));
	                dto.setSubject(rs.getString("subject"));
	            }
	            rs.close();
	            pstmt.close();
	        } catch (Exception e) {
	            System.out.println(e.toString());
	        }
	    
	        return dto;
	}
	public BoardDTO nextReadBoard(int groupNum, int orderNo, String searchKey, String searchValue)
	{
		 BoardDTO dto=null;
		 PreparedStatement pstmt=null;
	        ResultSet rs=null;
	        StringBuffer sb = new StringBuffer();

	        try {
	            if(searchValue!=null && searchValue.length()!= 0) {
	                sb.append("SELECT ROWNUM, tb.* FROM ( ");
	                sb.append("  SELECT boardNum, subject ");
	    			sb.append("               FROM board b");
	    			sb.append("               JOIN member1 m ON b.userId=m.userId");
	    			if(searchKey.equals("created"))
	    				sb.append("           WHERE (TO_CHAR(created, 'YYYY-MM-DD') = ? ) AND ");
	    			else if(searchKey.equals("userName"))
	    				sb.append("           WHERE (INSTR(userName, ?) = 1) AND ");
	    			else
	    				sb.append("           WHERE (INSTR(" + searchKey + ", ?) >= 1) AND ");
	    			
	                sb.append("     (( groupNum = ? AND orderNo > ?) ");
	                sb.append("         OR (groupNum < ? )) ");
	                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

	                pstmt=conn.prepareStatement(sb.toString());
	                pstmt.setString(1, searchValue);
	                pstmt.setInt(2, groupNum);
	                pstmt.setInt(3, orderNo);
	                pstmt.setInt(4, groupNum);

				} 
	            else {
	                sb.append("SELECT ROWNUM, tb.* FROM ( ");
	                sb.append("     SELECT boardNum, subject FROM board b JOIN member1 m ON b.userId=m.userId ");
	                sb.append("  WHERE (groupNum = ? AND orderNo > ?) ");
	                sb.append("         OR (groupNum < ? ) ");
	                sb.append("         ORDER BY groupNum DESC, orderNo ASC) tb WHERE ROWNUM = 1 ");

	                pstmt=conn.prepareStatement(sb.toString());
	                pstmt.setInt(1, groupNum);
	                pstmt.setInt(2, orderNo);
	                pstmt.setInt(3, groupNum);
	            }

	            rs=pstmt.executeQuery();

	            if(rs.next()) {
	                dto=new BoardDTO();
	                dto.setBoardNum(rs.getInt("boardNum"));
	                dto.setSubject(rs.getString("subject"));
	            }
	            rs.close();
	            pstmt.close();
	        } catch (Exception e) {
	            System.out.println(e.toString());
	        }

	        return dto;
	}
	 public int updateOrderNo(int groupNum,int orderNo)
	    {
	    	int result = 0;
	    	PreparedStatement pstmt=null;
	    	String sql;
	    	try {
				sql="UPDATE board set orderNo=orderNo+1 where groupNum = ? and orderNo > ?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, groupNum);
				pstmt.setInt(2, orderNo);
				result=pstmt.executeUpdate();
				pstmt.close();
			} catch (Exception e) {
				System.out.println(e.toString());
			}
	    	return result;
	    }
	 public int deleteBoard(int boardNum)
	    {
	    	int result = 0;
	    	PreparedStatement pstmt=null;
	    	String sql;
	    	try {
				sql="DELETE from board where boardNum IN ";
				sql+="(select boardNum from board start with boardNum=? connect by prior boardNum=parent)";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, boardNum);
				result=pstmt.executeUpdate();
				pstmt.close();
			} catch (Exception e) {
				System.out.println(e.toString());
			}
	    	return result;
	    }
	 public int updateBoard(BoardDTO dto)
	    {
	    	int result =  0;
			PreparedStatement pstmt = null;
			String sql;
			try {
				
				sql = "update board set subject=?,content=? where boardNum=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setInt(3, dto.getBoardNum());
				result = pstmt.executeUpdate();
				pstmt.close();
			} 
			catch (Exception e)
			{
				System.out.println(e.toString());
			}
			return result;
	    }
	 
}
