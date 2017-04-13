package com.multicampus.incloud.rao;

import java.util.ArrayList;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import com.multicampus.incloud.dto.ListDTO;
import com.multicampus.incloud.vo.ChartVO;

public class ListRAO {
	private RConnection con = null;
	private REXP x = null;
	
	public ListRAO() throws RserveException {
		this.con = new RConnection();
		con.eval("library(DBI);library(RJDBC);library(ggplot2);library(Cairo);library(png);"
				+ "drv <- JDBC('oracle.jdbc.driver.OracleDriver','C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6_g.jar');"
				+ "conn <- dbConnect(drv, 'jdbc:oracle:thin:@localhost:1521:xe','incloud','incloud');");
	}
	
	public ArrayList<ChartVO> getDatas(ListDTO dto) throws RserveException, REXPMismatchException {
		ArrayList<ChartVO> datalist = new ArrayList<ChartVO>();
		for(int i=0; i<dto.getListVOList().size(); i++) {						
			ListDTO tempDTO = dto.getListVOList().get(i);
			if(tempDTO!=null) {
				String[][] datas = null;
				ChartVO vo = new ChartVO();
				String query = "";
				String select = "";
				String from = "";
				String where = "";
				vo.setPart2(tempDTO.getPart2());
				vo.setCharts(tempDTO.getGraph());
				switch(tempDTO.getPart2()) {
				case "KOSPI" : 
					select = "thetime, kospi";
					from = "KOSPI";
					where = "thetime >= '"+tempDTO.getStart()+"/01' and thetime <= '"+tempDTO.getEnd()+"/01' order by thetime ASC";
					break;
				}
				query = "select "+select+" from "+from+" where "+where;
				con.assign("query", query);
				con.eval("rs <- dbSendQuery(conn, query);");
				con.eval("datas <- dbFetch(rs);");
				RList rl = con.eval("lapply(datas,as.character);").asList();
				int cols = rl.size();
				int rows = rl.at(0).length();
				
				String[][] s = new String[cols][];
				for (int j = 0; j < cols; j++) {
					s[j] = rl.at(j).asStrings();
	            }
				
				datas = new String[rows][];
				for(int j=0; j<rows; j++) {
					String[] temp = new String[cols];
					for(int h=0; h<cols; h++) {
						temp[h] = s[h][j];
					}
					datas[j] = temp;
				}
				vo.setDatas(datas);
				datalist.add(vo);
			}
		}
		return datalist;
	}	
}
