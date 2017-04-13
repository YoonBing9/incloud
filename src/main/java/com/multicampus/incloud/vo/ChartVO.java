package com.multicampus.incloud.vo;

import java.util.List;

public class ChartVO {
	private String part2;
	private String[][] datas;
	private List<String> charts;
	public String getPart2() {
		return part2;
	}
	public void setPart2(String part2) {
		this.part2 = part2;
	}
	public String[][] getDatas() {
		return datas;
	}
	public void setDatas(String[][] datas) {
		this.datas = datas;
	}
	public List<String> getCharts() {
		return charts;
	}
	public void setCharts(List<String> charts) {
		this.charts = charts;
	}
}
