<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="project.*"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Citizen Dashboard – ChildCare</title>

  <!-- Bootstrap & Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>

  <style>
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
      color: #c8e6c9;
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

    input, select, textarea {
      width: 100%;
      padding: 10px;
      margin: 10px 0;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 15px;
    }

    textarea {
      resize: vertical;
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
      background-color: #1b5e20;
    }

    table {
      width: 100%;
      border-collapse: collapse;
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

    .badge {
      font-size: 0.9rem;
      padding: 6px 12px;
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

  <!-- Top Navbar -->
  <nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
      <a class="navbar-brand" href="#">Citizen Panel</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navItems">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navItems">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('reportChild', this)">Report Missing Child</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('viewStatus', this)">View Status</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" onclick="showSection('changePassword', this)">Change Password</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="index.html">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <!-- Main Content -->
  <div class="main">

    <!-- Report Form -->
    <div id="reportChild" class="card active">
      <h3>Report Missing Child</h3>
      <form method="post" action="Addchildreport">
        <input type="text" name="childName" placeholder="Child Name" required />
        <input type="number" name="age" placeholder="Age" required />
        <input type="text" name="lastSeenLocation" placeholder="Last Seen Location" required />
        <input type="text" name="imagePath" placeholder="Image Path or URL" required />
        <input type="text" name="reportDate" required />

        <select name="status" required>
          <option value="Missing" selected>Missing</option>
          <option value="Work in Progress">Work in Progress</option>
          <option value="Found">Found</option>
          <option value="Not Found">Not Found</option>
        </select>

        <textarea name="description" placeholder="Other Description" rows="6" required></textarea>
        <button type="submit" class="submit-btn">Submit Report</button>
      </form>
    </div>

    <!-- View Status -->
    <div id="viewStatus" class="card">
      <h3>Status of Reported Cases</h3>
      <table>
        <thead>
          <tr>
            <th>Child Name</th>
            <th>Report Date</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <%
            Connection con = DBConnection.connect();
            int cid = GetSet.getCid();
            PreparedStatement st = con.prepareStatement("SELECT * FROM child_report WHERE cid = ?");
            st.setInt(1, cid);
            ResultSet rs = st.executeQuery();
            while(rs.next()) {
              String status = rs.getString("status");
              String badgeClass = "bg-secondary";
              if ("Found".equalsIgnoreCase(status)) {
                  badgeClass = "bg-success";
              } else if ("Not Found".equalsIgnoreCase(status)) {
                  badgeClass = "bg-danger";
              } else if ("Work in Progress".equalsIgnoreCase(status)) {
                  badgeClass = "bg-warning text-dark";
              } else if ("Missing".equalsIgnoreCase(status)) {
                  badgeClass = "bg-primary";
              }
          %>
            <tr>
              <td><%= rs.getString("childName") %></td>
              <td><%= rs.getString("reportDate") %></td>
              <td><span class="badge <%= badgeClass %>"><%= status %></span></td>
            </tr>
          <% } rs.close(); st.close(); con.close(); %>
        </tbody>
      </table>
    </div>

    <!-- Change Password -->
    <div id="changePassword" class="card">
      <h3>Change Password</h3>
      <form action="CitizenChangePass" method="post">
        <input type="password" name="password" placeholder="Old Password" required />
        <input type="password" name="newPassword" placeholder="New Password" required />
        <button type="submit" class="submit-btn">Update Password</button>
      </form>
    </div>

  </div>

  <!-- Script to Switch Sections -->
  <script>
    function showSection(sectionId, element) {
      document.querySelectorAll('.card').forEach(card => card.classList.remove('active'));
      document.getElementById(sectionId).classList.add('active');

      document.querySelectorAll('.nav-link').forEach(link => link.classList.remove('active'));
      if (element) element.classList.add('active');
    }

    window.addEventListener('DOMContentLoaded', function () {
      showSection('reportChild');
    });
  </script>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
