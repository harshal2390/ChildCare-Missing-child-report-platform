<%@ page import="java.sql.*" %>
<%@ page import="project.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String idParam = request.getParameter("id");

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);

            Connection con = DBConnection.connect();
            PreparedStatement ps = con.prepareStatement("DELETE FROM police WHERE pid = ?");
            ps.setInt(1, id);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            if (result > 0) {
                response.sendRedirect("AdminDashboard.jsp?message=Police+record+deleted+successfully");
            } else {
                response.sendRedirect("AdminDashboard.jsp?error=Police+record+not+found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboard.jsp?error=Error+occurred+while+deleting");
        }
    } else {
        response.sendRedirect("AdminDashboard.jsp?error=Missing+Police+ID");
    }
%>
