package com.ogani.config.quartz;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.ogani.config.PathCollections;
import com.ogani.domain.ProductImageDTO;
import com.ogani.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class ImageRemoveTask {

	private final ProductMapper productMapper;

	private String uploadPath = PathCollections.LOCAL_PATH + File.separator 
			+ Paths.get("Ogani", "src", "main", "webapp", "resources", "upload").toString();
	
	private String getFolderBeforeDay(int beforeDay) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -(beforeDay));
		
		String targetDay = dateFormat.format(calendar.getTime());
		return targetDay.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 12 * * *")
	public void removeUnregisteredImages() {
		log.info("removeUnregisteredImages, {}", new Date());

		List<ProductImageDTO> oldImageList = productMapper.getOldImages();
		List<Path> oldImagePathList = oldImageList.stream().map(oldImage -> 
			Paths.get(uploadPath, oldImage.getProd_image_url(),
								  oldImage.getProd_image_uuid()
						  + "_" + oldImage.getProd_image_name())
		).collect(Collectors.toList());

		oldImageList.stream().map(oldImage -> 
		Paths.get(uploadPath, oldImage.getProd_image_url(),
				   "thumb_" + oldImage.getProd_image_uuid()
					  + "_" + oldImage.getProd_image_name())
		).forEach(oldThumbImagePath -> oldImagePathList.add(oldThumbImagePath));		
		
		File targetDir = Paths.get(uploadPath, getFolderBeforeDay(1), "product").toFile();
		File[] targetImageList = targetDir.listFiles(file -> oldImagePathList.contains(file.toPath()) == false);
		if (targetImageList != null) {
			for (File targetFile : targetImageList) {
				log.debug("targetFile = {}", targetFile);
				targetFile.delete();
			}
		}
	}
}