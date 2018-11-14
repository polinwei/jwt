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

import com.spring.jwt.service.BaseService;

@RestController
public class FileUpload {

	@Autowired
	ResourceLoader resourceLoader;
	@Autowired
	BaseService baseService;
	
	/**
	 * Show Image , like <img src="/auth/imgshow/{imageType}/{filename}" />
	 * @param imageType 相片類別
	 * @param filename 相片檔名
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "/auth/showimg/{imageType}/{filename}", method = RequestMethod.GET,produces = MediaType.IMAGE_JPEG_VALUE)
	public void showImage(@PathVariable String imageType, @PathVariable String filename, HttpServletResponse response) throws IOException {
		String imagePath = baseService.getImagePathByType(imageType);
		
		Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ imagePath + "/" + filename);
		response.setContentType(MediaType.IMAGE_JPEG_VALUE);
        StreamUtils.copy(imgFile.getInputStream(), response.getOutputStream());
	}
	
	@RequestMapping(value = "/auth/showpic/{imageType}/{filename}", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<byte[]> showPic( @PathVariable String imageType, @PathVariable String filename ) throws IOException {
    	String imagePath = baseService.getImagePathByType(imageType);
    	
    	Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ imagePath + "/" + filename);
    	byte[] bytes = StreamUtils.copyToByteArray(imgFile.getInputStream());
    	
    	return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(bytes);
    	
    }
    
    @RequestMapping(value = "/auth/showphoto/{imageType}/{filename}", produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<InputStreamResource> showPhoto( @PathVariable String imageType, @PathVariable String filename ) throws IOException {
    	String imagePath = baseService.getImagePathByType(imageType);
    	
    	Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ imagePath + "/" + filename);
    	return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(new InputStreamResource(imgFile.getInputStream()));
    	
    }
    
}
