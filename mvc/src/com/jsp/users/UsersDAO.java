package com.jsp.users;

import com.jsp.conn.DBConnector;

public interface UsersDAO {

	public void setDataSource(DBConnector dataSource);
	public void insertUser(String id, String name, String pwd, String email, String sex);
	public boolean userchk(String id, String pwd);
	public boolean isduplicated(String id);
	public UsersDTO getUser(String id);
	public void modifyUser(String id, String name, String pwd, String email, String sex);
	public int countLk(String id);
	public int countUnlk(String id);
	public int countCmt(String id);
}
