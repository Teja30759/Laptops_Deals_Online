<%@page import="java.sql.*" %>
<%
String email = request.getParameter("email");
String pwd = request.getParameter("password");

%>

<%
try
{
  Connection con = null;
  System.out.println("Driver class loaded");
  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "root");
  System.out.println("connection Established");
  String sql = "INSERT INTO users (email, password) VALUES (?, ?)";
  PreparedStatement pstmt = con.prepareStatement(sql);

  pstmt.setString(1, email);
  pstmt.setString(2, pwd);
  
  
  pstmt.executeUpdate();
  
  response.sendRedirect("userlogin.html");//response is implicite object
  
}
catch(Exception e)
{
  //out is implicit object
  out.println(e);
}

%>