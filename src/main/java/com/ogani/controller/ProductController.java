package com.ogani.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.ProcessBuilder.Redirect;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ogani.config.PathCollections;
import com.ogani.domain.ProductCategoryDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.domain.ProductImageDTO;
import com.ogani.service.ProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@Controller
@Secured("ROLE_ADMIN")
@RequiredArgsConstructor
@RequestMapping("/admin/product")
public class ProductController {

	private final ProductService productService;
	
	private String uploadPath = PathCollections.LOCAL_PATH + File.separator 
			+ Paths.get("Ogani", "src", "main", "webapp", "resources", "upload").toString();
	
	@GetMapping
	public String product() {
		log.trace("product() GET");
		
		return "admin/product";
	}

	@GetMapping("/register")
	public String productRegisterForm(Model model) {
		log.trace("productRegisterForm() GET");
		
		List<ProductCategoryDTO> categoryList = productService.getAllCategory();
		model.addAttribute("categoryList", categoryList);
		
		return "admin/productRegister";
	}
	
	@PostMapping("/register")
	public String productRegister(@ModelAttribute ProductDTO product, RedirectAttributes redirectAttr) {
		log.debug("productRegister( {} ) POST", product);

		boolean result = productService.registerProduct(product);
		
		redirectAttr.addFlashAttribute("productRegisterResult", result);
		return "redirect:/admin/product";
	}
	
	@PostMapping("/registerCategory")
	public String registerCategory(@ModelAttribute ProductCategoryDTO category, RedirectAttributes redirectAttr) {
		log.debug("productRegister( {} ) POST", category);
		
		boolean result = productService.registerCategory(category);

		redirectAttr.addFlashAttribute("categoryRegisterResult", result);
		return "redirect:/admin/product/register";
	}
	
	@ResponseBody
	@PostMapping(value = "/uploadProductImage", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<ProductImageDTO> uploadProductImage(MultipartFile[] uploadedImage) {
		log.debug("uploadAjaxPost( {} ) POST", uploadedImage);
		
		List<ProductImageDTO> imageList = new ArrayList<>();

		String imageFolderPath = getDateFolder() + File.separator + Paths.get("product");
		File imageFolder = new File(uploadPath, imageFolderPath);
		log.debug("imageFolder = {}", imageFolder);

		if (!imageFolder.exists()) { imageFolder.mkdirs(); }

		for (MultipartFile image : uploadedImage) {

			String uploadFileName = image.getOriginalFilename();

			log.debug("Uploaded Image fileName = {}", uploadFileName);
			log.debug("Uploaded Image Size = {}", image.getSize());

			UUID uuid = UUID.randomUUID();

			ProductImageDTO productImageDTO = ProductImageDTO.builder()
					.prod_image_uuid(uuid.toString())
					.prod_image_name(uploadFileName)
					.prod_image_url (imageFolderPath.replace("\\", "/"))
					.build();

			uploadFileName = uuid.toString() + "_" + uploadFileName;
			File saveFile = new File(imageFolder, uploadFileName);
			try {
				image.transferTo(saveFile);

				File thumbnail = new File(imageFolder, "thumb_" + uploadFileName);
				Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);

			} catch (Exception e) { e.printStackTrace(); }

			imageList.add(productImageDTO);
		}
		
		log.debug("{}", imageList);
		return imageList;
	}
	
	@ResponseBody
	@GetMapping("/displayImage")
	public ResponseEntity<byte[]> displayImage(@RequestParam String imageName) {
		log.debug("displayImage( fileName = {} ) GET", imageName);

		File image = new File(uploadPath + File.separator + imageName);
		log.debug("image file path = {}", image);

		ResponseEntity<byte[]> result = ResponseEntity.noContent().build();

		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(image.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(image), header, HttpStatus.OK);

		} catch (IOException e) { e.printStackTrace(); }

		return result;
	}
	
	@ResponseBody
	@PostMapping("/deleteImage")
	public ResponseEntity<String> deleteImage(@RequestBody String imageName) {
		log.debug("deleteImage( imageName = {} )", imageName);
		
		
		File file;
		try {
			file = new File(uploadPath + File.separator + URLDecoder.decode(imageName, "UTF-8"));
			file.delete();

		} catch (UnsupportedEncodingException e) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String largeFileName = file.getAbsolutePath().replace("\\thumb_", "\\");
		new File(largeFileName).delete();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "text/html; charset=UTF-8");
		
		return new ResponseEntity<>("삭제 되었습니다", headers, HttpStatus.OK);
	}
	
	private String getDateFolder() {
		log.trace("getFolder()");
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy\\MM\\dd");
		return dateFormat.format(new Date());
	}

}