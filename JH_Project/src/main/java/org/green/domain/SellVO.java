package org.green.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class SellVO {
	private String mId;
	private Long sno;
	private String sTitle;
	private String sPrice;
	private String sContent;
	private String sCate;
	private Date sRdate;
	private String sHit;
	
	private List<SellAttachVO> attachList;
}
