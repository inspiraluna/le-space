package le.space.java;

import java.util.*;
import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.util.ByteArrayDataSource;


public class sendfile {

    String from, to, subject, msgText;
    Session session;

    public sendfile(String host, String port, String username, String password, boolean ssl, String from, String to, String subject, String msgText) {

        this.from = from;
        this.to = to;
        this.subject = subject;
        this.msgText = msgText;

        System.out.println("username: "+username);
        System.out.println("host: "+host);
        System.out.println("port: "+port);

        Properties props = System.getProperties();

        Authenticator auth = null;
        if (username != null) {
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.user", username);
            auth = new SMTPAuthenticator(username, password);
        }

        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        if (ssl) {
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.debug", "true");
            props.put("mail.smtp.socketFactory.port", port);
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");
        }
        session = Session.getInstance(props, auth);
    }
    List attachments = new ArrayList();

    public void addFile(byte[] fileContent, String filename) {

       System.out.println("adding new byte array as ByteArrayDataSource as attachment "+filename+". size:"+fileContent.length);

        //FileDataSource fds = new FileDataSource("/Users/nico/Documents/miet.pdf");
       ByteArrayDataSource bays = new ByteArrayDataSource(fileContent,"application/pdf");
       bays.setName(filename);
      
        //attachments.add(fds);
       attachments.add(bays);

    }

    public String send() {
        
        System.out.println("sending email !!!!!!!!!! from:"+this.from+ " to:"+this.to);

        // create some properties and get the default Session
        try {
            // create a message
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(this.from));
            InternetAddress[] address = {new InternetAddress(this.to)};
            msg.setRecipients(Message.RecipientType.TO, address);
            msg.setSubject(subject);

            // create and fill the first message part
            MimeBodyPart mbp1 = new MimeBodyPart();
            mbp1.setText(msgText);

            // create the Multipart and add its parts to it
            Multipart mp = new MimeMultipart();
            mp.addBodyPart(mbp1);

            Iterator i = attachments.iterator();
            while (i.hasNext()) {
                // create the second message part
                MimeBodyPart mbp = new MimeBodyPart();
                ByteArrayDataSource bads = (ByteArrayDataSource) i.next();

                mbp.setDataHandler(new DataHandler(bads));
                mbp.setFileName(bads.getName());
                mp.addBodyPart(mbp);
            }

            // add the Multipart to the message
            msg.setContent(mp);

            // set the Date: header
            msg.setSentDate(new Date());

            // send the message
            Transport.send(msg);
         }catch(javax.mail.internet.ParseException pex){
            pex.printStackTrace();
            System.err.println(pex.getMessage());
            return "ParseExeption:"+pex.getLocalizedMessage();
         } catch (MessagingException mex) {
            System.err.println(mex.getMessage());
            mex.printStackTrace();
            return "MessagingExeption:"+mex.getLocalizedMessage();
        }
        return null;
    }

    private class SMTPAuthenticator extends javax.mail.Authenticator {

        String username, password;

        public SMTPAuthenticator(String username, String password) {
            this.username = username;
            this.password = password;
        }

        public PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
        }
    }
}
