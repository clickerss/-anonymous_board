package com.jsp.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsp.board.BoardDAOImpl;

/**
 * Servlet implementation class insertCmt
 */
@WebServlet("/insertCmt")
public class insertCmt extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    private void insertCmts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		int b_no = Integer.parseInt(request.getParameter("b_no2"));
		String writer = request.getParameter("writer");
		String writer_name = request.getParameter("writer_name");
		String content = request.getParameter("cmt");
		
		BoardDAOImpl dao = new BoardDAOImpl();
		dao.insertCmt(b_no, writer, writer_name, content);
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		insertCmts(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		insertCmts(request, response);
	}

}
