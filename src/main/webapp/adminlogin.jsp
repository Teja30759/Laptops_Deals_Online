<%@ page import="java.sql.*"%>
<%

String email = request.getParameter("email");
String pwd  = request.getParameter("password");

try
{
	Connection con = null;
	Class.forName("com.mysql.cj.jdbc.Driver");
    System.out.println("Driver Class Loaded");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "root");
    System.out.println("Connection Established");
    
    String qry = "select * from admins where email=? and password=? ";
    PreparedStatement pstmt = con.prepareStatement(qry);
    pstmt.setString(1, email);
    pstmt.setString(2, pwd);
    ResultSet rs = pstmt.executeQuery();
    if(rs.next())
    {
    	out.println("login success");
    	
    	
    	
    	response.sendRedirect("index.html");
    }
    else
    {
    	out.println("login failed");
    	response.sendRedirect("loginfail.html");
    }
}
catch(Exception e)
{
   out.println(e);	
}
%>

