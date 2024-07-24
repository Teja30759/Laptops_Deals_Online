<%@ page import="java.util.List, java.util.ArrayList, java.sql.*, java.io.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Remove from Cart</title>
    <style>
        /* Your existing CSS */
    </style>
</head>
<body>
    <h3>Remove from Cart</h3>
    <%
        // Get the product ID to remove from the request
        int productIdToRemove = Integer.parseInt(request.getParameter("productId"));

        // Retrieve the cart from session
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");
        
        if (cart != null) {
            // Remove the product ID from the cart
            cart.remove(Integer.valueOf(productIdToRemove)); // Remove using Integer.valueOf() to ensure object removal
            
            // Update the session attribute
            session.setAttribute("cart", cart);
        }

        // Redirect back to view_cart.jsp after removal
        response.sendRedirect("view_cart.jsp");
    %>
</body>
</html>
