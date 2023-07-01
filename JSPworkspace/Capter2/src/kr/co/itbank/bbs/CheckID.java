package kr.co.itbank.bbs;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@WebServlet("/CheckID")
public class CheckID extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private HttpSession session = null;
	private String resultMsg = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json;charset=utf-8");
		
		InputStream is = request.getInputStream();
		
		PrintWriter out = response.getWriter();
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		String line;
		
		JSONParser jsonParser = new JSONParser();
		
		try {
			while((line = br.readLine()) != null) {
				JSONObject jsonObject = (JSONObject) jsonParser.parse(line);
				JSONObject test = new JSONObject();
				test.put("resultMsg", "success");
				
				System.out.println(jsonObject.get("id"));
				out.print(test);
				out.flush();
			}
		} catch (ParseException e) {
			System.out.println("error : "+e.getMessage());
		}finally {
			br.close();
			out.close();
		}
		
	}
	

}
