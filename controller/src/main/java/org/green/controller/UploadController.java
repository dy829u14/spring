package org.green.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.green.domain.AttachFileDTO;
import org.green.domain.GalleryBoardVO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	//연 월 일 폴더 생성하기
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		//운영체제마다 파일 경로 구분자가 다르기 때문에 '/'을 직접 넣기보다 File.separator로 운영체제에 맞는 구분자가 삽입되게 함
		//separator=파일 구분자(윈도우에선 '/')
		return str.replace("-", File.separator); // -> 0000/00/00 형태로 바뀜
	}
	//이미지 파일인지 체크하기
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "C:\\upload";
		for(MultipartFile multipartfile : uploadFile) {
			log.info("------------------------------");
			log.info("파일 이름 : " + multipartfile.getOriginalFilename());
			log.info("파일 크기 : " + multipartfile.getSize());
			
			File saveFile = new File(uploadFolder, multipartfile.getOriginalFilename());
			try {
				multipartfile.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	@PostMapping("/uploadAjaxAction")
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();
		log.info("upload ajax post....................");
		String uploadFolder = "c:\\upload";
		String uploadFolderPath = getFolder();
		//폴더 생성하기
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("uploadPath : " + uploadPath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartfile : uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			log.info("------------------------------");
			log.info("파일 이름 : " + multipartfile.getOriginalFilename());
			log.info("파일 크기 : " + multipartfile.getSize());
			
			String uploadFileName = multipartfile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
			log.info("only file name : " + uploadFileName);
			
			//파일 이름 필드에 할당
			attachDTO.setFileName(uploadFileName);
			
			//중복방지 UUID 사용하기(임의의 값을 생성)
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartfile.transferTo(saveFile);
				//파일이 이미지 파일이라면 썸네일 이미지 생성하기
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(
							uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartfile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				
				//uuid 필드에 할당
				attachDTO.setUuid(uuid.toString());
				//이미지 경로 필드에 할당
				attachDTO.setUploadPath(uploadFolderPath);
				list.add(attachDTO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}

	//썸네일 데이터 전송하기
	//fileName을 전달받고 byte전송해줌
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("filename : " + fileName);
		File file = new File("C:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;
		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//첨부파일 삭제 
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile :  " + fileName);
		File file;
		try {
			file = new File("c:\\upload\\"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			//이미지파일 이라면  원본 이미지도 제거
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_","");
				log.info("largeFileName : " + largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity<String>("deleted" , HttpStatus.OK);
		
	}
}
