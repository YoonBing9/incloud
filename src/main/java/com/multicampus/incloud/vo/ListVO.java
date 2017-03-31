package com.multicampus.incloud.vo;

import java.util.List;

public class ListVO {
	private String part1;
	private String part2;
	private String start;
	private String end;
	private List<String> graph;	
	private List<ListVO> ListVOList;
	
	public String getPart1() {
		return part1;
	}
	public void setPart1(String part1) {
		this.part1 = part1;
	}
	public String getPart2() {
		return part2;
	}
	public void setPart2(String part2) {
		this.part2 = part2;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public List<String> getGraph() {
		return graph;
	}
	public void setGraph(List<String> graph) {
		this.graph = graph;
	}
	public List<ListVO> getListVOList() {
		return ListVOList;
	}
	public void setListVOList(List<ListVO> listVOList) {
		ListVOList = listVOList;
	}
	@Override
	public String toString() {
		return "ListVO [part1=" + part1 + ", part2=" + part2 + ", start=" + start + ", end=" + end + ", graph=" + graph
				+ ", ListVOList=" + ListVOList + "]";
	}	
}
