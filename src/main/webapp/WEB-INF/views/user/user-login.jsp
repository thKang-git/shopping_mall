<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>로그인 / 회원가입</title>
</head>
<style>
    * {
        margin: 0;
        padding: 0;
        font-family: sans-serif;
    }
    .wrap {
        height: 100%;
        width: 100%;
        /*background-image: url(img/background.jpg);*/
        background-position: center;
        background-size: cover;
        position: absolute;
    }
    .form-wrap {
        width: 380px;
        height: 480px;
        position: relative;
        margin: 6% auto;
        background: #fff;
        padding: 5px;
        overflow: hidden;
        box-shadow: 0 5px 18px -7px rgba(0,0,0,1);
    }
    .button-wrap {
        width: 230px;
        margin: 35px auto;
        position: relative;
        /*box-shadow: 0 0 600px 9px #fcae8f;*/
        border-radius: 30px;
    }
    .togglebtn {
        padding: 10px 30px;
        cursor: pointer;
        background: transparent;
        border: 0;
        outline: none;
        position: relative;
    }
    #btn {
        top: 0;
        left: 0;
        position: absolute;
        width: 110px;
        height: 100%;
        background: #ac7dff;
        border-radius: 30px;
        transition: .5s;
    }
    .social-icons {
        margin: 30px auto;
        text-align: center;
    }
    .social-icons img {
        width: 70px ;
        cursor: pointer;
    }
    .input-group {
        top: 190px;
        position: absolute;
        width: 280px;
        transition: .5s;
    }
    .input-field {
        width: 100%;
        padding: 10px 0;
        margin: 5px 0;
        border: none;
        border-bottom: 1px solid #999;
        outline: none;
        background: transparent;
    }
    .submit {
        width: 85%;
        padding: 10px 30px;
        cursor: pointer;
        display: block;
        margin: auto;
        background: #ac7dff;
        border: 0;
        outline: none;
        border-radius: 30px;
        margin-top: 30px;
    }
    .checkbox {
        margin: 30px 10px 30px 0;
    }
    span {
        color: #777;
        font-size: 12px;
        bottom: 68px;
        position: absolute;
    }
    #login {
        left: 50px;
    }
    #register {
        left: 450px;
    }
    .rounded {
        border-radius: 1rem !important;
    }
</style>
<body>
<div class="wrap">
    <div class="form-wrap rounded">
        <div class="button-wrap">
            <div id="btn"></div>
            <button type="button" class="togglebtn" onclick="login()">LOG IN</button>
            <button type="button" class="togglebtn" onclick="register()">REGISTER</button>
        </div>
        <div class="social-icons">
            <!-- <img src="${path}/assets/fb.png" alt="facebook"> -->
            <img src="https://objectstorage.ap-chuncheon-1.oraclecloud.com/p/po02NYzz2D8gThPJVBtnwNB6-XTnFggeKOfFtFdZgba-BO4HRPH77R-wAk9DpMfO/n/axmznzthugde/b/NETUAD_BUCKET1/o/study-shopping%2Fpngegg.png">
        </div>

        <form id="login" action="/loginProc" method="post" class="input-group">
            <input type="text" name="username" class="input-field" placeholder="User ID" required>
            <input type="password" name="password" class="input-field" placeholder="Enter Password" required>
            <!-- <%--            <input type="checkbox" class="checkbox"><span>Remember Password</span>--%> -->
            <button class="submit">Login</button>
        </form>
        <form id="register" action="/auth/joinProcapi" method="post" class="input-group">
            <input type="text" name="userid" class="input-field" placeholder="User ID" required>
            <input type="password" name="password" class="input-field" placeholder="Enter Password" required>
            <input type="text" name="username" class="input-field" placeholder="Your Name" required>
            <input type="email" name="email" class="input-field" placeholder="Your Email" required>
            <button class="submit">REGISTER</button>
        </form>
    </div>
</div>
<script>
    var x = document.getElementById("login");
    var y = document.getElementById("register");
    var z = document.getElementById("btn");


    function login(){
        x.style.left = "50px";
        y.style.left = "450px";
        z.style.left = "0";
    }

    function register(){
        x.style.left = "-400px";
        y.style.left = "50px";
        z.style.left = "110px";
    }
</script>
</body>
</html>