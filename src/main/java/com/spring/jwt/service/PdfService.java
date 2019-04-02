package com.spring.jwt.service;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.util.Assert;
import org.springframework.util.ResourceUtils;
import org.xhtmlrenderer.pdf.ITextFontResolver;
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.pdf.BaseFont;
import com.spring.jwt.util.B64ImgReplacedElementFactory;
import com.spring.jwt.util.MediaReplacedElementFactory;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Service
public class PdfService {
	
	@Autowired
    private Configuration freemarkerConfig;
	
	/**
	 * Replaced element in order to replace elements like 
	 * <tt>&lt;div class="media" data-src="image.png" /></tt> with the real
	 * media content.
	 */
	public void generatePdf(Object model, String templateFileName, String pdfName) throws IOException, TemplateException, DocumentException{
		Assert.notNull(templateFileName, "template is null");
		Assert.notNull(pdfName, "template is null");
		
		File folder = new File("/fileUpload/pdfTemp");
    	if (!folder.exists()) {
    		folder.mkdirs();
    	}
		FileOutputStream out = new FileOutputStream(new File(folder+"/"+pdfName));
		ITextRenderer renderer = new ITextRenderer();
		ITextFontResolver fontResolver = renderer.getFontResolver();
        fontResolver.addFont("static/fonts/kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        renderer.getSharedContext().setReplacedElementFactory(new MediaReplacedElementFactory(renderer.getSharedContext().getReplacedElementFactory()));
                
		Template t = freemarkerConfig.getTemplate(templateFileName);
        String html = FreeMarkerTemplateUtils.processTemplateIntoString(t,model); 
        renderer.setDocumentFromString(html);
                
        //產生與建立pdf
        renderer.layout();
        renderer.createPDF(out, true);
        renderer.finishPDF(); // 完成 PDF 寫入
        out.flush();
        out.close();
		
	}

	public void createPdf(Object model, String templateFileName, String pdfName) throws IOException, TemplateException, DocumentException{
		Assert.notNull(templateFileName, "template is null");
		Assert.notNull(pdfName, "template is null");
		
		File folder = new File("/fileUpload/pdfTemp");
    	if (!folder.exists()) {
    		folder.mkdirs();
    	}
		FileOutputStream out = new FileOutputStream(new File(folder+"/"+pdfName));
		ITextRenderer renderer = new ITextRenderer();
		ITextFontResolver fontResolver = renderer.getFontResolver();
        fontResolver.addFont("static/fonts/kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);        
        renderer.getSharedContext().setReplacedElementFactory(new B64ImgReplacedElementFactory());
        
		Template t = freemarkerConfig.getTemplate(templateFileName);
        String html = FreeMarkerTemplateUtils.processTemplateIntoString(t,model); 
        renderer.setDocumentFromString(html);
                
        //產生與建立pdf
        renderer.layout();
        renderer.createPDF(out, true);
        renderer.finishPDF(); // 完成 PDF 寫入
        out.flush();
        out.close();
		
	}
	
}
