package com.jsp.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.jsp.board.BoardDAOImpl;

/**
 * Servlet implementation class deletePost
 */
@WebServlet("/deletePost")
public class deletePost extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @return 
     * @see HttpServlet#HttpServlet()
     */
    private void deletePosts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		int b_no = Integer.parseInt(request.getParameter("b_no"));
		String writer = request.getParameter("id");
		PrintWriter out = response.getWriter();
		BoardDAOImpl dao = new BoardDAOImpl();
		boolean result = dao.deletePost(b_no, writer);
		
		JSONObject obj = new JSONObject();
		obj.put("data", String.valueOf(result));
		out.write((String)obj.get("data"));
		out.flush();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		deletePosts(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		deletePosts(request, response);
	}

}
