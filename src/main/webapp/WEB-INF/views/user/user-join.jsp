<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>Main page</title>
</head>
<body>
<div id="posts_list">
    <div class="container col-md-8">

        <form action="/auth/joinProcapi" method="post">
            <div class="form-group">
                <label>아이디</label>
                <input type="text" name="userid" class="form-control" placeholder="아이디를 입력해주세요">
            </div>

            <div class="form-group">
                <label>비밀번호</label>
                <input type="password" name="password" class="form-control" placeholder="비밀번호를 입력해주세요">
            </div>

            <div class="form-group">
                <label>닉네임</label>
                <input type="text" name="username" class="form-control" placeholder="닉네임을 입력해주세요">
            </div>

            <div class="form-group">
                <label>이메일</label>
                <input type="email" name="email" class="form-control" placeholder="이메일을 입력해주세요">
            </div>

            <button class="btn btn-primary bi bi-person"> 가입</button>
        </form>
    </div>
</div>
</body>
</html>