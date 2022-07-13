<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>
<!DOCTYPE html>
<html>
<%--<head>--%>
<%--    <script src="${path}/js/scripts.js?v=<%=System.currentTimeMillis() %>"></script>--%>
<%--</head>--%>

<body>
<!-- Product section-->
<section class="py-5">
    <div class="container px-4 px-lg-5 my-5" style="width:2000px; height: 800px">
        <div class="row gx-4 gx-lg-5 align-items-center" style="margin-top: 50px;">

            <div class="col-md-6" id="slideShow">
                    <ul class="slides" id="imgdiv">
                        <li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg"/></li>
                        <li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="https://dummyimage.com/600x700/099999/fff"/></li>
                    </ul>
                <p class="controller">
                    <span class="prev">&lang;</span>
                    <span class="next">&rang;</span>
                </p>
            </div>

            <div class="col-md-6" style="padding-left: 50px">
                    <div class="small mb-1" style="font-size: medium" id="createdDate"></div>
                    <h1 class="display-1 fw-bolder" id="title"></h1>
                    <div class="fs-1 mb-5">
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
    <c:if test="${role != 'ADMIN'}"><button type="button" class="btn btn-danger" disabled>삭제하기</button></c:if>

    <c:if test="${role == 'ADMIN'}"><button type="button" class="btn btn-danger" onclick="deleteBoard()">삭제하기</button></c:if>
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

<script type="text/javascript">

    window.onload = () => {
        findBoard();
        findFile();
    }

    // ====================================================================================
    /**
     * 파일 슬라이드
     */
    function slides() {
        const slides = document.querySelector(".slides"); //전체 슬라이드 컨테이너
        let slideImg = document.querySelectorAll('.slides li'); //모든 슬라이드들
        let currentIdx = 0; //현재 슬라이드 index
        let slideCount = slideImg.length; // 슬라이드 개수
        const prev = document.querySelector('.prev'); //이전 버튼
        const next = document.querySelector('.next'); //다음 버튼
        const slideWidth = 300; //한개의 슬라이드 넓이
        const slideMargin = 50; //슬라이드간의 margin 값

        //전체 슬라이드 컨테이너 넓이 설정
        slides.style.width = (slideWidth + slideMargin) * slideCount + 'px';

        function moveSlide(num) {
            slides.style.left = -num * 710 + 'px';
            currentIdx = num;
        }

        prev.addEventListener('click', function () {
            /*첫 번째 슬라이드로 표시 됐을때는
            이전 버튼 눌러도 아무런 반응 없게 하기 위해
            currentIdx !==0일때만 moveSlide 함수 불러옴 */

            if (currentIdx !== 0) moveSlide(currentIdx - 1);
        });

        next.addEventListener('click', function () {
            /* 마지막 슬라이드로 표시 됐을때는
            다음 버튼 눌러도 아무런 반응 없게 하기 위해
            currentIdx !==slideCount - 1 일때만
            moveSlide 함수 불러옴 */
            if (currentIdx !== slideCount - 1) {
                moveSlide(currentIdx + 1);
            }
        });
    }

    // ====================================================================================

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
            slides();
        }).catch(error => {
            alert('게시글 정보를 찾을 수 없습니다.');
            goList();
        });
    }

    // ====================================================================================

    /**
     * 파일 조회
     */
    function findFile() {

        fetch(`/s3/file/${id}`).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }
            return response.json();

        }).then(data => {
            console.log(data);
            let html = '';
            if (!data.length) {
                html = `<li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg"/></li>`
            } else {
                data.forEach((obj, idx) => {
                    console.log(obj.filePath);
                    html += `<li><img class="card-img-top mb-5 mb-md-0" style="width: 600px; height: 700px" src="`+ obj.filePath +`"/></li>
                   `;
                });
            }
            document.getElementById('imgdiv').innerHTML = html;
        }).catch(error => {
            alert('파일 정보를 찾을 수 없습니다.');
            goList();
        });
    }

    // ====================================================================================

    /**
     * 수정하기
     */
    function goWrite() {
        location.href = `/shopping/write.do` + location.search +`&id=${id}`;
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
        });
    }

    // ====================================================================================

    /**
     * 페이지 이동
     */
    function goList() {
        location.href = '/shopping/list.do' + location.search;
    }
</script>

</html>