<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="page3.aspx.cs" Inherits="tamarProject.page3" %>

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
  <a href="about.aspx">About</a>
  <a href="page1.aspx">Page 1</a>
 <a href="page2.aspx">Page 2</a>
 <a href="page3.aspx">Page 3</a>
 <a href="signUp.aspx">Sign Up</a>
 <a href="logIn.aspx">Log In</a>
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
   <h1>Page 3</h1>
</body>
</html>
