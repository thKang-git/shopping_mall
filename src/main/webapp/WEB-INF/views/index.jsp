<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>Index page</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${path}/bootstrap/js/bootstrap.js?v=<%=System.currentTimeMillis() %>"></script>
    <script type="text/javascript" src="${path}/shopping/shoplist.js?v=<%=System.currentTimeMillis() %>"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

</head>
<script type="text/javascript">

</script>
<body>

<nav class="navbar" style="background-color: darkslategray">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="#">DashBoard</a>
    </div>
</nav>

<div class="container">
    Index page
</div>

<!-- wrapper -->
<div class="wrapper">
    <h1>Bike Stock</h1>
    <span><i class="shopping-cart"></i></span>

    <div class="clear"></div>
    <!-- items -->
    <div class="itemss">
        <!-- single item -->
        <div class="item">
            <img src="http://img.tjskl.org.cn/pic/z2577d9d-200x200-1/pinarello_lungavita_2010_single_speed_bike.jpg" alt="item" />
            <h2>Item 1</h2>

            <p>Price: <em>$449</em>
            </p>
            <button class="add-to-cart" onclick="shop()" type="button">Add to cart</button>
        </div>
        <!--/ single item -->
        <!-- single item -->
        <div class="item">
            <img src="http://img.tjskl.org.cn/pic/z2577d9d-200x200-1/pinarello_lungavita_2010_single_speed_bike.jpg" alt="item" />
            <h2>Item 1</h2>

            <p>Price: <em>$449</em>
            </p>
            <button class="add-to-cart" onclick="shop()" type="button">Add to cart</button>
        </div>
        <!--/ single item -->
        <!-- single item -->
        <div class="item">
            <img src="http://img1.exportersindia.com/product_images/bc-small/dir_55/1620613/cannondale-jekyll-1-2011-mountain-bike-309779.jpg" alt="item" />
            <h2>Item 1</h2>

            <p>Price: <em>$449</em>
            </p>
            <button class="add-to-cart" onclick="shop()" type="button">Add to cart</button>
        </div>
        <!--/ single item -->
    </div>
    <!--/ items -->
</div>
<!--/ wrapper -->

</body>
</html>