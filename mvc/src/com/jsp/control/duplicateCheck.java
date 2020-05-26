//https://bumcrush.tistory.com/124

package com.jsp.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.jsp.users.UserDAOImpl;


/**
 * Servlet implementation class testdup
 */
@WebServlet("/duplicateCheck")
public class duplicateCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		testdupl(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		testdupl(request, response);
	}

	private void testdupl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		System.out.println(id);
		UserDAOImpl dao = new UserDAOImpl();
		String result = null;
		boolean isdu = dao.isduplicated(id);
		PrintWriter out = response.getWriter();
		
		if(isdu) {
			result = "<font color=\"red\">이미 등록된 ID 입니다.</font>";
		}else{
			result = "<font color=\"blue\">사용할 수 있는 ID 입니다.</font>";
		}
		System.out.println(result);
		JSONObject obj = new JSONObject();
		obj.put("data", result);		
		out.write((String)obj.get("data"));
		out.flush();
		
	}
}
