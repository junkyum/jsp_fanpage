package com.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.util.DBConn;

public class MemberDAO {
	private Connection conn= DBConn.getConnection();

	
	public int putMember(MemberDTO dto) {
		int result =0;
		PreparedStatement pstmt=null;
		StringBuffer sb= new StringBuffer();
		
		try {
			sb.append("INSERT INTO member (userId, userName, userPw, userPhone ");
			sb.append("	,userEmail, userBirth, userHobby, myPhoto) ");
			sb.append(" VALUES(?,?,?,?,?,?,?,?)");
			pstmt=conn.prepareStatement(sb.toString());
			
			pstmt.setString(1,dto.getUserId());
			pstmt.setString(2,dto.getUserName());
			pstmt.setString(3,dto.getUserPw());
			pstmt.setString(4,dto.getUserPhone());
			pstmt.setString(5,dto.getUserEmail());
			pstmt.setString(6,dto.getUserBirth());
			pstmt.setString(7,dto.getUserHobby());
			pstmt.setString(8,dto.getMyPhoto());
			
			result=pstmt.executeUpdate();
			pstmt.close();
	
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		
		return result;
	}
	
	public MemberDTO readMember(String userId) {
		MemberDTO dto =null;
		PreparedStatement pstmt= null;
		ResultSet rs=null;
		StringBuffer sb= new StringBuffer();
		
		try {
			
			sb.append("SELECT userId, userName, userPw, userPhone, ");
			sb.append("		userEmail, TO_CHAR(userBirth, 'YYYY-MM-DD') userBirth ");
			sb.append("			,userHobby,myPhoto FROM member WHERE userId=?");
			
			pstmt= conn.prepareStatement(sb.toString());
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				dto= new MemberDTO();
				
				dto.setUserId(rs.getString("userId"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserPw(rs.getString("userPw"));			
				dto.setUserPhone(rs.getString("userPhone"));		
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setUserBirth(rs.getString("userBirth"));
				dto.setUserHobby(rs.getString("userHobby"));
				dto.setMyPhoto(rs.getString("myPhoto"));
			}
			rs.close();
			pstmt.close();
			pstmt=null;	
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}
	
	
	public int updateUser(MemberDTO dto) {
		int result =0;
		PreparedStatement pstmt= null;
		StringBuffer sb = new StringBuffer();
		
		try {
			
				sb.append("UPDATE member SET userName=? , userPw=? , userPhone=? , userEmail=? ");
				sb.append("		, userHobby=? WHERE userId=?");
			
				pstmt=conn.prepareStatement(sb.toString());
				
				pstmt.setString(1, dto.getUserName());
				pstmt.setString(2, dto.getUserPw());
				pstmt.setString(3, dto.getUserPhone());
				pstmt.setString(4, dto.getUserEmail());
				pstmt.setString(5, dto.getUserHobby());
				pstmt.setString(6, dto.getUserId());
				
				result= pstmt.executeUpdate();
				pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	//삭제하는 퀘리 메소드.
	public int delete(String userId) {
		
		PreparedStatement pstmt= null;
		//ResultSet rs=null;
		
		String str ="";
		int result=0;
		try {
			str="DELETE FROM member where userId=?";
	
			pstmt=conn.prepareStatement(str);
			pstmt.setString(1, userId);
			result=pstmt.executeUpdate();
			pstmt.close();
			result=1;
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}
	
	
	
	
	

	
	

}