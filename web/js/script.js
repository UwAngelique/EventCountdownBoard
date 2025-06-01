/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function toggleDarkMode() {
    const body = document.body;
    body.classList.toggle('dark-mode');

    // Update icon
    const icon = document.querySelector('.toggle-btn i');
    if (body.classList.contains('dark-mode')) {
        icon.classList.remove('fa-moon');
        icon.classList.add('fa-sun');
    } else {
        icon.classList.remove('fa-sun');
        icon.classList.add('fa-moon');
    }

    localStorage.setItem('theme', body.classList.contains('dark-mode') ? 'dark' : 'light');
}

// ku  Loadinga saved theme
window.onload = () => {
    const saved = localStorage.getItem('theme');
    if (saved === 'dark') {
        document.body.classList.add('dark-mode');
        document.querySelector('.toggle-btn i').classList.replace('fa-moon', 'fa-sun');
    }
};
//pagination ya table
  $(document).ready(function() {
    $('#eventsTable').DataTable({
      pageLength: 10,          
      lengthMenu: [5, 10, 25, 50], 
      ordering: true,         
      searching: true        
    });
  });