
<%@page import="java.sql.*" %>
<%
String brand=request.getParameter("brand");
String model=request.getParameter("model");
String processor=request.getParameter("processor");
int ram=Integer.parseInt(request.getParameter("ram"));
String storage=request.getParameter("storage");
double displaysize=Double.parseDouble(request.getParameter("display_size"));


double pricce=Double.parseDouble(request.getParameter("price"));
try
{
	  Connection con = null;
	  Class.forName("com.mysql.cj.jdbc.Driver");
      System.out.println("Driver Class Loaded");
      con=DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "root");
      System.out.println("Connection Established"); 
      
      PreparedStatement pstmt = con.prepareStatement("insert into laptops(brand,model,processor,ram,storage,display_size,price) values(?,?,?,?,?,?,?)");
      pstmt.setString(1, brand);
      pstmt.setString(2, model);
      pstmt.setString(3, processor);
      pstmt.setInt(4, ram);
      pstmt.setString(5, storage);
      pstmt.setDouble(6, displaysize);
      pstmt.setDouble(7, pricce);
      pstmt.executeUpdate();
      
      response.sendRedirect("addsuccess.html"); //response is implicit object
}
catch(Exception e)
{
	out.println(e);
}
%>