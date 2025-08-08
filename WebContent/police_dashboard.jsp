<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="project.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Police Dashboard – ChildCare</title>

  <!-- Bootstrap & Fonts -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

  <style>
    * { box-sizing: border-box; }
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #f0f2f5, #e0eafc);
      min-height: 100vh;
    }

    nav.navbar {
      background-color: #1565c0;
      padding: 0.75rem 1.5rem;
    }

    .navbar-brand {
      color: #fff;
      font-weight: 600;
      font-size: 1.5rem;
    }

    .navbar-nav .nav-link {
      color: white;
      margin: 0 10px;
      font-weight: 500;
      transition: 0.3s;
    }

    .navbar-nav .nav-link:hover,
    .navbar-nav .nav-link.active {
      color: #bbdefb;
    }

    .main {
      padding: 30px;
    }

    .card {
      background-color: white;
      padding: 25px;
      border-radius: 16px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
      display: none;
    }

    .card.active {
      display: block;
    }

    h3 {
      color: #1565c0;
      margin-bottom: 20px;
      font-weight: 600;
    }

    input, select {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 15px;
    }

    button.submit-btn {
      background-color: #1565c0;
      color: white;
      padding: 12px 20px;
      border: none;
      border-radius: 8px;
      font-weight: bold;
      transition: 0.3s;
    }

    button.submit-btn:hover {
      background-color: #0d47a1;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #ddd;
    }

    th {
      background-color: #1565c0;
      color: white;
    }

    .btn-outline-primary {
      padding: 4px 12px;
      font-size: 0.875rem;
      border-radius: 20px;
    }

    @media (max-width: 768px) {
      .navbar-nav {
        flex-direction: column;
        align-items: flex-start;
      }

      .navbar-nav .nav-link {
        margin: 5px 0;
      }
    }
  </style>
</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Police Panel</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <a class="nav-link active" href="#" onclick="showSection('updateStatus', this)">Update Investigation</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('viewReports', this)">View Reports</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('changePassword', this)">Change Password</a>
          </li>
          <li class="nav-item">
            <a class="nav-link text-danger" href="index.html">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="main">
    <!-- Update Investigation Section -->
    <div id="updateStatus" class="card active">
      <h3>Update Investigation Status</h3>
      <form action="UpdateInvestigation" method="post">
        <input type="text" name="reportId" placeholder="Report ID" required />
        <select name="status" required>
          <option value="Work in Progress">Work in Progress</option>
          <option value="Found">Found</option>
          <option value="Not Found">Not Found</option>
        </select>
        <button type="submit" class="submit-btn">Update</button>
      </form>
    </div>

    <!-- View All Child Reports -->
    <div id="viewReports" class="card">
      <h3>All Child Reports</h3>
      <table>
        <thead>
          <tr>
            <th>Report ID</th>
            <th>Child Name</th>
            <th>Age</th>
            <th>Location</th>
            <th>Status</th>
            <th>Image</th>
          </tr>
        </thead>
        <tbody>
          <%
            Connection con = DBConnection.connect();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM child_report");
            while(rs.next()) {
              String imagePath = rs.getString("imagePath");
          %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("childName") %></td>
            <td><%= rs.getString("age") %></td>
            <td><%= rs.getString("lastSeenLocation") %></td>
            <td>
              <%
                String status = rs.getString("status");
                String badgeClass = "bg-secondary";
                if ("Found".equalsIgnoreCase(status)) badgeClass = "bg-success";
                else if ("Not Found".equalsIgnoreCase(status)) badgeClass = "bg-danger";
                else if ("Work in Progress".equalsIgnoreCase(status)) badgeClass = "bg-warning text-dark";
              %>
              <span class="badge <%= badgeClass %>"><%= status %></span>
            </td>
            <td>
              <% if(imagePath != null && !imagePath.trim().isEmpty()) { %>
                <a href="<%= imagePath %>" target="_blank" class="btn btn-sm btn-outline-primary">View Image</a>
              <% } else { %>
                <span class="text-muted">No Image</span>
              <% } %>
            </td>
          </tr>
          <% } rs.close(); st.close(); con.close(); %>
        </tbody>
      </table>
    </div>

    <!-- Change Password Section -->
    <div id="changePassword" class="card">
      <h3>Change Password</h3>
      <form action="PoliceChangePass" method="post">
        <input type="password" name="password" placeholder="Old Password" required />
        <input type="password" name="newpass" placeholder="New Password" required />
        <button type="submit" class="submit-btn">Change Password</button>
      </form>
    </div>
  </div>

  <!-- Scripts -->
  <script>
    function showSection(sectionId, element) {
      var cards = document.querySelectorAll('.card');
      for (var i = 0; i < cards.length; i++) {
        cards[i].classList.remove('active');
      }
      document.getElementById(sectionId).classList.add('active');

      var navLinks = document.querySelectorAll('.nav-link');
      for (var i = 0; i < navLinks.length; i++) {
        navLinks[i].classList.remove('active');
      }

      if (element) {
        element.classList.add('active');
      }
    }

    window.addEventListener('DOMContentLoaded', function () {
      showSection('updateStatus', document.querySelector('.nav-link.active'));
    });
  </script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
