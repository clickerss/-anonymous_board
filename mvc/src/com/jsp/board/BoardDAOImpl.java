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
	public boolean deletePost(int b_no, String writer) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		boolean result = false;
		System.out.println("deletePost 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "delete from board where b_no = ? and writer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			pstmt.setString(2, writer);
			int rs = pstmt.executeUpdate();
			System.out.println("excuteUpdate 까지 왔음");
			if(rs > 0) {
				System.out.println("글삭제 성공");
				result = true;
			} else {
				System.out.println("글삭제  실패");
				result = false;
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
		return result;
	}

	@Override
	public void modifyPost(int b_no, String title, String contents) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("insertPost 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "update board \r\n" + 
					"set title = ?, contents = ?\r\n" + 
					"where b_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, contents);
			pstmt.setInt(3, b_no);
			int rs = pstmt.executeUpdate();
			System.out.println("excuteUpdate 까지 왔음");
			if(rs > 0) {
				System.out.println("글수정 성공");
			} else {
				System.out.println("글수정  실패");
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
	public List<BoardDTO> getPost_all(int now_pg, int postPerPg) {
		Connection conn = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int posts = now_pg*postPerPg;
		List<BoardDTO> list = new ArrayList<>();
		System.out.println("getPast_all 왓음");
		SimpleDateFormat transFomat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		try {
			conn = dataSource.getConnection();
			//String sql = "select b_no, title, contents, writer_name, b_date, likes, unlikes from board order by b_no desc";
			String sql = "select * from board_all limit ?,?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, posts);
			pstmt.setInt(2, postPerPg);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				int b_no = rs.getInt("b_no");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				System.out.println(contents);
				String writer_name = rs.getString("writer_name");
				Date b_date = transFomat.parse(rs.getString("b_date"));
				int likes = rs.getInt("cnt_lk");
				int unlikes = rs.getInt("cnt_unlk");
				int cmt = rs.getInt("cmt");
				
				dto.setB_no(b_no);
				dto.setTitle(title);
				dto.setContents(contents);
				dto.setWriter_name(writer_name);
				dto.setB_date(b_date);
				dto.setLikes(likes);
				dto.setUnlikes(unlikes);
				dto.setCmt(cmt);
				
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
	public BoardDTO getPost_bno(int b_no) {
		Connection conn = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDTO dto = new BoardDTO();
		System.out.println("getPast_all 왓음");
		SimpleDateFormat transFomat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		try {
			conn = dataSource.getConnection();
			//String sql = "select b_no, title, contents, writer_name, b_date, likes, unlikes from board order by b_no desc";
			String sql = "select * from board_all where b_no = ?";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setInt(1, b_no);
			rs = pstmt.executeQuery();			
			if(rs.next()) {				
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				String writer_name = rs.getString("writer_name");
				Date b_date = transFomat.parse(rs.getString("b_date"));
				int vw = rs.getInt("vw");
				int cmt = rs.getInt("cmt");
				int cnt_lk = rs.getInt("cnt_lk");
				int cnt_unlk = rs.getInt("cnt_unlk");
				
				dto.setB_no(b_no);
				dto.setTitle(title);
				dto.setContents(contents);
				dto.setWriter_name(writer_name);
				dto.setB_date(b_date);
				dto.setCmt(cmt);
				dto.setLikes(cnt_lk);
				dto.setUnlikes(cnt_unlk);				
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
		return dto;
	}

	@Override
	public List<BoardDTO> getPost_title(String title) {
		return null;

		
	}

	@Override
	public List<BoardDTO> getPost_writerName(String writer_name) {
		return null;

		
	}

	@Override
	public void updateLk(int b_no, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("updateLk 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "select * from liketable where b_no = ? and id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				System.out.println("이미 좋아요를 눌렀으므로 좋아요 취소 실행");
				String sql2 = "delete from liketable where b_no = ? and id= ?";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, b_no);
				pstmt.setString(2, id);
				int result = pstmt.executeUpdate();
				if(result==1) {System.out.println("좋아요 취소 완료");}else {System.out.println("실패");}
			} else {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				System.out.println("좋아요 추가 실행중");
				String sql2 = "insert into liketable values(?,?)";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, b_no);
				pstmt.setString(2, id);
				int result = pstmt.executeUpdate();
				if(result==1) {System.out.println("좋아요 등록 완료");}else {System.out.println("실패");}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				if(rs != null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

	@Override
	public void updateUnlk(int b_no, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("updateUnlk 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "select * from unliketable where b_no = ? and id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				System.out.println("이미 좋아요를 눌렀으므로 좋아요 취소 실행");
				String sql2 = "delete from unliketable where b_no = ? and id= ?";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, b_no);
				pstmt.setString(2, id);
				int result = pstmt.executeUpdate();
				if(result==1) {System.out.println("좋아요 취소 완료");}else {System.out.println("실패");}
			} else {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				System.out.println("좋아요 추가 실행중");
				String sql2 = "insert into unliketable values(?,?)";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, b_no);
				pstmt.setString(2, id);
				int result = pstmt.executeUpdate();
				if(result==1) {System.out.println("좋아요 등록 완료");}else {System.out.println("실패");}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				if(rs != null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

	@Override
	public int countLk(int b_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		System.out.println("getCount 왓음");	
		try {
			conn = dataSource.getConnection();
			String sql = "select count(*) from liketable where b_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
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
	public int countUnlk(int b_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		System.out.println("getCount 왓음");	
		try {
			conn = dataSource.getConnection();
			String sql = "select count(*) from unliketable where b_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
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
	public void updateVw(int b_no, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("updateVw 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "select * from views where b_no = ? and id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				System.out.println("이미 해당 id로 조회수가 증가됨");
			} else {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
				System.out.println("조회수 추가 쿼리 실행중");
				String sql2 = "insert into views values(?,?)";
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, b_no);
				pstmt.setString(2, id);
				int result = pstmt.executeUpdate();
				if(result==1) {System.out.println("조회수 증가 완료");}else {System.out.println("실패");}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				if(rs != null) rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
	}

	@Override
	public int countVw(int b_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count=0;
		System.out.println("getCount 왓음");	
		try {
			conn = dataSource.getConnection();
			String sql = "select count(*) from views where b_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
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
	public void insertCmt(int b_no, String writer, String writer_name, String content) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		System.out.println("insertPost 까지 왔음");
		
		try {
			System.out.println("try 구문까지 왔음");
			conn = dataSource.getConnection();
			System.out.println("연결이 된건가"+conn);
			String sql = "insert into comment (b_no, writer, writer_name, content) values(\r\n" + 
					"	?,?,?,?\r\n" + 
					");";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			pstmt.setString(2, writer);
			pstmt.setString(3, writer_name);
			pstmt.setString(4, content);
			int rs = pstmt.executeUpdate();
			System.out.println("excuteUpdate 까지 왔음");
			if(rs > 0) {
				System.out.println("댓글작성 성공");
			} else {
				System.out.println("댓글작성  실패");
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
	public List<commentDTO> getCmt(int b_no) {
		Connection conn = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<commentDTO> list = new ArrayList<>();
		System.out.println("getCmt 왓음");
		SimpleDateFormat transFomat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		try {
			conn = dataSource.getConnection();
			//String sql = "select b_no, title, contents, writer_name, b_date, likes, unlikes from board order by b_no desc";
			String sql = "select * from comment where b_no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, b_no);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				commentDTO dto = new commentDTO();
				String writer_name = rs.getString("writer_name");
				String content = rs.getString("content");
				Date c_date = transFomat.parse(rs.getString("c_date"));
				int c_no = rs.getInt("c_no");
				
				dto.setContent(content);
				dto.setWriter_name(writer_name);
				dto.setC_date(c_date);
				dto.setC_no(c_no);
				
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
	public List<BoardDTO> getPost_writer(String writer) {
		Connection conn = null;		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardDTO> list = new ArrayList<>();
		System.out.println("getPast_writer 왓음");
		SimpleDateFormat transFomat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
		try {
			conn = dataSource.getConnection();
			//String sql = "select b_no, title, contents, writer_name, b_date, likes, unlikes from board order by b_no desc";
			String sql = "select * from board_all where writer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();			
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				int b_no = rs.getInt("b_no");
				String title = rs.getString("title");
				String contents = rs.getString("contents");
				System.out.println(contents);
				String writer_name = rs.getString("writer_name");
				Date b_date = transFomat.parse(rs.getString("b_date"));
				int likes = rs.getInt("cnt_lk");
				int unlikes = rs.getInt("cnt_unlk");
				int cmt = rs.getInt("cmt");
				
				dto.setB_no(b_no);
				dto.setTitle(title);
				dto.setContents(contents);
				dto.setWriter_name(writer_name);
				dto.setB_date(b_date);
				dto.setLikes(likes);
				dto.setUnlikes(unlikes);
				dto.setCmt(cmt);
				
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

}















