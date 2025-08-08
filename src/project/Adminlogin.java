package project;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Adminlogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public Adminlogin() {
        super();
     
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String	password=request.getParameter("password");
		
		if(email.equals("admin@gmail.com") && password.equals("admin")){
		response.sendRedirect("AdminDashboard.jsp");
		}else{
			response.sendRedirect("error.html");	
		}
		
	
		doGet(request, response);
	}

}
