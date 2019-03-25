package com.spring.jwt;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.xml.parsers.DocumentBuilder;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.ResourceUtils;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import com.spring.jwt.model.Mail;
import com.spring.jwt.service.EmailService;

import org.w3c.dom.Node;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Stream;

@RunWith(SpringRunner.class)
@SpringBootTest
public class TestFunc {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	ResourceLoader resourceLoader;
	@Autowired
    private EmailService emailService;
	
	@Test
	public void readMXLFile() throws Exception {
		File xmlFile = ResourceUtils.getFile("classpath:ckfinder-config.xml");
		InputStream is = new FileInputStream(xmlFile);
		StringBuilder contentBuilder = new StringBuilder();
		try (Stream<String> stream = Files.lines(Paths.get(xmlFile.getAbsolutePath()), StandardCharsets.UTF_8)) {
			stream.forEach(s -> contentBuilder.append(s).append("\n"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println(contentBuilder.toString());

		ByteArrayInputStream bis = new ByteArrayInputStream(contentBuilder.toString().getBytes());

		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		dbf.setIgnoringComments(true);
		dbf.setIgnoringElementContentWhitespace(true);
		DocumentBuilder db = dbf.newDocumentBuilder();
		Document doc = db.parse(bis);
		// Normalize the XML Structure; It's just too important !!
		doc.getDocumentElement().normalize();
		Node node = doc.getFirstChild();

		if (node != null) {
			NodeList nodeList = node.getChildNodes();
			boolean enabled = false;
			for (int i = 0; i < nodeList.getLength(); ++i) {
				Node childNode = nodeList.item(i);
				if (childNode.getNodeName().equals("enabled"))
					enabled = Boolean.valueOf(childNode.getTextContent().trim()).booleanValue();
			}
		}

	}
	
	@Test
	public void sendSimpleMail() throws Exception {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("username@domain.onmicrosoft.com");
		message.setTo("polin.wei@domain.com");
		message.setSubject("請各主機負責人測試O365 Mail Relay功能");
		message.setText(" java mail 已經測了MX 以及 SMTP兩種方法，可以正常寄信。");

		mailSender.send(message);
	}
	
	@Test
	public void sendAttachmentsMail() throws Exception {

		MimeMessage mimeMessage = mailSender.createMimeMessage();

		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		helper.setFrom("username@domain.onmicrosoft.com");
		helper.setTo("polin.wei@domain.com");
		helper.setSubject("主題：有附件");
		helper.setText("有附件的郵件");

		//FileSystemResource file = new FileSystemResource(new File("avatar.png"));
		Resource imgFile = resourceLoader.getResource("file:/fileUpload/images/noImage.jpg");
		helper.addAttachment("附件-1.jpg", imgFile);
		helper.addAttachment("附件-2.jpg", imgFile);

		mailSender.send(mimeMessage);

	}
	
	@Test
	public void sendInlineMail() throws Exception {

		MimeMessage mimeMessage = mailSender.createMimeMessage();
		Set<String> mailAddrs = new HashSet<String>();
		mailAddrs.add("polin.wei@domain.com");
		mailAddrs.add("polin.wei@gmail.com");
		String[] mailTo = mailAddrs.toArray(new String[mailAddrs.size()]);
		

		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true);
		helper.setFrom("username@domain.onmicrosoft.com");
		helper.setTo(mailTo);
		helper.setSubject("主題：嵌入圖片在信件內文 15:03");
		helper.setText("<html><body>HTML樣式, 不能只有圖,還要有文字,否則O365不寄送<img src=\"cid:weixin\" ></body></html>", true);
		
		//要注意的是addInline函數中資源名稱weixin需要與正文中cid:weixin對應起來
		Resource imgFile = resourceLoader.getResource("file:/fileUpload/images/noImage.jpg");		
		helper.addInline("weixin", imgFile);

		mailSender.send(mimeMessage);

	}
	
	@Test
	public void sendTemplateMail() throws Exception {
		logger.info("Sending Email with Freemarker HTML Template Example");
		Map attachments = new HashMap();
		Resource imgFile = resourceLoader.getResource("file:/fileUpload/images/noImage.jpg");
		attachments.put("附件-1.jpg",imgFile);
		attachments.put("附件-2.jpg",imgFile);
		String templateFileName = "mail/email-demoTemplate.ftl";
		
		Mail mail = new Mail();
        mail.setFrom("username@domain.onmicrosoft.com");
        mail.setTo("polin.wei@domain.com");
        mail.setSubject("Sending Email with Freemarker HTML Template Example");
        mail.setAttachments(attachments);

        Map model = new HashMap();
        model.put("name", "Polin WEI");
        model.put("location", "Taiwan");
        model.put("signature", "https://tw.yahoo.com");
        mail.setModel(model);

        emailService.sendSimpleMessage(mail,templateFileName);
		
	}
}

