package com.multicampus.incloud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.multicampus.incloud.vo.ListVO;

@Controller
public class ListController {
	
	@RequestMapping(value="/list/post", method = RequestMethod.POST)
	public String inputPost(ListVO vo) {		
		System.out.println(vo.toString());
		return "result";
	}
	
	@RequestMapping("/list")
	public void inputView() {}
}
