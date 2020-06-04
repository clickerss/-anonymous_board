package com.jsp.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.jsp.users.UserDAOImpl;
import com.jsp.users.UsersDTO;

/**
 * Servlet implementation class userCheck
 */
@WebServlet("/userCheck")
public class userCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		usercheck(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		usercheck(request, response);
	}
	
	private void usercheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		System.out.println("usercheck 왔음");
		System.out.println(id);
		System.out.println(pwd);
		UserDAOImpl dao = new UserDAOImpl();
		
		
		boolean is_user = dao.userchk(id, pwd);
		System.out.println(is_user);
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		
		if(is_user) {
			HttpSession session = request.getSession();
			UsersDTO dto = dao.getUser(id);
			
			session.setAttribute("id", id);
			session.setAttribute("name", dto.getName());
			session.setAttribute("sex", dto.getSex());
			session.setAttribute("email", dto.getEmail());
			session.setAttribute("date", dto.getDate());
			
			obj.put("data", "login_main.jsp");		
			out.write((String)obj.get("data"));
			out.flush();
		}else{			
			obj.put("data", "로그인실패");		
			out.write((String)obj.get("data"));
			out.flush();
		}
		
		
	}
}




















