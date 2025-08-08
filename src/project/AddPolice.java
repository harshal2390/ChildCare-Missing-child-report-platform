package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddPolice extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddPolice() {
        super();
    }

    // Handle POST request
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set encoding and content type


        String name = request.getParameter("name");
        String station = request.getParameter("station");
        String contact = request.getParameter("contact");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int pid=0;
  

        try {
            
            Connection con = DBConnection.connect();

          
            String sql = "INSERT INTO police  VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, pid);
            ps.setString(2, name);
            ps.setString(3, station);
            ps.setString(4, contact);
            ps.setString(5, email);
            ps.setString(6, password); 

            int i = ps.executeUpdate();

            if (i > 0) {
              response.sendRedirect("AdminDashboard.jsp");
            } else {
               response.sendRedirect("error.html");
            }

            // Close resources
           

        } catch (Exception e) {
            e.printStackTrace();
          
        }
    }

    // Optional GET method for testing
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("AddPolice servlet is running at: ").append(request.getContextPath());
    }
}
