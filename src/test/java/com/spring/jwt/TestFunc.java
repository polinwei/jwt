package com.spring.jwt;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;

import org.springframework.util.ResourceUtils;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
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
import java.util.stream.Stream;


public class TestFunc {

	public static void main(String[] args) throws Exception  {
		// TODO Auto-generated method stub
		try {
			File xmlFile = ResourceUtils.getFile("classpath:ckfinder-config.xml");
			readMXLFile(xmlFile);
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void readMXLFile(File xmlFile) throws Exception {
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
}

