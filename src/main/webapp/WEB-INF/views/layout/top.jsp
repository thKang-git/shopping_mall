<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Shopping Mall page</title>

    <link rel="stylesheet" href="${path}/css/style.css?v=<%=System.currentTimeMillis() %>" type="text/css">
    <link rel="stylesheet" href="${path}/plugin/mCustomScrollbar/jquery.mCustomScrollbar.min.css?v=<%=System.currentTimeMillis() %>">
    <script type="text/javascript" src="${path}/shopping/shoplist.js?v=<%=System.currentTimeMillis() %>"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

</head>
<script type="text/javascript">

</script>
<body>

<nav class="navbar" style="background-color: darkslategray">
    <div class="container-fluid">
        <a class="navbar-brand text-white" href="#">Shopping Mall</a>
    </div>
</nav>



</body>
</html>