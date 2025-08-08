package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Addchildreport
 */
public class Addchildreport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Addchildreport() {
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
		int id=0;
		String childName=request.getParameter("childName");
		int age=Integer.parseInt(request.getParameter("age"));
		String lastSeenLocation=request.getParameter("lastSeenLocation");
		String imagePath=request.getParameter("imagePath");
		String reportDate=request.getParameter("reportDate");
		String status=request.getParameter("status");
		String description=request.getParameter("description");
		int cid=GetSet.getCid();
		Connection con=DBConnection.connect();
		try {
			PreparedStatement pst=con.prepareStatement("insert into child_report values(?,?,?,?,?,?,?,?,?)");
			pst.setInt(1, id);
			pst.setString(2, childName);
			pst.setInt(3, age);
			pst.setString(4, lastSeenLocation);
			pst.setString(5, imagePath);
			pst.setString(6, reportDate);
			pst.setString(7, status);
			pst.setString(8, description);
			pst.setInt(9, cid);
			
			int i=	pst.executeUpdate();
			if(i>0)
			{
				response.sendRedirect("successchildreport.html");
				
			}else
			{
				response.sendRedirect("error.html");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

		doGet(request, response);
	}

}
