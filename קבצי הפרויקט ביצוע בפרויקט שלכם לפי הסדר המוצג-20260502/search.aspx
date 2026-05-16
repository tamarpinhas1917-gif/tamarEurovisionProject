<%@ Page Language="C#" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" Debug="true" ResponseEncoding = "utf-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>Untitled Page</title>
    <link rel="stylesheet" type="text/css" href="StyleSheet.css" />
    <style>
body {
  margin-left: 30px;
  margin-right:30px;
  font-family: Forte;
  font-size:15px;
}

.topnav {
  overflow: hidden;
  background-color: #990066;
}

.topnav a {
  float: right;
  color:white;
  text-align: center;
  padding: 12px 14px;
  text-decoration: none;
  font-size: 15px;
}

.topnav a:hover {
  background-color: #ddd;
  color: black;
}

.topnav a.active {
  background-color:#CC6699;
  color: white;
}
</style>
    
</head>
<body dir="rtl">
     <p style ="font-size:65px; margin-top:1px; font-family:Forte; color:#990066; text-align:center">Daya's Cakes</p>    
<div class="topnav">
  <a class="active" href="homePage.aspx">דף הבית</a>
  <a href="#about">אודות המעצבת</a>
  <a href="Gallery.aspx">גלריה</a> 
  <a href="orders.aspx">טופס הזמנה</a>
  <a href="contact.aspx">צור קשר</a>
</div>
    <br /><br />
<center>
    <h1>כל הרשומים</h1>
    <form method="post" action="search.aspx" >
      <input type="submit"  name="printAll" value="כל הרשומים" />
    </form>
   
    <h1>חיפוש לפי שם פרטי</h1>
    <form action="search.aspx" method="post">
        <input type="text" id="fname" name="fname" />
        <input type="submit"  name="submit_fname" value="חפש" />
    </form>
    <br />
    
    <h1>חיפוש לפי אזור מגורים</h1>
    <form action="search.aspx" method="post">
    <select name="area">
        <option value="מרכז">מרכז</option>
        <option value="צפון">צפון</option>
        <option value="דרום">דרום</option>
    </select>
    <input type="submit" name="submit_area" value="חפש" />
    </form>
    <br />
 
    <%=usersList %>
</center>
</body>
</html>
