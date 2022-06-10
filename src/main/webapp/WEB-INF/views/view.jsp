<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript">

    window.onload = () => {
        findBoard();
    }

    /**
     * 게시글 조회
     */
    function findBoard() {

        fetch(`/api/boards/${id}`).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }
            return response.json();

        }).then(data => {
            console.table(data);
            data.createdDate = "등록일 : " + moment(data.createdDate).format('YYYY-MM-DD HH:mm:ss');
            data.price = data.price.toLocaleString() + "원";

            Object.keys(data).forEach(key => {
                const elem = document.getElementById(key);
                if (elem) {
                    elem.innerText = data[key];
                }
            });

        }).catch(error => {
            alert('게시글 정보를 찾을 수 없습니다.');
            return;
        });
    }

    /**
     * 수정하기
     */
    function goWrite() {
        location.href = `/shopping/write.do?id=${id}`;
    }

    /**
     * 삭제하기
     */
    function deleteBoard() {

        if ( !confirm(`${id}번 게시글을 삭제할까요?`) ) {
            return false;
        }

        fetch(`/api/boards/${id}`, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },

        }).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }

            alert('삭제되었습니다.');
            goList();

        }).catch(error => {
            alert('오류가 발생하였습니다.');
            goList();
        });
    }

    /**
     * 페이지 이동
     */
    function goList() {
        location.href = '/shopping/list.do';
    }

</script>
<body>

<!-- Product section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="row gx-4 gx-lg-5 align-items-center" style="margin-top: 100px">
            <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0"
                                       src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg" alt="..."/></div>
            <div class="col-md-6">
                <div class="small mb-1" id="createdDate"></div>
                <h1 class="display-5 fw-bolder" id="title"></h1>
                <div class="fs-5 mb-5">
                    <span id="price"></span>
                </div>
                <p class="lead" id="content"></p>
                <div class="d-flex">
                    <input class="form-control text-center me-3" id="inputQuantity" type="num" value="1"
                           style="max-width: 3rem"/>
                    <button class="btn btn-outline-dark flex-shrink-0" type="button">
                        <i class="bi-cart-fill me-1"></i>
                        Add to cart
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<div class="btn_wrap text-center">
    <button type="button" class="btn btn-secondary" onclick="goList()">뒤로가기</button>
    <button type="button" class="btn btn-danger" onclick="deleteBoard()">삭제하기</button>
    <button type="button" class="btn btn-primary" onclick="goWrite()">수정하기</button>
</div>

<!-- chatting start-->
<section class="mb-5" style="margin-top: 30px">
    <div class="card bg-light">
        <div class="card-body">
            <!-- Comment form-->
            <form class="mb-4"><textarea class="form-control" rows="3" placeholder="댓글을 입력해주세요"></textarea></form>
            <!-- Comment with nested comments-->
            <div class="d-flex mb-4">
                <!-- Parent comment-->
                <div class="flex-shrink-0"><img class="rounded-circle"
                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                <div class="ms-3">
                    <div class="fw-bold">Commenter Name</div>
                    If you're going to lead a space frontier, it has to be government; it'll never be private
                    enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified
                    risks.
                    <!-- Child comment 1-->
                    <div class="d-flex mt-4">
                        <div class="flex-shrink-0"><img class="rounded-circle"
                                                        src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="...">
                        </div>
                        <div class="ms-3">
                            <div class="fw-bold">Commenter Name</div>
                            And under those conditions, you cannot establish a capital-market evaluation of that
                            enterprise. You can't get investors.
                        </div>
                    </div>
                    <!-- Child comment 2-->
                    <div class="d-flex mt-4">
                        <div class="flex-shrink-0"><img class="rounded-circle"
                                                        src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="...">
                        </div>
                        <div class="ms-3">
                            <div class="fw-bold">Commenter Name</div>
                            When you put money directly to a problem, it makes a good headline.
                        </div>
                    </div>
                </div>
            </div>
            <!-- Single comment-->
            <div class="d-flex">
                <div class="flex-shrink-0"><img class="rounded-circle"
                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                <div class="ms-3">
                    <div class="fw-bold">Commenter Name</div>
                    When I look at the universe and all the ways the universe wants to kill us, I find it hard to
                    reconcile that with statements of beneficence.
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer-->
<footer class="py-5 bg-dark" style="bottom: 0; width: 100%;">
    <div class="container"><p class="m-0 text-center text-white">Shopping &copy; Your Website 2022</p></div>
</footer>


</body>
</html>