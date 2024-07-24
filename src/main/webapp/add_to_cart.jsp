<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%@ page session="true" %>
<%
    // Get the product ID from the request
    int productId = Integer.parseInt(request.getParameter("productId"));

    // Retrieve the cart from session or create a new one if it doesn't exist
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }

    // Add the product ID to the cart
    cart.add(productId);
    session.setAttribute("cart", cart);

    // Redirect to the View Cart page
    response.sendRedirect("view_cart.jsp");
%>
