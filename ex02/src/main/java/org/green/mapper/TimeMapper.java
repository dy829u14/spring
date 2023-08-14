package org.green.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {
	@Select("select * from tbl_board")
	public String getTime();
	public String getTime2();
}
