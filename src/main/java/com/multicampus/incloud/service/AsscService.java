package com.multicampus.incloud.service;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RserveException;

import com.multicampus.incloud.dto.AjaxDTO;
import com.multicampus.incloud.rao.AjaxRAO;

public class AsscService {
	public String[][] getChildrenDatas(AjaxDTO dto) throws RserveException, REXPMismatchException {
		AjaxRAO rao = new AjaxRAO();
		return rao.getDatas(dto);
	}
}
