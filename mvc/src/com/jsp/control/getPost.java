package com.jsp.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import com.jsp.board.BoardDAOImpl;
import com.jsp.board.BoardDTO;

/**
 * Servlet implementation class getPost
 */
@WebServlet("/getPost")
public class getPost extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public getPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		BoardDAOImpl dao = new BoardDAOImpl();

		int totalPost = dao.getCount();
		int postPerPg = Integer.parseInt(request.getParameter("postPerPg"));;
		int totalPg;		
		int pgPerBlock = 4;
		int now_pg = Integer.parseInt(request.getParameter("now_pg")); 
		int now_block = Integer.parseInt(request.getParameter("now_block"));;
		
		List<BoardDTO> a = dao.getPost_all(now_pg, pgPerBlock);
		PrintWriter out = response.getWriter();
		JSONObject obj = new JSONObject();
		
		List<Integer> pages = new ArrayList<>();
		ArrayList<List<Integer>> blocks = new ArrayList<List<Integer>>();

		// 전체 글 수에서 페이지당 글수를 나눠서 0으로 딱 떨어지면 나눈값이 totalPg
		// 만약 나눴을때 값이 남을 경우 나눈값+1 이 totalPg
		if(totalPost%postPerPg > 0){
			totalPg = totalPost/postPerPg +1;
		}else{
			totalPg = totalPost/postPerPg;
		}

		// 블록당 페이지수보다 전체 페이지수가 적을경우
		// 블록당 페이지수를 전체페이지수로 대입
		if(totalPg<pgPerBlock){
			pgPerBlock = totalPg;
		}

		for(int i=0; i<totalPg; i++){
			pages.add(i);
		}

		int count = 1;
		while(true){			
			if(pgPerBlock*count > totalPg){
				blocks.add(pages.subList(pgPerBlock*count-pgPerBlock, totalPg));
				break;
				
			}else if(pgPerBlock*count < totalPg){
				blocks.add(pages.subList(pgPerBlock*count-pgPerBlock, pgPerBlock*count));
				
			}else if(pgPerBlock*count == totalPg){
				blocks.add(pages.subList(pgPerBlock*count-pgPerBlock, totalPg));
				break;
			}	
			count++;
		}

    }

}
