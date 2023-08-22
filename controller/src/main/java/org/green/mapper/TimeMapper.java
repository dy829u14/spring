package org.green.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	@Select("select * from tbl_board")
	public String getTime();
	//XML방식
	public String getTime2();
}
