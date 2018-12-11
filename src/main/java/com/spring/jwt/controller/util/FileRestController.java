package com.spring.jwt.controller.util;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StreamUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.spring.jwt.service.BaseService;


@RestController
public class FileRestController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	ResourceLoader resourceLoader;
	@Autowired
	BaseService baseService;
	
	@PostMapping("/auth/upload/ckeditorImage")
    // If not @RestController, uncomment this
    @ResponseBody
	public ResponseEntity<?> ckeditorUploadImage(@RequestParam("uploadType") String uploadType, @RequestParam("upload") MultipartFile uploadfile,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		logger.debug("ckeditor file upload!");
		
		Map<String,Object> responseJson = new HashMap<String,Object>();
		Map<String,Object> responseError = new HashMap<String,Object>();
		
		if (!uploadfile.isEmpty()) {

			try {
				saveUploadedFiles(uploadType, Arrays.asList(uploadfile));

				// 組裝返回 JSON
				// https://ckeditor.com/docs/ckeditor4/latest/guide/dev_file_upload.html

				String imageUrl = "/auth/showimg/" + uploadType + "/" + uploadfile.getOriginalFilename();
				// 將上傳的圖片的 url 返回給 ckeditor
				responseJson.put("uploaded", 1);
				responseJson.put("fileName", uploadfile.getOriginalFilename());
				responseJson.put("url", imageUrl);

			} catch (Exception e) {
				responseJson.put("uploaded", 0);
				responseError.put("message", "Processing error.");
				responseJson.put("error", responseError);
			}
		} else {
			responseJson.put("uploaded", 0);
			responseError.put("message", "The file is empty.");
			responseJson.put("error", responseError);
		}
		
        return ResponseEntity
                .ok()
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body(responseJson);
       
	}
	
	
	// Single file upload
    @PostMapping("/auth/upload/file")
    // If not @RestController, uncomment this
    @ResponseBody
	public ResponseEntity<?> uploadFile(@RequestParam("uploadType") String uploadType, @RequestParam("file") MultipartFile uploadfile) {
		logger.debug("Single file upload!");

        if (uploadfile.isEmpty()) {
            return new ResponseEntity("please select a file!", HttpStatus.OK);
        }
        try {
        	saveUploadedFiles(uploadType, Arrays.asList(uploadfile));
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
        
        return new ResponseEntity("Successfully uploaded - " +
                uploadfile.getOriginalFilename(), new HttpHeaders(), HttpStatus.OK);
	}
	
    // Multiple file upload
    @PostMapping("/auth/upload/multiFiles")
    public ResponseEntity<?> uploadFileMulti(@RequestParam("uploadType") String uploadType,  @RequestParam("files") MultipartFile[] uploadfiles)  {

        logger.debug("Multiple file upload!");

        // Get file name
        String uploadedFileName = Arrays.stream(uploadfiles).map(x -> x.getOriginalFilename())
                .filter(x -> !StringUtils.isEmpty(x)).collect(Collectors.joining(" , "));

        if (StringUtils.isEmpty(uploadedFileName)) {
            return new ResponseEntity("please select a file!", HttpStatus.OK);
        }

        try {

            saveUploadedFiles(uploadType, Arrays.asList(uploadfiles));

        } catch (IOException e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity("Successfully uploaded - " + uploadedFileName, HttpStatus.OK);

    }
    
    //save file
    private void saveUploadedFiles(String uploadType, List<MultipartFile> files) throws IOException {

    	String UPLOADED_FOLDER = baseService.getImagePathByType(uploadType);
    	if (UPLOADED_FOLDER.isEmpty()) {
    		UPLOADED_FOLDER = "modules/" + uploadType;
    	}
    	
    	File folder = new File("/fileUpload/" + UPLOADED_FOLDER);
    	if (!folder.exists()) {
    		folder.mkdirs();
    	}
    	
        for (MultipartFile file : files) {

            if (file.isEmpty()) {
                continue;
            }

            byte[] bytes = file.getBytes();
            Path path = Paths.get("/fileUpload/" + UPLOADED_FOLDER + "/" + file.getOriginalFilename());
            Files.write(path, bytes);
            
        }

    }    
	
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
		if (imagePath.isEmpty()) {
			imagePath = "modules/" + imageType;
    	}
		
		Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ imagePath + "/" + filename);
		response.setContentType(MediaType.IMAGE_JPEG_VALUE);
        StreamUtils.copy(imgFile.getInputStream(), response.getOutputStream());
	}
	
	@RequestMapping(value = "/auth/showpic/{imageType}/{filename}", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<byte[]> showPic( @PathVariable String imageType, @PathVariable String filename ) throws IOException {
    	String imagePath = baseService.getImagePathByType(imageType);
    	if (imagePath.isEmpty()) {
			imagePath = "modules/" + imageType;
    	}
    	
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
    	if (imagePath.isEmpty()) {
			imagePath = "modules/" + imageType;
    	}
    	
    	Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ imagePath + "/" + filename);
    	return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(new InputStreamResource(imgFile.getInputStream()));
    	
    }
    
    @RequestMapping(value = "/auth/showCKFinderPic/{username}/images/{filename}", produces = MediaType.IMAGE_JPEG_VALUE)
    public ResponseEntity<InputStreamResource> showCKFinderPic( @PathVariable String username, @PathVariable String filename ) throws IOException {
    	String imagePath = baseService.getImagePathByType("ckeditorStorageImagePath") + "/" + username +"/images/";
    	
    	Resource imgFile = resourceLoader.getResource("file:/fileUpload/"+ imagePath + filename);
    	return ResponseEntity
                .ok()
                .contentType(MediaType.IMAGE_JPEG)
                .body(new InputStreamResource(imgFile.getInputStream()));
    	
    }
}
