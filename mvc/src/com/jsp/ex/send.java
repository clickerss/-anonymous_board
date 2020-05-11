package com.jsp.ex;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class send
 */
@WebServlet("/send")
public class send extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Properties props = System.getProperties();
		props.put("mail.smtp.user", "ehowl0402@gmail.com");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");
		
		Authenticator auth = new MyAuthentication();
		
		// session 생성 및 MimeMessage생성
		Session session = Session.getDefaultInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try {
			// 보내는 시간
			msg.setSentDate(new Date());
			
			InternetAddress from = new InternetAddress("ehowl0402@gmail.com");
			
			// 이메일 발신자
			msg.setFrom(from);
			
			// 이메일 수신자
			String email = req.getParameter("receiver"); //사용자가 입력한 이메일 받아오기
			InternetAddress to = new InternetAddress(email);
			System.out.println(to);
			msg.setRecipient(Message.RecipientType.TO, to);
			
			// 이메일 제목
			msg.setSubject("비밀번호 인증번호", "UTF-8");
			
			// 이메일 내용
			String code = req.getParameter("code_check"); // 인증번호 값 받기
			req.setAttribute("code", code);
			msg.setText(code, "UTF-8");
			
			// 이메일 헤더
			msg.setHeader("content-Type", "text/html");
			
			//메일보내기
			javax.mail.Transport.send(msg);
			System.out.println("보냄!");
			
			
		} catch (AddressException addr_e) {
			addr_e.printStackTrace();
		} catch(MessagingException msg_e) {
			msg_e.printStackTrace();
		}
		
		RequestDispatcher rd = req.getRequestDispatcher("/checkcode.jsp");
		rd.forward(req, resp);
		
	}
}

class MyAuthentication extends Authenticator{
	
	PasswordAuthentication pa;
	
	public MyAuthentication() {
		
		String id = "ehowl0402@gmail.com"; // 구글 ID
		String pw = "chungmin04021!";
		
		// ID와 비밀번호를 입력한다.
		pa = new PasswordAuthentication(id, pw);
	}
	
	// 시스템에서 사용하는 인증정보
	public PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}






































