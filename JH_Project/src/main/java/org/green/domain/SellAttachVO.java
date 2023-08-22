package org.green.domain;

import lombok.Data;

@Data
public class SellAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private Long sno;
}
