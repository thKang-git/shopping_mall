<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>Error page</title>
</head>
<body>

<div class="container">
    <h2>${role}</h2>
    <h4>${user}</h4>
    <h4>${exception}</h4>
    <h4>권한이 없습니다.</h4>
</div>

</body>