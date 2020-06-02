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
 * Servlet implementation class updateLk
 */
@WebServlet("/updateUnlks")
public class updateUnlk extends HttpServlet {
	private static final long serialVersionUID = 1L;

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		updateUnlks(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		updateUnlks(request, response);
	}

	private void updateUnlks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		int b_no = Integer.parseInt(request.getParameter("b_no"));
		String id = request.getParameter("id");
		System.out.println(b_no);
		System.out.println(id);
		BoardDAOImpl dao = new BoardDAOImpl();
		PrintWriter out = response.getWriter();
		
		dao.updateUnlk(b_no, id);
		System.out.println("impl 갔다와서 다시 servlet옴");
		int result = dao.countUnlk(b_no);
		JSONObject obj = new JSONObject();
		obj.put("data", result);
		out.write(String.valueOf(obj.get("data")));
		out.flush();
		
    }

	
}
