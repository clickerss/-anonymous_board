package com.jsp.board;

public interface BoardDAO {

	public void insertPost(String title, String contents, String writer, String writer_name);
	public void deletePost(int b_no);
	public void modifyPost(int b_no);
	public void getPost_all();
	public void getPost_bno(int b_no);
	public void getPost_title(String title);
	public void getPost_writerName(String writer_name);
	
}
