package mail;

import javax.mail.Authenticator;	//인증자
import javax.mail.PasswordAuthentication;	// 비밀번호 인증

public class MailAuth extends Authenticator{
	
	PasswordAuthentication pa;
	
	
	public MailAuth(){		// 생성자.
		
		String mail_id = "forprojectjsp@gmail.com";
		String mail_pass ="projectjsp";
		
		pa = new PasswordAuthentication(mail_id, mail_pass);
	}

	public PasswordAuthentication getPasswordAuthentication(){
		
		return pa;
	}


}

/*
private static class MailAuthenticator extends javax.mail.Authenticator {
@Override
    public PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(sender_email, password);
    }
}
*/

/*
Authenticator 를 사용하기 위해서는 PasswordAuthenticator클래스로부터 인스턴스를 생성하고, 
getPasswordAuthentication 메서도로 리턴받아야한다. 
PasswordAuthentication 클래스는 사용자의 아이디와 패스우더를 입력받아 반환하도록 재정의한다.
*/
