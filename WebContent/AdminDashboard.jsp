<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="project.*" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard – ChildCare</title>

  <!-- Bootstrap + Icons + Google Fonts -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet"/>

  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background: linear-gradient(135deg, #f5f8fa, #e0f2f1);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .navbar {
      background-color: #1565c0;
      padding: 15px 30px;
      color: white;
      display: flex;
      align-items: center;
      justify-content: space-between;
      flex-wrap: wrap;
    }

    .navbar .nav-buttons button {
      background: none;
      border: none;
      color: white;
      font-size: 16px;
      margin-right: 20px;
      transition: 0.3s;
    }

    .navbar .nav-buttons button:hover,
    .navbar .nav-buttons button.active {
      border-bottom: 2px solid white;
    }

    .logout-btn {
      background-color: #c62828;
      border: none;
      padding: 8px 15px;
      border-radius: 6px;
      color: white;
      font-weight: 600;
    }

    .main {
      padding: 30px;
      flex: 1;
    }

    .card {
      background-color: white;
      padding: 25px;
      border-radius: 16px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
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

    table {
      width: 100%;
      border-collapse: collapse;
      font-size: 15px;
      background-color: #fff;
    }

    th, td {
      padding: 12px;
      text-align: center;
      border-bottom: 1px solid #e0e0e0;
    }

    th {
      background-color: #1565c0;
      color: white;
    }

    .btn-sm {
      font-size: 0.85rem;
    }

    .add-btn {
      margin-top: 15px;
      display: inline-block;
      background-color: #1565c0;
      color: white;
      padding: 10px 20px;
      border-radius: 8px;
      text-decoration: none;
      font-weight: bold;
    }

    .add-btn:hover {
      background-color: #0d47a1;
    }

    .badge-status {
      padding: 4px 10px;
      border-radius: 8px;
      font-weight: 500;
      display: inline-block;
    }

    @media (max-width: 768px) {
      .navbar {
        flex-direction: column;
        align-items: flex-start;
      }

      .navbar .nav-buttons {
        width: 100%;
        margin-top: 10px;
      }

      .navbar .nav-buttons button {
        margin: 5px 0;
      }

      table, thead, tbody, th, td, tr {
        display: block;
      }

      th {
        text-align: left;
      }

      td {
        text-align: left;
        padding-left: 50%;
        position: relative;
      }

      td::before {
        position: absolute;
        top: 12px;
        left: 12px;
        width: 45%;
        white-space: nowrap;
        font-weight: bold;
      }
    }
  </style>
</head>

<body>

  <!-- Navigation Bar -->
  <div class="navbar">
    <div><strong>Admin Panel</strong></div>
    <div class="nav-buttons">
      <button onclick="showSection('managePolice')" class="active"><i class="bi bi-shield-lock"></i> Police</button>
      <button onclick="showSection('viewCitizens')"><i class="bi bi-people"></i> Citizens</button>
      <button onclick="showSection('viewReports')"><i class="bi bi-clipboard-data"></i> Reports</button>
      <button class="logout-btn" onclick="location.href='index.html'"><i class="bi bi-box-arrow-right"></i> Logout</button>
    </div>
  </div>

  <!-- Main Dashboard Content -->
  <div class="main">

    <!-- Police Officers -->
    <div id="managePolice" class="card active">
      <h3>Manage Police Officers</h3>
      <table>
        <thead>
          <tr>
            <th>PID</th><th>Name</th><th>Station</th><th>Contact</th><th>Email</th><th>Action</th>
          </tr>
        </thead>
        <tbody>
          <%
            Connection con1 = DBConnection.connect();
            PreparedStatement ps1 = con1.prepareStatement("SELECT * FROM police");
            ResultSet rs1 = ps1.executeQuery();
            while(rs1.next()) {
          %>
          <tr>
            <td><%= rs1.getInt("pid") %></td>
            <td><%= rs1.getString("name") %></td>
            <td><%= rs1.getString("station") %></td>
            <td><%= rs1.getString("contact") %></td>
            <td><%= rs1.getString("email") %></td>
            <td>
              <a href="deletePolice.jsp?id=<%= rs1.getInt("pid") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this officer?');">Delete</a>
            </td>
          </tr>
          <% } rs1.close(); ps1.close(); con1.close(); %>
        </tbody>
      </table>
      <a href="addPolice.html" class="add-btn">+ Add Police</a>
    </div>

    <!-- Citizens -->
    <div id="viewCitizens" class="card">
      <h3>All Citizens</h3>
      <table>
        <thead>
          <tr><th>CID</th><th>Name</th><th>Contact</th><th>Address</th><th>Email</th></tr>
        </thead>
        <tbody>
          <%
            Connection con2 = DBConnection.connect();
            PreparedStatement ps2 = con2.prepareStatement("SELECT * FROM citizen");
            ResultSet rs2 = ps2.executeQuery();
            while(rs2.next()) {
          %>
          <tr>
            <td><%= rs2.getInt("cid") %></td>
            <td><%= rs2.getString("name") %></td>
            <td><%= rs2.getString("contact") %></td>
            <td><%= rs2.getString("address") %></td>
            <td><%= rs2.getString("email") %></td>
          </tr>
          <% } rs2.close(); ps2.close(); con2.close(); %>
        </tbody>
      </table>
    </div>

    <!-- Reports -->
    <div id="viewReports" class="card">
      <h3>All Child Reports</h3>
      <table>
        <thead>
          <tr>
            <th>ID</th><th>Child Name</th><th>Age</th><th>Location</th><th>Date</th><th>Status</th><th>Image</th>
          </tr>
        </thead>
        <tbody>
          <%
            Connection con3 = DBConnection.connect();
            PreparedStatement ps3 = con3.prepareStatement("SELECT * FROM child_report");
            ResultSet rs3 = ps3.executeQuery();
            while(rs3.next()) {
              String status = rs3.getString("status");
              String badgeColor = "background-color: #6c757d; color: white;";
              if ("Found".equalsIgnoreCase(status)) badgeColor = "background-color: #28a745; color: white;";
              else if ("Not Found".equalsIgnoreCase(status)) badgeColor = "background-color: #dc3545; color: white;";
              else if ("Work in Progress".equalsIgnoreCase(status)) badgeColor = "background-color: #ffc107; color: black;";
              String imagePath = rs3.getString("imagePath");
          %>
          <tr>
            <td><%= rs3.getInt("id") %></td>
            <td><%= rs3.getString("childName") %></td>
            <td><%= rs3.getInt("age") %></td>
            <td><%= rs3.getString("lastSeenLocation") %></td>
            <td><%= rs3.getString("reportDate") %></td>
            <td><span class="badge-status" style="<%= badgeColor %>"><%= status %></span></td>
            <td>
              <% if(imagePath != null && !imagePath.trim().isEmpty()) { %>
                <a href="<%= imagePath %>" target="_blank" class="btn btn-outline-primary btn-sm">View Image</a>
              <% } else { %>
                <span class="text-muted">No Image</span>
              <% } %>
            </td>
          </tr>
          <% } rs3.close(); ps3.close(); con3.close(); %>
        </tbody>
      </table>
    </div>

  </div>

  <!-- JS: Toggle Cards -->
  <script>
    function showSection(sectionId) {
      var cards = document.querySelectorAll('.card');
      for (var i = 0; i < cards.length; i++) {
        cards[i].classList.remove('active');
      }

      var selectedCard = document.getElementById(sectionId);
      if (selectedCard) {
        selectedCard.classList.add('active');
      }

      var buttons = document.querySelectorAll('.nav-buttons button');
      for (var j = 0; j < buttons.length; j++) {
        buttons[j].classList.remove('active');
      }

      if (event && event.target) {
        event.target.classList.add('active');
      }
    }

    window.addEventListener('DOMContentLoaded', function () {
      showSection('managePolice');
    });
  </script>

</body>
</html>
