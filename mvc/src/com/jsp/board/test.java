package com.jsp.board;

import java.util.ArrayList;
import java.util.List;

public class test {

	public static void main(String[] args) {
		BoardDAOImpl dao = new BoardDAOImpl();
		String contents = "테스트 입니다.";
		String writer = "tester";
		String writer_name = "testman";
				
		for(int i = 47; i<51; i++) {
			String a = "test"+i;
			dao.insertPost(a, contents, writer, writer_name);
		}
		
		
	}

}
