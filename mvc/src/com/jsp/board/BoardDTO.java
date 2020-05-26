package com.jsp.board;

import java.util.Date;

public class BoardDTO {

	private int b_no;
	private String title;
	private String contents;
	private String writer;
	private String writer_name;
	private Date b_date;
	private int likes;
	private int unlikes;
	
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWriter_name() {
		return writer_name;
	}
	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
	}
	public Date getB_date() {
		return b_date;
	}
	public void setB_date(Date b_date) {
		this.b_date = b_date;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getUnlikes() {
		return unlikes;
	}
	public void setUnlikes(int unlikes) {
		this.unlikes = unlikes;
	}
	
	
	
}
