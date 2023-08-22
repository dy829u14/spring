package org.green.domain;

import lombok.Data;

@Data
public class MemberVO {
	private int mno;
	private String id;
	private String pass;
	private String name;
	private String phonenumber;
	private String address;
	private String email;
}
