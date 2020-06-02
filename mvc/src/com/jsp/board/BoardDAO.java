package com.jsp.board;

import java.util.ArrayList;
import java.util.List;

import com.jsp.conn.DBConnector;

public interface BoardDAO {

	void setDataSource(DBConnector dataSource);
	public void insertPost(String title, String contents, String writer, String writer_name);
	public void insertCmt(int b_no, String writer, String writer_name, String content);
	public boolean deletePost(int b_no, String writer);
	public void modifyPost(int b_no);
	public List<BoardDTO> getPost_all(int now_pg, int pgPerBlock);
	public List<commentDTO> getCmt(int b_no);
	public int getCount();
	public void updateLk(int b_no, String id);
	public void updateUnlk(int b_no, String id);
	public void updateVw(int b_no, String id);
	public int countLk(int b_no);
	public int countUnlk(int b_no);
	public int countVw(int b_no);
	public BoardDTO getPost_bno(int b_no);
	public List<BoardDTO> getPost_title(String title);
	public List<BoardDTO> getPost_writerName(String writer_name);
	
	
}
