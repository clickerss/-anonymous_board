package com.jsp.users;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONObject;

import com.jsp.conn.DBConnector;

public class UserDAOImpl implements UsersDAO{
	
	DBConnector dataSource;
	DBConnector connector = new DBConnector();
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
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}	

	@Override
	public boolean userchk(String id, String pwd) {
		boolean is_user = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("userchk 까지 왔음");

		try {
			conn = connector.getConnection();
			System.out.println("연결됨");
			String sql = "select id, name, SEX, date, email from users where id = ? and PWD = SHA2(?, 224);";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			System.out.println("excute 까지 성공");
			if(rs.next()) {
				System.out.println("유저 맞음");
				is_user = true;
			}else {
				System.out.println("유저 아님");
				is_user = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return is_user;
	}

	@Override
	public UsersDTO getUser(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("getUser 까지 왔음");
		UsersDTO dto = new UsersDTO(id);
		SimpleDateFormat transFomat = new SimpleDateFormat("yyyy-MM-dd");

		try {
			conn = dataSource.getConnection();
			System.out.println("연결됨");
			String sql = "select id, name, SEX, date, email from users where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			System.out.println("excute 까지 성공");
			
			if(rs.next()) {
				String name = rs.getString("name");
				String sex = rs.getString("sex");
				String email = rs.getString("email");
				Date date = transFomat.parse(rs.getString("date"));
				
				dto.setId(id);
				dto.setName(name);
				dto.setSex(sex);
				dto.setEmail(email);
				dto.setDate(date);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}		
		return dto;
	}

	@Override
	public boolean isduplicated(String id) {
		boolean isdup = true;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("isdupl 까지 왔음");
		
		try {
			conn = dataSource.getConnection();
			String sql = "select * from users where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			System.out.println("excute 까지 성공");
			System.out.println(id);
			if(rs.next()) {
				System.out.println("중복임");
				isdup = true;
			}else {
				System.out.println("중복아님");
				isdup = false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return isdup;
	}

	@Override
	public int countLk(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		System.out.println("getCount 왓음");	
		try {
			conn = dataSource.getConnection();
			String sql = "select count(*) from liketable where id= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				count = rs.getInt(1);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}		
		return count;
	}

	@Override
	public int countUnlk(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		System.out.println("getCount 왓음");	
		try {
			conn = dataSource.getConnection();
			String sql = "select count(*) from unliketable where id= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				count = rs.getInt(1);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}		
		return count;
	}

	@Override
	public int countCmt(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		System.out.println("getCount 왓음");	
		try {
			conn = dataSource.getConnection();
			String sql = "select sum(cmt) from board_all ba where writer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();			
			if(rs.next()) {
				count = rs.getInt(1);	
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}		
		return count;
	}

	@Override
	public void modifyUser(String id, String name, String pwd, String email, String sex) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("insertUser 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "update users \r\n" + 
					"set name = ?, email = ?, sex = ?, PWD  = SHA2(?, 224) \r\n" + 
					"where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, sex);
			pstmt.setString(4, pwd);
			pstmt.setString(5, id);
			int rs = pstmt.executeUpdate();
			System.out.println("excuteUpdate 까지 왔음");
			if(rs > 0) {
				System.out.println("정보수정 성공");
			} else {
				System.out.println("정보수정 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	

}



























