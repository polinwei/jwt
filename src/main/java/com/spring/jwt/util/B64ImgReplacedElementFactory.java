package com.spring.jwt.util;

import java.io.IOException;

import org.w3c.dom.Element;
import org.xhtmlrenderer.extend.FSImage;
import org.xhtmlrenderer.extend.ReplacedElement;
import org.xhtmlrenderer.extend.ReplacedElementFactory;
import org.xhtmlrenderer.extend.UserAgentCallback;
import org.xhtmlrenderer.layout.LayoutContext;
import org.xhtmlrenderer.pdf.ITextFSImage;
import org.xhtmlrenderer.pdf.ITextImageElement;
import org.xhtmlrenderer.render.BlockBox;
import org.xhtmlrenderer.simple.extend.FormSubmissionListener;

import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Image;
import com.sun.mail.util.BASE64DecoderStream;

public class B64ImgReplacedElementFactory implements ReplacedElementFactory {

	@Override
	public ReplacedElement createReplacedElement(LayoutContext c, BlockBox box, UserAgentCallback uac, int cssWidth,
			int cssHeight) {
		Element e = box.getElement();
	     if (e == null) {
	         return null;
	     }
	     String nodeName = e.getNodeName();
	     if (nodeName.equals("img")) {
	         String attribute = e.getAttribute("src");
	         FSImage fsImage;
	         try {
	             fsImage = buildImage(attribute, uac);
	         } catch (BadElementException e1) {
	             fsImage = null;
	         } catch (IOException e1) {
	             fsImage = null;
	         }
	         if (fsImage != null) {
	             if (cssWidth != -1 || cssHeight != -1) {
	                 fsImage.scale(cssWidth, cssHeight);
	             }
	             return new ITextImageElement(fsImage);
	         }
	     }
	     return null;
	}

	protected FSImage buildImage(String srcAttr, UserAgentCallback uac) throws IOException, BadElementException {
		FSImage fsImage;
		String imagePath = "/fileUpload/" + srcAttr ;
		fsImage = uac.getImageResource(imagePath).getImage();
		return fsImage;
	}
	
	@Override
	public void reset() {
		// TODO Auto-generated method stub

	}

	@Override
	public void remove(Element e) {
		// TODO Auto-generated method stub

	}

	@Override
	public void setFormSubmissionListener(FormSubmissionListener listener) {
		// TODO Auto-generated method stub

	}

}
