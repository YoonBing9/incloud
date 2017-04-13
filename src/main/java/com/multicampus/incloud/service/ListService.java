package com.multicampus.incloud.service;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.ui.Model;

import com.multicampus.incloud.dto.ListDTO;

public interface ListService {
	void execute(ListDTO vo, Model model) throws RserveException, REXPMismatchException;
}
