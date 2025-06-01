<%-- 
    Document   : header
    Created on : Jun 1, 2025, 12:55:28 AM
    Author     : UwAngelique
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<header class="main-header">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <div class="logo">EventCountdown</div>
   
    <nav class="main-nav" style="margin-left:900px">
        <ul>
            <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/list-events">My Events</a></li>
            <li><a href="${pageContext.request.contextPath}/add-event.jsp">Add Event</a></li>
            <li><a href="${pageContext.request.contextPath}/past-events.jsp">Past Events</a></li>
            <li><a href="${pageContext.request.contextPath}/logout.jsp">Logout</a></li>
        </ul>
    </nav>
         <div>
        <button class="toggle-btn" onclick="toggleDarkMode()">
        <i class="fa-solid fa-moon"></i>
        </button>
    </div>
  
</header>

