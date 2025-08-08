package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PoliceChangePass
 */
public class PoliceChangePass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PoliceChangePass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   int pid=GetSet.getPid();
		String password = request.getParameter("password");
	    String newPass = request.getParameter("newpass");
	    
	    try {
	        Connection con = DBConnection.connect();

	        
	        PreparedStatement pst1 = con.prepareStatement("SELECT * FROM police WHERE pid = ? AND password = ?");
	        pst1.setInt(1, pid);
	        pst1.setString(2, password);
	        ResultSet rs = pst1.executeQuery();

	        if (rs.next()) {
	            
	            PreparedStatement pst2 = con.prepareStatement("UPDATE police SET password = ? WHERE pid = ?");
	            pst2.setString(1, newPass);
	            pst2.setInt(2, pid);
	            int updated = pst2.executeUpdate();

	            if (updated > 0) {
	                response.sendRedirect("police_dashboard.jsp");
	            } else {
	                response.sendRedirect("error.html"); 
	            }

	          
	        } else {
	            response.sendRedirect("wrong_password.html"); 
	        }



	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("error.html");
	    
		doGet(request, response);
	}

	}}
