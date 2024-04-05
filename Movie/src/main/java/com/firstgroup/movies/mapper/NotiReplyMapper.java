package com.firstgroup.movies.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.firstgroup.movies.domain.Criteria;
import com.firstgroup.movies.domain.NotiReplyVO;

public interface NotiReplyMapper {

	public int insert(NotiReplyVO vo);
	
	public NotiReplyVO read(Long bno);
	
	public int delete (Long rno);
	
	public int update(NotiReplyVO reply);
	
	public List<NotiReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	//MyBatis는 두 개 이상의 데이터를 파라미터로 전달하기 위해서는 @Param을 이용하는 방식이 있다.
	
	// 댓글들을 페이징 처리하기위해 해당 게시물의 전체 댓글의 숫자를 파악해서 화면에 보여준다.
	public int getCountByBno(Long bno);
	
	
}
