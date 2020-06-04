package com.jsp.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsp.board.BoardDAOImpl;

/**
 * Servlet implementation class modifyPost
 */
@WebServlet("/modifyPost")
public class modifyPost extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    private void modifypost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		int b_no = Integer.parseInt(request.getParameter("b_no"));
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		BoardDAOImpl dao = new BoardDAOImpl();
		dao.modifyPost(b_no, title, contents);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		modifypost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		modifypost(request, response);
	}

}
