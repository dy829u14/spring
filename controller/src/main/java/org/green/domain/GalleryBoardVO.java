package org.green.domain;

import lombok.Data;

@Data
public class GalleryBoardVO {
	private int gno;
	private String title;
	private String writer;
	private String fileName;
	private String uploadPath;
	private String category;
	private String content;
	private String fullname;
}
