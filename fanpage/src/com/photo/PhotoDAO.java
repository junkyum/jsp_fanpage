package com.photo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.util.DBConn;

public class PhotoDAO {
	private Connection conn=DBConn.getConnection();
	public int insertPhoto(PhotoDTO dto){
		int result = 0;
		PreparedStatement pstmt=null;
		String sql;
		try {
			sql="insert into photo(userId,subject,content,imagefilename,num) values(?,?,?,?,photo_seq.Nextval)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getImageFilename());
			pstmt.executeUpdate();
			pstmt.close();
			pstmt=null;
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
			sql ="UPDATE photo set hitCount = hitCount+1 where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}
	public int dataCount(){
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		String sql;
		try {
			sql="SELECT NVL(COUNT(*),0) FROM photo";
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
	public List<PhotoDTO> listPhoto(int start,int end){
		List<PhotoDTO> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("select * from(select ROWNUM rnum , tb.* from(");
			sb.append("select num, userName, subject, content, to_char(p.created,'YYYY-MM-DD') created, imagefilename ");
			sb.append("from photo p join member m on m.userid = p.userid order by num DESC)");
			sb.append("tb where ROWNUM <=?) where rnum >= ?");

			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1,end);
			pstmt.setInt(2,start);
			rs=pstmt.executeQuery();
			while(rs.next())
			{
				PhotoDTO dto = new PhotoDTO();
				dto.setNum(rs.getInt("num"));
				dto.setUserName(rs.getString("userName"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setImageFilename(rs.getString("imagefilename"));
				dto.setCreated(rs.getString("created"));
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
	public PhotoDTO readPhoto(int Num){
		PhotoDTO dto=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		StringBuffer sb = new StringBuffer();
		try {
			sb.append("SELECT num, p.userId, userName, subject, content, imageFilename,");
			sb.append(" to_char(p.created,'YYYY-MM-DD') created ,hitCount ");
			sb.append(" from photo p join member m on m.userId=p.userId where num=?");
			pstmt=conn.prepareStatement(sb.toString());
			pstmt.setInt(1, Num);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				dto = new PhotoDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setImageFilename(rs.getString("imageFilename"));
				dto.setCreated(rs.getString("created"));
				dto.setUserName(rs.getString("userName"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setUserId(rs.getString("userId"));
			
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}
	public int deletePhoto(int num){
		int result = 0;
    	PreparedStatement pstmt=null;
    	String sql;
    	try {
			sql="DELETE from photo where num = ? ";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
    	return result;
	}
	 public int updatePhoto(PhotoDTO dto){
		 int result =  0;
			PreparedStatement pstmt = null;
			String sql;
			try {
				
				sql="update photo set subject=?,content=?,ImageFilename=? where Num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getImageFilename());
				pstmt.setInt(4, dto.getNum());
				result = pstmt.executeUpdate();
				pstmt.close();
			} 
			catch (Exception e)
			{
				System.out.println(e.toString());
			}
			return result;
		 
	 }
	 //////////////////
	 public int insertReply(ReplyPhotoDTO dto) {
			int result=0;
			PreparedStatement pstmt=null;
			StringBuffer sb=new StringBuffer();
			
			try {
				sb.append("INSERT INTO photoReply(replyNum, num, userId, content) ");
				sb.append(" VALUES (photoReply_seq.NEXTVAL, ?, ?, ?)");
				
				pstmt=conn.prepareStatement(sb.toString());
				pstmt.setInt(1, dto.getNum());
				pstmt.setString(2, dto.getUserId());
				pstmt.setString(3, dto.getContent());
				
				result=pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if(pstmt!=null)
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
			}
			
			return result;
		}
		
		public int dataCountReply(int num) {
			int result=0;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			String sql;
			
			try {
				sql="SELECT NVL(COUNT(*), 0) FROM photoReply WHERE num=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs=pstmt.executeQuery();
				if(rs.next())
					result=rs.getInt(1);
				
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if(rs!=null) {
					try {
						rs.close();
					} catch (SQLException e) {
					}
				}
					
				if(pstmt!=null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}
			}
			
			return result;
		}

		public List<ReplyPhotoDTO> listReply(int num, int start, int end) {
			List<ReplyPhotoDTO> list=new ArrayList<>();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			StringBuffer sb=new StringBuffer();
			
			try {
				sb.append("SELECT * FROM (");
				sb.append("    SELECT ROWNUM rnum, tb.* FROM (");
				sb.append("        SELECT replyNum, num, b.userId, userName, content");
				sb.append("            ,TO_CHAR(b.created, 'YYYY-MM-DD') created");
				sb.append("            FROM photoReply b JOIN member m ON b.userId=m.userId  ");
				sb.append("            WHERE num=?");
				sb.append("	       ORDER BY replyNum desc");
				sb.append("    ) tb WHERE ROWNUM <= ? ");
				sb.append(") WHERE rnum >= ? ");

				pstmt = conn.prepareStatement(sb.toString());
				pstmt.setInt(1, num);
				pstmt.setInt(2, end);
				pstmt.setInt(3, start);

				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					ReplyPhotoDTO dto=new ReplyPhotoDTO();
					
					dto.setReplyNum(rs.getInt("replyNum"));
					dto.setNum(rs.getInt("num"));
					dto.setUserId(rs.getString("userId"));
					dto.setUserName(rs.getString("userName"));
					dto.setContent(rs.getString("content"));
					dto.setCreated(rs.getString("created"));
					
					list.add(dto);
				}
				
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if(rs!=null) {
					try {
						rs.close();
					} catch (SQLException e) {
					}
				}
					
				if(pstmt!=null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}
			}
			return list;
		}

		public int deleteReply(int replyNum) {
			int result = 0;
			PreparedStatement pstmt = null;
			String sql;
			
			sql="DELETE FROM photoReply WHERE replyNum=?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, replyNum);
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println(e.toString());
			} finally {
				if(pstmt!=null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
					}
				}
			}		
			return result;
		}
}
