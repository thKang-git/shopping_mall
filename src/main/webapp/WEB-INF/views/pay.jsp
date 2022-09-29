<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <title>결제하기</title>
    <script src="https://js.tosspayments.com/v1"></script>
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
        <h2 class="display-4 fw-bolder">결제하기</h2>
    </div>
    <table class="cart__list">
        <thead>
        <tr>
            <td></td>
            <td colspan="2">상품정보</td>
            <td>옵션</td>
            <td>상품금액</td>
            <td>배송비</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="list" varStatus="stauts" items="${Paylist}">
            <tr class="cart__list__detail">
                <td></td>
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
                <td style="text-align: center">
                    <p>모델명 : 기본 상품 / 1개 </p>
                </td>
                <td><span class="price"><fmt:formatNumber value="${list.price}" pattern="#,###"/>원</span>
                </td>
                <td>무료</td>
            </tr>
        </c:forEach>
        </tbody>
        <tfoot>
        <tr style="text-align: center">
            <td colspan="6" id="payresults">
            </td>
        </tr>
        </tfoot>
    </table>

    <table class="cart__list">
        <h4 class="display-6 fw-bolder" style="padding-top: 55px;">주문자 정보</h4>
        <tr>
            <td style="padding-left: 45px" width="15%"><h5><b>구매자 이름</b></h5></td>
            <td><input id="msg0" type="text" class="form-control" name="msg" placeholder="Additional Info" value="${user}"></td>
        </tr>
        <tr>
            <td style="padding-left: 45px"><h5><b>휴대폰 번호</b></h5></td>
            <td><input id="msg1" type="text" class="form-control" name="msg" placeholder="Additional Info" value="${userPhone}"></td>
        </tr>
        <tr>
            <td style="padding-left: 45px"><h5><b>이메일</b></h5></td>
            <td><input id="msg2" type="email" class="form-control" name="msg" placeholder="Additional Info" value="${userEmail}"></td>
        </tr>
        <tr>
            <td style="padding-left: 45px"><h5><b>주소</b></h5></td>
            <td><input id="msg3" type="text" class="form-control" name="msg" placeholder="Additional Info"></td>
        </tr>
        <tr>
            <td style="padding-left: 45px"><h5><b>배송시 유의사항</b></h5></td>
            <td><input id="msg4" type="text" class="form-control" name="msg" placeholder="Additional Info"></td>
        </tr>
        <tfoot>
        <tr style="text-align: center">
            <td colspan="6" id="payresult">
            </td>
        </tr>
        </tfoot>
    </table>

    <div class="cart__mainbtns">
        <button class="cart__bigorderbtn left" onclick="goBack()">뒤로가기</button>
        <button class="cart__bigorderbtn right" onclick="pay()">결제하기</button>
    </div>
</section>
<script type="text/javascript">

    window.onload = () => {
        price();
    }

    const clientKey = 'test_ck_4vZnjEJeQVxQ1NgYXLbrPmOoBN0k'
    const tossPayments = TossPayments(clientKey);
    let ordNo = "";
    let resultPrice = 0;
    let ordName = "";

    /**
     * 결제하기
     */
    function pay() {
        markOrderNo()
        if(ordNo != "" && ordNo != null){
            tossPayments.requestPayment('카드', {
                amount: resultPrice,
                orderId: ordNo,
                orderName: ordName,
                customerName: '${user}',
                successUrl: 'http://localhost:8081/pay/success',
                failUrl: 'http://localhost:8081/pay/fail',
            })
        }
    }

    /**
     * 주문번호 생성
     */
    function markOrderNo() {
        $.ajax({
            type: "GET",
            contentType: 'application/json',
            url: "/api/make/ordNo",
            async: false, //동기: false, 비동기(기본값): ture
            success: function(response) {
                console.log(response)
                ordNo = response;
            }
        })
    }

    function price() {
        var list = new Array();
        let html = '';
        let htmlRe = '';
        let listOrdName = [];

        <c:forEach items="${Paylist}" var="item">
            listOrdName.push("${item.title}"); //상품명도 같이 보냄
            list.push("${item.price}");
            resultPrice += ${item.price};
        </c:forEach>

        ordName = listOrdName[0] + " 상품 외 " + (listOrdName.length - 1) + "건";

        let Sumprice = resultPrice.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
        html += `<td colspan="6"><h4>총 주문 금액 : <b>`+ Sumprice +`원</b> + 배송비 : <b>0원</b> | 총 결제 금액 : <b>`+ Sumprice +`원</b></h4></td>`;
        htmlRe += `<td colspan="2"><h3>총 결제 금액 : <b>`+ Sumprice +`원</b></h3></td>`
        document.getElementById('payresults').innerHTML = html;
        document.getElementById('payresult').innerHTML = htmlRe;
    }

    function goBack() {
        window.history.back();
    }

</script>

</body>

</html>