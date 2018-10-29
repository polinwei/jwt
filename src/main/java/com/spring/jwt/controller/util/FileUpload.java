package com.spring.jwt.controller.util;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FileUpload {

	@Autowired
	ResourceLoader resourceLoader;
	
	/**
	 * Show Image , like <img src="/auth/imgshow/{filename}" />
	 * @param filename
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/auth/showimg/{filename}", method = RequestMethod.GET,produces = MediaType.IMAGE_JPEG_VALUE)
	public void showImage(@PathVariable String filename, HttpServletResponse response) throws IOException {
		
		Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ filename);
		response.setContentType(MediaType.IMAGE_JPEG_VALUE);
        StreamUtils.copy(imgFile.getInputStream(), response.getOutputStream());
	}
	
	@RequestMapping(value = "/auth/showpic/{filename}", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<byte[]> showPic( @PathVariable String filename ) throws IOException {
    	
    	Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ filename);
    	byte[] bytes = StreamUtils.copyToByteArray(imgFile.getInputStream());
    	
    	return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(bytes);
    	
    }
    
    @RequestMapping(value = "/auth/showphoto/{filename}", produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<InputStreamResource> showPhoto( @PathVariable String filename ) throws IOException {
    	Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ filename);
    	return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(new InputStreamResource(imgFile.getInputStream()));
    	
    }
    
}
