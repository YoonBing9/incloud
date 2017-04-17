package com.multicampus.incloud.rao;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import com.multicampus.incloud.dto.AjaxDTO;

public class AjaxRAO {
	private RConnection con = null;
	
	public AjaxRAO() throws RserveException {
		this.con = new RConnection();
		con.eval("library(DBI);library(RJDBC);library(ggplot2);library(Cairo);library(png);"
				+ "drv <- JDBC('oracle.jdbc.driver.OracleDriver','C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6_g.jar');"
				+ "conn <- dbConnect(drv, 'jdbc:oracle:thin:@localhost:1521:xe','incloud','incloud');");
	}
	
	public String[][] getDatas(AjaxDTO dto) throws RserveException, REXPMismatchException {
		String id = dto.getId();
		String type = dto.getType();
		String select = "", from = "", where = "", query = "";
		String[][] datas = null;
		System.out.println("id:"+id);
		System.out.println("type:"+type);
		if(!id.equals("")) {
			switch(type) {
			case "barChart" :
				select = "word, assc";
				from = "ASSC";
				where = "id="+id;
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
		}		
		return datas;
	}
}
