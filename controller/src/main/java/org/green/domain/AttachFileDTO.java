package org.green.domain;

import lombok.Data;

@Data
//원본파일이름, 파일경로, uuid값, 이미지여부정보를 하나로 묶어서 전달하는용도
public class AttachFileDTO {
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
}
