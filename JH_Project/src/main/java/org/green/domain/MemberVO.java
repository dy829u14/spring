package org.green.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class MemberVO {
	private String mno;
	private String mId;
	private String mPw;
	private String mName;
	private String mBirth;
	private String mPhone;
	private String mAddress;
	private String mLocation;
	private String mEmail;

	private List<AuthVO> authList;
}
