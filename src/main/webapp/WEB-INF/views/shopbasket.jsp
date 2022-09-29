<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>ShopBasket</title>
</head>
<style>
    body {
        margin: 0;
    }

    * {
        box-sizing: border-box;
    }

    p,
    span {
        margin: 0;
    }

    a {
        color: black;
    }

    img {
        display: block;
        width: 80%;
        height: 80px;
        margin-left: 8%;
    }

    .cart {
        width: 80%;
        margin: auto;
        padding: 30px;
    }

    .cart ul {
        background-color: whitesmoke;
        padding: 30px;
        margin-bottom: 50px;
        border: whitesmoke solid 1px;
        border-radius: 5px;
        font-size: 13px;
        font-weight: 300;
    }

    .cart ul :first-child {
        color: limegreen;
    }

    table {
        border-top: solid 1.5px black;
        border-collapse: collapse;
        width: 100%;
        font-size: 14px;
    }

    thead {
        text-align: center;
        font-weight: bold;
    }

    tbody {
        font-size: 12px;
    }

    td {
        padding: 15px 0px;
        border-bottom: 1px solid lightgrey;
    }

    .cart__list__detail :nth-child(3) {
        /*vertical-align: top;*/
    }

    .cart__list__detail :nth-child(3) a {
        font-size: 12px;
    }

    .cart__list__detail :nth-child(3) p {
        margin-top: 6px;
        font-weight: bold;
    }

    .cart__list__smartstore {
        font-size: 12px;
        color: gray;
    }

    .cart__list__option {
        vertical-align: top;
        padding: 20px;
    }

    .cart__list__option p {
        margin-bottom: 25px;
        position: relative;
    }

    .cart__list__option p::after {
        content: "";
        width: 90%;
        height: 1px;
        background-color: lightgrey;
        left: 0px;
        top: 25px;
        position: absolute;
    }

    .cart__list__optionbtn {
        background-color: white;
        font-size: 12px;
        border: lightgrey solid 1px;
        padding: 7px;
    }

    .cart__list__detail :nth-child(4),
    .cart__list__detail :nth-child(5),
    .cart__list__detail :nth-child(6) {
        border-left: 2px solid whitesmoke;
    }

    .cart__list__detail :nth-child(5),
    .cart__list__detail :nth-child(6) {
        text-align: center;
    }

    .cart__list__detail :nth-child(5) button {
        background-color: #616eff;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 4px 8px;
        font-size: 12px;
        margin-top: 5px;
    }

    .price {
        font-weight: bold;
    }

    .cart__mainbtns {
        width: 420px;
        height: 200px;
        padding-top: 40px;
        display: block;
        margin: auto;
    }

    .cart__bigorderbtn {
        width: 200px;
        height: 50px;
        font-size: 16px;
        margin: auto;
        border-radius: 5px;
    }

    .cart__bigorderbtn.left {
        background-color: white;
        border: 1px lightgray solid;
    }

    .cart__bigorderbtn.right {
        background-color: #616eff;
        color: white;
        border: none;
    }
</style>

<body>
<section class="cart">
    <div class="cart__information" style="padding-top: 80px;">
    <h2 class="display-4 fw-bolder">장바구니</h2>
    </div>
    <table class="cart__list">
            <thead>
            <tr>
                <td><input type="checkbox"></td>
                <td colspan="2">상품정보</td>
                <td>옵션</td>
                <td>상품금액</td>
                <td>배송비</td>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty basketList}">
            <tr class="cart__list__detail">
                <td colspan="6" style="text-align: center">
                    장바구니 상품이 없습니다.
                </td>
            </tr>
            </c:if>
            <c:forEach var="list" varStatus="stauts" items="${basketList}">
            <tr class="cart__list__detail">
                <td><input type="checkbox" id="basketchek${stauts.index}" name="checkbasket" value="${list.ordId}"></td>
                <c:if test="${list.filePath == null}">
                <td style="width: 15%;"><img src="https://dummyimage.com/400x300/dee2e6/6c757d.jpg" style="width:8vw;" alt="이미지를 찾을 수 없습니다."></td>
                </c:if>
                <c:if test="${list.filePath != null}">
                <td style="width: 15%;"><img src="${list.filePath}" style="width:8vw;" alt="이미지를 찾을 수 없습니다."></td>
                </c:if>
                <td><a href="#">(주)애플 공식 브랜드스토어</a><span class="cart__list__smartstore"> 스마트스토어</span>
                    <p>${list.title}</p>
                    <sapn class="price"><fmt:formatNumber value="${list.price}" pattern="#,###"/>원</sapn>
                    <span style="text-decoration: line-through; color: lightgray;"><fmt:formatNumber value="${list.price}" pattern="#,###"/>원</span>
                </td>
                <td class="cart__list__option">
                    <p>모델명 : 기본 상품 / 1개 </p>
                    <button class="cart__list__optionbtn">주문조건 추가/변경</button>
                </td>
                <td><span class="price"><fmt:formatNumber value="${list.price}" pattern="#,###"/>원</span><br>
                    <button class="cart__list__orderbtn">주문하기</button>
                </td>
                <td>무료</td>
            </tr>
            </c:forEach>
            </tbody>
            <tfoot>
            <tr>
                <td colspan="3">
                    <input type="checkbox" id="checkboxall" onclick="checkboxAll()" style="margin-right: 10px">
                    <button class="cart__list__optionbtn" onclick="deletebasket()">선택상품 삭제</button>
                    <button class="cart__list__optionbtn">선택상품 찜</button>
                </td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            </tfoot>
    </table>
    <div class="cart__mainbtns">
        <button class="cart__bigorderbtn left" onclick="goList()">쇼핑 계속하기</button>
        <button class="cart__bigorderbtn right" onclick="goPay()">주문하기</button>
    </div>
</section>
</body>
<script type="text/javascript">

    /**
     * 결제 화면
     */
    function goPay() {
        const chk_val = [];

        $('input[name=checkbasket]:checked').each(function (){
            var chkdata = $(this).val();
            chk_val.push(chkdata);
        })
        if (chk_val == null || chk_val == "") {
            alert("상품을 선택해주세요");
            return;
        }

        if(chk_val.length != 0) {

            let url = "/shopping/pay.do?ordId=" + chk_val;
            location.href = url;
        }
    }

    /**
     * 목록 리턴
     */
    function goList() {
        location.href = "/shopping/list.do";
    }

    /**
     * 체크박스 전체
     */
    function checkboxAll() {
        if($('input:checkbox[id=checkboxall]').is(':checked') == true) {
            $('input[name=checkbasket]:checkbox').prop('checked', true);
        } else {
            $('input[name=checkbasket]:checkbox').prop('checked', false);
        }
    }

    /**
     * 선택상품 삭제
     */
    function deletebasket() {
        console.log("dd");
        const chk_val = [];

        $('input[name=checkbasket]:checked').each(function (){
            var num = $(this).val();
            num *= 1;
            chk_val.push(num);
        })
        console.log(chk_val);

        if(chk_val.length != 0) {

            let url = "/api/shopbasket/" + chk_val;
            console.log(url);

            $.ajax({
                type: "DELETE",
                contentType: 'application/json',
                url: url,
                async: false, //동기: false, 비동기(기본값): ture
                dataType: "json",
                success: function(response) {
                    console.log(response)
                    if (response == true) {
                        window.location.reload();
                    }
                }
            })
        }

    }
</script>
</html>