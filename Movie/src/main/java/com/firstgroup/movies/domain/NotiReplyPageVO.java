package com.firstgroup.movies.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor//replyCnt와 list를 생성자의 파라미터로 처리
@Getter
public class NotiReplyPageVO {
//댓글과 댓글 수 처리하기위한 클래스	
	private int replyCnt;
	private List<NotiReplyVO> list;
}
