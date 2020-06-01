package com.jsp.board;

import java.util.ArrayList;
import java.util.List;

import com.jsp.conn.DBConnector;

public interface BoardDAO {

	void setDataSource(DBConnector dataSource);
	public void insertPost(String title, String contents, String writer, String writer_name);
	public void deletePost(int b_no);
	public void modifyPost(int b_no);
	public List<BoardDTO> getPost_all(int now_pg, int pgPerBlock);
	public int getCount();
	public BoardDTO getPost_bno(int b_no);
	public List<BoardDTO> getPost_title(String title);
	public List<BoardDTO> getPost_writerName(String writer_name);	
	
}
