package org.green.domain;

import lombok.Data;

@Data
public class BookVO {
	private int bno;
	private String title;
	private String writer;
	private int price;
	private String filename;
	private String uploadpath;
	private String fullname;
}
