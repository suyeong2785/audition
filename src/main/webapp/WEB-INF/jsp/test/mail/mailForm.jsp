
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"></html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>HTML Email Template</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body
	style="width: 100% !important; height: 100% !important; margin: 0; padding: 0;">
	<table align="center" border="0" cellpadding="0" cellspacing="20px"
		width="100%">
		<tr>
			<td align="center">
				<img src="https://localhost:8080/resource/img/mobile_header.svg"
					width="176px" height="16px" alt="Brand name" />
			</td>
		</tr>
		<tr>
			<td align="center">
				<img src="https://localhost:8080/resource/img/logoForLogin.svg"
					alt="Logo image" width="200px" height="200px" />
			</td>
		</tr>
		<tr>
			<td align="center"
				style="color: green; font-family: Arial, sans-serif">
				안녕하세요 AUDITION TREE 입니다. <br /> 요청하신 회원가입 인증번호입니다.
			</td>
		</tr>
		<tr>
			<td align="center">
				<table align="center" border="0" cellpadding="30px"
					cellspacing="20px" width="500px">
					<tr>
						<td align="center" bgcolor="#66CC66"
							style="border-radius: 10px; color: white; font-family: Arial, sans-serif; line-height: 40px">
							<table>
								<tr>
									<td>인증번호 : </td>
									<td style="font-weight: bold; font-size: 25px">123456</td>
								</tr>
							</table>
							<table>
								<tr>
									<td>발급시간 : </td>
									<td style="font-weight: bold; font-size: 25px">2021년 10월 23일 15:50</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>