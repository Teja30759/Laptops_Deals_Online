<%@page import="java.sql.*" %>
<%
String brand=request.getParameter("brand");
String model=request.getParameter("model");

try
{
	Connection con = null;
	  Class.forName("com.mysql.cj.jdbc.Driver");
    System.out.println("Driver Class Loaded");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "root");
    System.out.println("Connection Established"); 
    PreparedStatement pstmt=con.prepareStatement("delete from laptops where brand=? and model=?");
  
    pstmt.setString(1, brand);
    pstmt.setString(2, model);
    int n=pstmt.executeUpdate();
    if(n>0)
    {
    	out.println("Deleted  Successfully");
    }
    else 
    {
    	out.println("Re-Enter The Details");
    }
	response.sendRedirect("deletedsuccessfully.html");
}
catch(Exception e)
{
	out.println(e);
}



%>