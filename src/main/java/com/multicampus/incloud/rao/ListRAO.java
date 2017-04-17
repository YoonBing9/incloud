package com.multicampus.incloud.rao;

import java.util.ArrayList;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import com.multicampus.incloud.dto.ListDTO;
import com.multicampus.incloud.vo.ChartVO;

public class ListRAO {
	private RConnection con = null;
	
	public ListRAO() throws RserveException {
		this.con = new RConnection();
		con.eval("library(DBI);library(RJDBC);library(ggplot2);library(Cairo);library(png);"
				+ "drv <- JDBC('oracle.jdbc.driver.OracleDriver','C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6_g.jar');"
				+ "conn <- dbConnect(drv, 'jdbc:oracle:thin:@localhost:1521:xe','incloud','incloud');");
	}
	
	public ArrayList<ChartVO> getDatas(ListDTO dto) throws RserveException, REXPMismatchException {
		ArrayList<ChartVO> datalist = new ArrayList<ChartVO>();
		for(int i=0; i<dto.getListVOList().size(); i++) {
			System.out.println(dto.getListVOList().get(i).toString());
		}
		for(int i=0; i<dto.getListVOList().size(); i++) {						
			ListDTO tempDTO = dto.getListVOList().get(i);
			if(tempDTO.getPart2() != null) {
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
				case "TFWORDS" :
					String part1 = "";
					select = "id, word";
					from = "TFWORDS";					
					if(tempDTO.getPart1().equals("경제")) part1="11";
					else if(tempDTO.getPart1().equals("정치")) part1="12";
					else if(tempDTO.getPart1().equals("문화")) part1="13";
					else if(tempDTO.getPart1().equals("IT")) part1="14";
					where = "id like '"+part1+"%' and thetime = '"+tempDTO.getStart()+"/01'";
					break;
				case "LYRICS" :
					select = "word, year, comp, freq";
					from = "LYRICS";
					where = "year >= '"+tempDTO.getStart()+"/01' and year <= '"+tempDTO.getEnd()+"/01'";
					break;
				case "ROEG" :
					select = "year, rate";
					from = "ROEG";
					where = "year >= '"+tempDTO.getStart()+"/01' and year <= '"+tempDTO.getEnd()+"/01'";
					break;
				case "GPC" :
					select = "year, GDP_per_capita";
					from = "GPC";
					where = "year >= '"+tempDTO.getStart()+"/01' and year <= '"+tempDTO.getEnd()+"/01'";
					break;
				case "UR" :
					select = "year, rate, youth_rate";
					from = "UR";
					where = "year >= '"+tempDTO.getStart()+"/01' and year <= '"+tempDTO.getEnd()+"/01'";
					break;
				case "ROE" :
					select = "year, rate";
					from = "ROE";
					where = "year >= '"+tempDTO.getStart()+"/01' and year <= '"+tempDTO.getEnd()+"/01'";
					break;
				case "BS" :
					select = "year, a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u";
					from = "BS";
					where = "year >= '"+tempDTO.getStart()+"/01' and year <= '"+tempDTO.getEnd()+"/01'";
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
				
				/*for(int j=0; j<datas.length; j++) {
					for(int h=0; h<datas[j].length; h++) {
						System.out.print(datas[j][h]);
					}System.out.println();
				}*/
				vo.setDatas(datas);
				datalist.add(vo);
			}
		}
		return datalist;
	}	
}
