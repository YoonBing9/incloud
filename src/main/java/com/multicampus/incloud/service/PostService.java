package com.multicampus.incloud.service;

import java.util.ArrayList;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.ui.Model;

import com.multicampus.incloud.dto.ListDTO;
import com.multicampus.incloud.rao.ListRAO;
import com.multicampus.incloud.vo.ChartVO;

public class PostService implements ListService{
	@Override
	public void execute(ListDTO dto, Model model) throws RserveException, REXPMismatchException {
		ListRAO rao = new ListRAO();
		ArrayList<ChartVO> datalist = rao.getDatas(dto);
		model.addAttribute("datalist", datalist);
	}
}
