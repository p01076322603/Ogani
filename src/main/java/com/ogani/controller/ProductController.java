package com.ogani.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.activation.MimetypesFileTypeMap;

import org.springframework.http.MediaType;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ogani.domain.ProductImageDTO;

import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Controller
@Secured("ROLE_ADMIN")
@RequestMapping("/admin/product")
public class ProductController {

	private String uploadPath = "D:\\Workspace\\Ogani\\src\\main\\webapp\\resources\\upload";
	
	@GetMapping
	public String product() {
		log.trace("product() GET");
		
		return "admin/product";
	}

	@GetMapping("/register")
	public String productRegister() {
		log.trace("productRegister() GET");
		
		return "admin/productRegister";
	}
	
	@ResponseBody
	@PostMapping(value = "/uploadProductImage", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<ProductImageDTO> uploadProductImage(MultipartFile[] uploadedImage) {
		log.info("uploadAjaxPost( {} ) POST", uploadedImage);
		List<ProductImageDTO> imageList = new ArrayList<>();

		String imageFolderPath = getDateFolder() + "/product";
		File imageFolder = new File(uploadPath, imageFolderPath);
		log.info("imageFolderPath = {}", imageFolder);

		if (!imageFolder.exists()) { imageFolder.mkdirs(); }

		for (MultipartFile image : uploadedImage) {
			log.info("-------------------------------------------------------");
			log.info("Uploaded Image Name = {}", image.getName());
			log.info("Uploaded Image Size = {}", image.getSize());
			log.info("Uploaded Image ContentType = {}", image.getContentType());

			ProductImageDTO productImageDTO = new ProductImageDTO();
			String uploadFileName = image.getOriginalFilename();

			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("//") + 1);
			log.info("Uploaded Image - Only File Name : {}", uploadFileName);

			productImageDTO.setFileName(uploadFileName);

			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;

			File saveFile = new File(imageFolder, uploadFileName);
			try {
				image.transferTo(saveFile);

				productImageDTO.setUuid(uuid.toString());
				productImageDTO.setUploadPath(imageFolderPath);

				if (checkImageType(saveFile)) {
					productImageDTO.setImage(true);

					File thumbnail = new File(imageFolder, "s_" + uploadFileName);
					Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);
				}
				imageList.add(productImageDTO);

			} catch (Exception e) { e.printStackTrace(); }
		}
		
		log.info("{}", imageList);
		return imageList;
	}
	
	private String getDateFolder() {
		log.trace("getFolder()");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		return dateFormat.format(new Date());
	}

	private boolean checkImageType(File file) {
		log.trace("chackImageType");
		
		MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
		String mimeType = mimeTypesMap.getContentType(file);

		return mimeType.contains("image");
	}
}
