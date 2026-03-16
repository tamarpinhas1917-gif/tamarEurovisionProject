<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signUp.aspx.cs" Inherits="tamarProject.signUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link rel="stylesheet" type="text/css" href="StyleMenu.css" />
</head>
<body>
    <div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <a href="homePage.aspx">Home Page</a>
  <a href="timeline.aspx">Timeline</a>
  <a href="fashion.aspx">Fashion</a>
  <a href="data-manager.aspx">Data Manager</a>
  <a href="gallery.aspx">Gallery</a>
  <a href="trivia.aspx">Trivia</a>
  <a href="signUp.aspx">Sign Up</a>
  <a href="login.aspx">Log In</a>
</div>


<span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; </span>

<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
   <h1>Sign Up</h1>
</body>
</html>
