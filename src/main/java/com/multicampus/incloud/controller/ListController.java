package com.multicampus.incloud.controller;

import java.io.IOException;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multicampus.incloud.dto.ListDTO;
import com.multicampus.incloud.service.PostService;

@Controller
public class ListController {
	
	@RequestMapping(value="/list/post", method = RequestMethod.POST)
	public String inputPost(ListDTO dto, Model model) throws RserveException, REXPMismatchException, JsonGenerationException, JsonMappingException, IOException {		
		PostService ps = new PostService();
		ps.execute(dto, model);
		return "result";
	}
	
	@RequestMapping("/list")
	public void inputView() {}
}
