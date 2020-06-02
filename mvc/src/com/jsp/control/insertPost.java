package com.jsp.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsp.board.BoardDAOImpl;

/**
 * Servlet implementation class insertPost
 */
@WebServlet("/insertPost")
public class insertPost extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    private void insertPosts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String writer_name = request.getParameter("writer_name");
		String contents = request.getParameter("contents");
		
		BoardDAOImpl dao = new BoardDAOImpl();
		dao.insertPost(title, contents, writer, writer_name);
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		insertPosts(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		insertPosts(request, response);
	}

}
