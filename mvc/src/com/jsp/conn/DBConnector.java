package com.jsp.conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public class DBConnector {

	public static Connection getConnection() {
		Connection conn = null;
		
        try{
            // 1. �뱶�씪�씠踰� 濡쒕뵫
            Class.forName("com.mysql.jdbc.Driver");

            // 2. �뿰寃고븯湲�
            String url = "jdbc:mysql://localhost:3306/testdb?serverTimezone=Asia/Seoul&useSSL=false";
            conn = DriverManager.getConnection(url, "root", "12345");
            System.out.println("db연결 성공");
            return conn;
        }
        catch(ClassNotFoundException e){
            System.out.println("db연결 실패");
            return null;
        }
        catch(SQLException e){
            System.out.println("에러: " + e);
            return null;
        }
        
	}
	public void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void close(Connection conn, PreparedStatement pstmt) {
		try {
			pstmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
