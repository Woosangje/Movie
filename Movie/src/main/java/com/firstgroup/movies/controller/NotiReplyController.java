package com.firstgroup.movies.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.firstgroup.movies.domain.Criteria;
import com.firstgroup.movies.domain.NotiReplyPageVO;
import com.firstgroup.movies.domain.NotiReplyVO;
import com.firstgroup.movies.service.NotiReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;



@RequestMapping("/replies/")
@RestController//댓글을 Rest방식을 사용한다.
@Log4j2
@AllArgsConstructor//를 이용해서 NotiReplyService.java의 객체를 필요로 하는 생성자를 만들어 사용(스프링 4.3이상) 
public class NotiReplyController {

	private NotiReplyService service;
	
	@PostMapping(value = "/new", 
			consumes = "application/json", 
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody NotiReplyVO vo) {
	//DB의 tbl_noti_reply 테이블에 새 댓글 데이터 입력 
	//consumes와 produces를 이용해서 JSON방식의 데이터만 처리하고, 문자열을 반환하도록 설계
	//@RequestBody를 적용해서 JSON 데이터를 NotiReplyVO 타입으로 변환하도록 지정
	//주의할점 JSON문법으로 작성할경우 띄어쓰기 사용하지말것
		int insertCount = service.register(vo);


		return insertCount == 1  
				?  new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/pages/{bno}/{page}", 
			produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<NotiReplyPageVO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) {
	//DB의 tbl_noti_reply 테이블의 특정 공지의 댓글 목록 확인
	//NotiReplyController.java의 getList()는 Criteria를 이용해서 파라미터를 수집하는데 
	// '/{bno}/{page}의 'page'값은 Criteria를 생성해서 집접 처리해야 합니다.
	// 게시물의 번호는 @PathVariable을 이용해서 파라미터로 처리한다.
	//http://localhost/replies/pages/1/1
		Criteria cri = new Criteria(page, 10);
		
		log.info("get Reply List bno: " + bno);

		log.info("cri:" + cri);

		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
	}

	
	
	@GetMapping(value = "/{rno}", 
			produces = { MediaType.APPLICATION_XML_VALUE, 
					     MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<NotiReplyVO> get(@PathVariable("rno") Long rno) {
	// 
		log.info("get: " + rno);

		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}
	
	@DeleteMapping(value= "/{rno}", produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
	// 
		return service.remove(rno) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);		
	}

	@RequestMapping(method = { RequestMethod.PUT,
			RequestMethod.PATCH }, value = "/{rno}", consumes = "application/json", produces = {
					MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(
			 @RequestBody NotiReplyVO vo, 
			 @PathVariable("rno") Long rno) {

		vo.setRno(rno);

		log.info("rno: " + rno);
		log.info("modify: " + vo);

		return service.modify(vo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
	
	
	
	
	
}
