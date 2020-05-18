package com.jsp.users;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.jsp.conn.DBConnector;

public class UserDAOImpl implements UsersDAO{
	
	DBConnector dataSource;
	@Override
	public void setDataSource(DBConnector dataSource) {
		this.dataSource = dataSource;
	}
	
	@Override
	public void insertUser(String id, String name, String pwd, String email, String sex) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("insertUser 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "insert into USERS(ID,NAME,PWD,EMAIL,SEX) VALUES(" +
					"?, ?,SHA2(?, 224),?,?" + 
					");";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, pwd);
			pstmt.setString(4, email);
			pstmt.setString(5, sex);
			int rs = pstmt.executeUpdate();
			System.out.println("excuteUpdate 까지 왔음");
			if(rs > 0) {
				System.out.println("회원가입성공");
			} else {
				System.out.println("회원가입 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	

	@Override
	public boolean userchk(String id, String pwd) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public UsersDTO getUser(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	

}
