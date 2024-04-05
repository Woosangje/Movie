package com.firstgroup.movies.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.firstgroup.movies.domain.Criteria;
import com.firstgroup.movies.domain.NotiVO;
import com.firstgroup.movies.domain.PageVO;
import com.firstgroup.movies.service.NotiService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/notice/*")
@AllArgsConstructor
public class NotiController {
	
	private NotiService service;
	
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
	//tbl_noti_board 테이블의 데이터 출력
		
		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		
		int total = service.getTotal(cri);//page 길이를 위한 total
		
		model.addAttribute("pageMaker", new PageVO(cri, total));
		
	}
	
	@PostMapping("/register")
	public String register(NotiVO noti, RedirectAttributes rttr) {
	//DB의 tbl_noti_board 테이블에 새 데이터 입력
		log.info("register: " + noti);
		
		service.register(noti);
		
		rttr.addFlashAttribute("result", noti.getBno());
		
		return "redirect:/notice/list";//list페이지로 이동
	}
	@GetMapping("/register")
	public void register() {
	//register 페이지 출력을 위한 @GetMapping 메소드
		
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri")
	Criteria cri, Model model) {
	//공지의 세부 정보
		
		model.addAttribute("notice", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(NotiVO noti, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
	//공지 수정
		if(service.modify(noti)) {
			rttr.addFlashAttribute("result", "success");
			//값을 받으면 NotiMapper에서 update를 해준다. 수정 성공시 list페이지에서 success 팝업이 발생한다.
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());//현재 사용자가 보고있는 페이지의 넘버
		rttr.addAttribute("amount", cri.getAmount());//한번에 보이는 목록의 갯수
		
		return "redirect:/notice/list";
	}
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
	//공지 삭제
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
			//값을 받으면 NotiMapper에서 delete를 해준다. 삭제 성공시 list페이지에서 success 팝업이 발생한다.
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/notice/list";
		
	}
	
}
