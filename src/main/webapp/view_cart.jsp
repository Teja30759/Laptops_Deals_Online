<%@ page import="java.util.List, java.sql.*, java.io.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .header h3 {
            margin: 0;
        }
        .header .home-btn {
            text-decoration: none;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
        }
        .cart-container {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            background-color: #f9f9f9;
        }
        .cart-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 10px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .cart-item img {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 10px;
        }
        .cart-item h4 {
            margin: 0;
        }
        .cart-item p {
            margin: 5px 0;
        }
        .cart-item .price {
            margin-top: 10px;
            font-weight: bold;
        }
        .cart-item .remove-btn {
            margin-left: auto;
            text-decoration: none;
            color: #FF5733;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="header">
        <h3>View Cart</h3>
        <a href="userhome.html" class="home-btn">Home</a>
    </div>

    <div class="cart-container">
    <%
        @SuppressWarnings("unchecked")
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        // Check if the cast was successful and the cart is not null
        if (cart == null || cart.isEmpty()) {
            out.println("<p>Your cart is empty.</p>");
        } else {
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "root");

                for (int productId : cart) {
                    pstmt = con.prepareStatement("SELECT * FROM laptops WHERE id = ?");
                    pstmt.setInt(1, productId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        String brand = rs.getString("brand");
                        String model = rs.getString("model");
                        String processor = rs.getString("processor");
                        int ram = rs.getInt("ram");
                        String storage = rs.getString("storage");
                        double displaySize = rs.getDouble("display_size");
                        double price = rs.getDouble("price");
                        String imageName = "p" + productId + ".jpeg"; // Assuming your image names are like p1.jpeg, p2.jpeg, etc.
                        String imagePath = "images/products/" + imageName;

    %>
                        <div class="cart-item">
                            <img src="<%= imagePath %>" alt="<%= brand %> <%= model %>" class="product-image">
                            <div>
                                <h4><%= brand %> <%= model %></h4>
                                <p><strong>Processor:</strong> <%= processor %></p>
                                <p><strong>RAM:</strong> <%= ram %> GB</p>
                                <p><strong>Storage:</strong> <%= storage %></p>
                                <p><strong>Display Size:</strong> <%= displaySize %> inches</p>
                                <p class="price">$<%= price %></p>
                                <a href="remove_from_cart.jsp?productId=<%= productId %>" class="remove-btn">Remove</a>
                            </div>
                        </div>
    <%
                    }
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    out.println("Error closing resources: " + e.getMessage());
                }
            }
        }
    %>
    </div>
</body>
</html>
