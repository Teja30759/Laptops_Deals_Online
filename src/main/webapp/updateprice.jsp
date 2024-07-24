<%@page import="java.sql.*" %>
<%
String brand=request.getParameter("brand");
String model=request.getParameter("model");
double price=Double.parseDouble(request.getParameter("price"));
try
{
	Connection con = null;
	  Class.forName("com.mysql.cj.jdbc.Driver");
    System.out.println("Driver Class Loaded");
    con=DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "root");
    System.out.println("Connection Established"); 
    PreparedStatement pstmt=con.prepareStatement("update laptops set price=? where brand=? and model=?");
    pstmt.setDouble(1, price);
    pstmt.setString(2, brand);
    pstmt.setString(3, model);
    int n=pstmt.executeUpdate();
    if(n>0)
    {
    	out.println("Price updated Successfully");
    }
    else 
    {
    	out.println("Re-Enter The Details");
    }
	response.sendRedirect("updatedsuccessfully.html");
}
catch(Exception e)
{
	out.println(e);
}



%>