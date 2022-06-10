<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript">

    window.onload = () => {
        findAll();
    }

    function findAll() {

        fetch('/api/boards')
            .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let html = '';

            if (!data.length) {
                html = '<td colspan="5">등록된 게시글이 없습니다.</td>';
            } else {
                data.forEach((obj, idx) => {
                    html += `
                        <div class="col mb-5">
                            <div class="card h-100">
                                <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">조회수 : `+ obj.hits +`</div>
                                <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; left: 0.5rem">`+ obj.id +`</div>
                                <img class="card-img-top" src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
                                <div class="card-body p-4">
                                    <div class="text-center">
                                        <h5 class="fw-bolder">`+ obj.title +`</h5>
                                        <div class="d-flex justify-content-center small text-warning mb-2">
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                        </div>
                                        `+ obj.price +`원
                                    </div>
                                </div>
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                        <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="/shopping/view/`+ obj.id +`">상세보기</a></div>
                                    </div>
                                </div>
                            </div>
                    `;
                });
            }

            document.getElementById('card-shop').innerHTML = html;
        });
    }

</script>
<body>

<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shop in List</h1>
            <p class="lead fw-normal text-white-50 mb-0">With this shop list page</p>
        </div>
    </div>
</header>

<!-- Section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center" id="card-shop">
        </div>
        <div class="btn_wrap" style="float: right">
            <a href="/shopping/write.do" class="btn btn-primary waves-effect waves-light">등록</a>
        </div>
    </div>
</section>


<!-- Footer-->
<footer class="py-5 bg-dark">
    <div class="container"><p class="m-0 text-center text-white">Shopping &copy; Your Website 2022</p></div>
</footer>


</body>
</html>