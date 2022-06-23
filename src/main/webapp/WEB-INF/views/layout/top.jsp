<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Shopping Mall</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="${path}/assets/favicon.ico?v=<%=System.currentTimeMillis() %>" />
    <link href="${path}/css/styles.css?v=<%=System.currentTimeMillis() %>" rel="stylesheet" />
    <link rel="stylesheet" href="${path}/plugin/mCustomScrollbar/jquery.mCustomScrollbar.min.css?v=<%=System.currentTimeMillis() %>">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <script src="${path}/js/scripts.js?v=<%=System.currentTimeMillis() %>"></script>
    <script src="${path}/scripts/moment.min.js?v=<%=System.currentTimeMillis() %>"></script>


</head>
<script type="text/javascript">

</script>
<body>

<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light bg-light" style="position: fixed; width: 100%;">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="#!">Shopping Mall</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link active" aria-current="page" href="#!">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#!">All Products</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Popular Items</a></li>
                        <li><a class="dropdown-item" href="#!">New Arrivals</a></li>
                    </ul>
                </li>
            </ul>
            <form class="d-flex">
                <c:if test="${user != null}">
                    <a class="btn btn-outline-dark">${user} ${role}님</a>
                    <a href="/logout" class="btn btn-outline-dark">로그아웃</a>
                </c:if>
                <c:if test="${user == null}">
                    <a href="/auth/login" class="btn btn-outline-dark">로그인</a>
                </c:if>
                <button class="btn btn-outline-dark" type="submit">
                    <i class="bi-cart-fill me-1"></i>
                    Cart
                    <span class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                </button>
            </form>
        </div>
    </div>
</nav>



</body>
</html>