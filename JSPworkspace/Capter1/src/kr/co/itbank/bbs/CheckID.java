package kr.co.itbank.bbs;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet("/CheckID")
public class CheckID extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private String resultMsg = null;
	private JSONObject msgObject = null;
	private String id = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("application/json;charset=utf-8");
		
		msgObject = new JSONObject();
		InputStream is = request.getInputStream();
		PrintWriter out = response.getWriter();
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
				
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			
			JSONParser jsonParser = new JSONParser();
			String line = "";
			
			while((line = br.readLine()) != null) {
				JSONObject jsonObject = (JSONObject) jsonParser.parse(line);
				String sql = "select * from member_table where id = ?";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, (String)jsonObject.get("id"));
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					msgObject.put("resultMsg", "undefined");
				}else {
					msgObject.put("resultMsg", "success");
				}
				
				out.print(msgObject);
				out.flush();
			}
			
			
		}catch(Exception e) {
			System.out.println("[BBSInsert] Error : " + e.getMessage());
		} finally{
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				if(out != null) out.close();
				if(br != null) br.close();
			} catch (Exception e2) {}
		}
	}
	

}
