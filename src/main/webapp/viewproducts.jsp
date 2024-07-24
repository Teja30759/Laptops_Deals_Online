<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Laptops</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Your existing CSS for product-card, product-image, etc. */
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .header {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin-bottom: 20px;
        }
        .header .home-btn {
            text-decoration: none;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
        }
        .header h3 {
            margin: 0;
            flex: 1;
            text-align: center;
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .product-card {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 10px;
            width: 300px; /* Adjust width as per your design */
            margin: 10px;
            text-align: center;
        }
        .product-image {
            width: 100%;
            max-height: 200px; /* Adjust height as per your design */
            object-fit: cover; /* Ensure images maintain aspect ratio */
            border-radius: 8px;
        }
        .product-title {
            margin-top: 10px;
            font-size: 18px;
        }
        .product-info {
            margin-top: 5px;
            font-size: 14px;
        }
        .product-price {
            margin-top: 10px;
            font-size: 20px;
            color: #007bff; /* Adjust color as per your design */
            font-weight: bold;
        }
        .add-to-cart {
            display: block;
            margin-top: 10px;
            background-color: #007bff;
            color: #fff;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .add-to-cart:hover {
            background-color: #0056b3; /* Darker shade on hover */
        }
    </style>
</head>
<body>
    <div class="header">
        <a href="userhome.html" class="home-btn">Home</a>
        <h3>View Laptops</h3>
    </div>

    <div class="product-container">
    <% 
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/products", "root", "root");

        pstmt = con.prepareStatement("SELECT * FROM laptops");
        rs = pstmt.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            String brand = rs.getString("brand");
            String model = rs.getString("model");
            String processor = rs.getString("processor");
            int ram = rs.getInt("ram");
            String storage = rs.getString("storage");
            double displaySize = rs.getDouble("display_size");
            double price = rs.getDouble("price");
            String imageName = "p" + id + ".jpeg"; // Assuming your image names are like p1.jpeg, p2.jpeg, etc.

            // Path to the images folder in your webapp directory
            String imagePath = "images/products/" + imageName;
    %>
        <div class="product-card">
            <img src="<%= imagePath %>" alt="<%= brand %> <%= model %>" class="product-image"> <!-- Adjust class as per your CSS -->
            <h4 class="product-title"><%= brand %> <%= model %></h4>
            <div class="product-info"><strong>Processor:</strong> <%= processor %></div>
            <div class="product-info"><strong>RAM:</strong> <%= ram %> GB</div>
            <div class="product-info"><strong>Storage:</strong> <%= storage %></div>
            <div class="product-info"><strong>Display Size:</strong> <%= displaySize %> inches</div>
            <div class="product-price">$<%= price %></div>
            <a href="add_to_cart.jsp?productId=<%= id %>" class="add-to-cart">
                <i class="fas fa-cart-plus"></i> Add to Cart
            </a>
        </div>
    <% 
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
    %>
    </div>
</body>
</html>
