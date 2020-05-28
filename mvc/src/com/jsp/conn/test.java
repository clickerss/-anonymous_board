package com.jsp.conn;

import com.jsp.users.UserDAOImpl;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		DBConnector connector = new DBConnector();
		UserDAOImpl dao = new UserDAOImpl();
		
		
		
		dao.isduplicated("test");
	}

}
