package com.jsp.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jsp.conn.DBConnector;

public class BoardDAOImpl implements BoardDAO{
	
	DBConnector dataSource;
	@Override
	public void setDataSource(DBConnector dataSource) {
		this.dataSource = dataSource;
	}
	
	@Override
	public void insertPost(String title, String contents, String writer, String writer_name) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("insertPost 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "insert into board(title,contents,writer,writer_name) VALUES(" +
					"?, ?, ?, ?" + 
					");";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, contents);
			pstmt.setString(3, writer);
			pstmt.setString(4, writer_name);
			int rs = pstmt.executeUpdate();
			System.out.println("excuteUpdate 까지 왔음");
			if(rs > 0) {
				System.out.println("글작성 성공");
			} else {
				System.out.println("글작성  실패");
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
	public void deletePost(int b_no) {
		

	}

	@Override
	public void modifyPost(int b_no) {

		
	}

	@Override
	public int getCount() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		System.out.println("getCount 왓음");	
		try {
			conn = dataSource.getConnection();
			String sql = "select count(*) from board";
			pstmt = conn.prepareStatement(sql);
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
	public List<BoardDTO> getPost_all() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;		
		List<BoardDTO> list = new ArrayList<>();
		System.out.println("getPast_all 왓음");
		SimpleDateFormat transFomat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		try {
			conn = dataSource.getConnection();
			String sql = "select b_no, title, contents, writer_name, b_date, likes, unlikes from board order by b_no desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				int b_no = rs.getInt("b_no");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				System.out.println(contents);
				String writer_name = rs.getString("writer_name");
				Date b_date = transFomat.parse(rs.getString("b_date"));
				int likes = rs.getInt("likes");
				int unlikes = rs.getInt("unlikes");
				
				dto.setB_no(b_no);
				dto.setTitle(title);
				dto.setContents(contents);
				dto.setWriter_name(writer_name);
				dto.setB_date(b_date);
				dto.setLikes(likes);
				dto.setUnlikes(unlikes);
				
				list.add(dto);				
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
		return list;
	}

	@Override
	public List<BoardDTO> getPost_bno(int b_no) {
		return null;

		
	}

	@Override
	public List<BoardDTO> getPost_title(String title) {
		return null;

		
	}

	@Override
	public List<BoardDTO> getPost_writerName(String writer_name) {
		return null;

		
	}

}















