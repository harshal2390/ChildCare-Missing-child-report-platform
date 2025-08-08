package project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class UpdateInvestigation extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UpdateInvestigation() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		String reportIdStr = request.getParameter("reportId");
		String status = request.getParameter("status");

		
		int reportId = Integer.parseInt(reportIdStr);

	
		Connection con = DBConnection.connect();

		try {
			PreparedStatement pst = con.prepareStatement("UPDATE child_report SET status = ? WHERE id = ?");
			pst.setString(1, status);
			pst.setInt(2, reportId);

			int rowsAffected = pst.executeUpdate();

			if (rowsAffected > 0) {
				response.sendRedirect("police_dashboard.jsp"); 
			} else {
				response.sendRedirect("error.html");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("error.html");
		}
	}
}
