package com.jsp.board;

import java.util.List;

public class test {

	public static void main(String[] args) {
		BoardDAOImpl dao = new BoardDAOImpl();
		String contents = "테스트 입니다.";
		String writer = "tester";
		String writer_name = "testman";
		
		int b_no = 50;
		String id = "test";
		
		dao.updateLk(b_no, id);
		
		
		
		
		
		
		
	}

}
