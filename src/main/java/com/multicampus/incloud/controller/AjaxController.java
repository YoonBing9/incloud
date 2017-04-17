package com.multicampus.incloud.controller;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.multicampus.incloud.dto.AjaxDTO;
import com.multicampus.incloud.service.AsscService;

@Controller
public class AjaxController {
	@RequestMapping(value="/ajax/assc", method = RequestMethod.POST)
	@ResponseBody
	public String[][] ajaxAssc(AjaxDTO dto) throws RserveException, REXPMismatchException{
		AsscService service = new AsscService();
		return service.getChildrenDatas(dto);
	}
}
