package org.green.domain;

import lombok.Data;

@Data
public class GalleryBoardDTO {
	private int gno;
	private String title;
	private String writer;
	private String content;
	private String category;
	private String filename;
	private String uploadpath;
	private String fullname;
}	
