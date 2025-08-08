package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CitizenChangePass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public CitizenChangePass() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    int cid = GetSet.getCid(); 
	    String password = request.getParameter("password");
	    String newPass = request.getParameter("newPassword");
	    
	    try {
	        Connection con = DBConnection.connect();

	        
	        PreparedStatement pst1 = con.prepareStatement("SELECT * FROM citizen WHERE cid = ? AND password = ?");
	        pst1.setInt(1, cid);
	        pst1.setString(2, password);
	        ResultSet rs = pst1.executeQuery();

	        if (rs.next()) {
	            
	            PreparedStatement pst2 = con.prepareStatement("UPDATE citizen SET password = ? WHERE cid = ?");
	            pst2.setString(1, newPass);
	            pst2.setInt(2, cid);
	            int updated = pst2.executeUpdate();

	            if (updated > 0) {
	                response.sendRedirect("citizen_dashboard.jsp");
	            } else {
	                response.sendRedirect("error.html"); 
	            }

	          
	        } else {
	            response.sendRedirect("wrong_password.html"); 
	        }



	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("error.html");
	    }
	}


}
