package com.quantom.audition.service;

import java.io.UnsupportedEncodingException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.quantom.audition.dto.ResultData;
import com.quantom.audition.util.Util;

@Service
public class MailService {
	@Autowired
	private JavaMailSender sender;
	@Value("${custom.emailFrom}")
	private String emailFrom;
	@Value("${custom.emailFromName}")
	private String emailFromName;

	private static class MailHandler {
		private JavaMailSender sender;
		private MimeMessage message;
		private MimeMessageHelper messageHelper;

		public MailHandler(JavaMailSender sender) throws MessagingException {
			this.sender = sender;
			this.message = this.sender.createMimeMessage();
			this.messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		}

		public void setFrom(String mail, String name) throws UnsupportedEncodingException, MessagingException {
			messageHelper.setFrom(mail, name);
		}

		public void setTo(String mail) throws MessagingException {
			messageHelper.setTo(mail);
		}

		public void setSubject(String subject) throws MessagingException {
			messageHelper.setSubject(subject);
		}

		public void setText(String text) throws MessagingException {
			messageHelper.setText(text, true);
		}

		public void send() {
			try {
				sender.send(message);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public ResultData send(String email, String title, String body) {

		MailHandler mail;
		try {
			mail = new MailHandler(sender);
			mail.setFrom(emailFrom.replaceAll(" ", ""), emailFromName);
			mail.setTo(email);
			mail.setSubject(title);
			mail.setText(body);
			mail.send();
		} catch (Exception e) {
			e.printStackTrace();
			return new ResultData("F-1", "메일이 실패하였습니다.");
		}

		return new ResultData("S-1", "메일이 발송되었습니다.");
	}
	
	public ResultData sendVerifyEmail(String email, String siteName, String verifyCode) {
		
		String title = "[" + siteName + "] 회원가입 인증코드";
		
		StringBuilder sb = new StringBuilder();

		//다양한 메일플랫폼에 대응하기위해서 최소한의 css와 html tag를 이용해서 메일폼을 만듬 (table,tr,td 사용)
		sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
		sb.append("<html xmlns=\"http://www.w3.org/1999/xhtml\"></html>");
		sb.append("<head>");
		sb.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />");
		sb.append("<title>HTML Email Template</title>");
		sb.append("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />");
		sb.append("</head>");
		sb.append("<body style=\"width: 100% !important; height: 100% !important; margin: 0; padding: 0;\">");
		sb.append("<table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"20px\" width=\"100%\">");
		sb.append("<tr><td align=\"center\" style=\"font-size: 0; line-height: 0; height: 0;\" height=\"0\"><img src=\"https://bangsuyeong.shop/resource/img/mobile_header.png\" width=\"176px\" height=\"16px\" alt=\"Brand name\" /></td></tr>");
		sb.append("<tr><td align=\"center\" style=\"font-size: 0; line-height: 0; height: 0;\" height=\"0\"><img src=\"https://bangsuyeong.shop/resource/img/logoForLogin.png\" alt=\"Logo image\" width=\"200px\" height=\"200px\" /></td></tr>");
		sb.append("<tr><td align=\"center\" style=\"color: green; font-family: Arial, sans-serif\"> 안녕하세요 AUDITION TREE 입니다. <br /> 요청하신 회원가입 인증번호입니다. </td></tr>");
		sb.append("<tr><td align=\"center\"><table align=\"center\" border=\"0\" cellpadding=\"30px\" cellspacing=\"20px\" width=\"500px\"><tr>");
		sb.append("<td align=\"center\" bgcolor=\"#66CC66\" style=\"border-radius: 10px; color: white; font-family: Arial, sans-serif; line-height: 40px\">");
		sb.append("<table><tr><td>인증번호 : </td><td style=\"font-weight: bold; font-size: 25px\">123456</td></tr></table>");
		sb.append("<table><tr><td>발급시간 : </td><td style=\"font-weight: bold; font-size: 25px\">2021년 10월 23일 15:50</td></tr></table></td>");
		sb.append("</tr></table></td></tr>");
		sb.append("</table>");
		sb.append("</body>");
		sb.append("</html>");
		
		ResultData sendCode = send(email, title, sb.toString());
		
		if ( sendCode.isSuccess() ) {
			return new ResultData("S-1", "이메일이 발송되었습니다.");
		} else {
			return new ResultData("F-1", "이메일 발송에 실패하였습니다.");
		}
		
	}
}