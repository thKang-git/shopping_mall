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
                        <input class="form-control text-center me-3" id="inputQuantity" type="text" value="1" disabled
                               style="max-width: 4rem"/>
                        <button onclick="stmdPrdct(${id})" class="btn btn-outline-dark flex-shrink-0" type="button">
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
            <form class="mb-4" id="formComment">
                <textarea class="form-control" id="contents" rows="3" placeholder="댓글을 입력해주세요"></textarea>
                <button type="button" onclick="insertComment()" class="btn btn-info">등록</button>
            </form>
            <div id="comment"></div>
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
        findComment();
        }

    // ====================================================================================

    /**
     * 댓글 조회
     */
    function findComment() {
        fetch('/comment/${id}').then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }
            return response.json();

        }).then(data => {
            let html = '';
            console.log(data);
            if (data.length != 0) {
                data.forEach((obj, idx) => {
                    if(obj.writerIdx == ${userIdx}) {
                        html += `
                            <div class="d-flex mb-4">
                                <div class="flex-shrink-0"><img class="rounded-circle"
                                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                                <div>
                                <div id="divComment`+ idx +`"></div>
                                <div id="commentDiv`+ idx +`">
                                    <div class="ms-3" style="float: left">
                                        <div class="fw-bold" data-content="` + obj.content + `" id="comment`+ idx +`">` + obj.writer + `</div>
                                            ` + obj.content + `
                                    </div>
                                    <div style="margin: 18px; float: right">
                                        <button type="button" onclick="updateComment(`+ idx +`, `+ obj.id+`)" class="btn btn-success btn-xs">수정</button>
                                        <button type="button" onclick="deleteComment(`+obj.id+`)" class="btn btn-danger btn-xs">삭제</button>
                                    </div>
                                </div>
                               </div>
                            </div>
                        `;
                    } else {
                        html += `
                            <div class="d-flex mb-4">
                                <div class="flex-shrink-0"><img class="rounded-circle"
                                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                                <div class="ms-3">
                                    <div class="fw-bold">` + obj.writer + `</div>
                                        ` + obj.content + `
                                </div>
                            </div>
                        `;
                    }
                });
            } else {
                html += `
            <div class="d-flex mb-4">
                <div class="flex-shrink-0"><img class="rounded-circle"
                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                <div class="ms-3">
                    <div class="fw-bold">Commenter Name</div>
                    If you're going to lead a space frontier, it has to be government; it'll never be private
                    enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified
                    risks. What the Hell!!!!!! == 댓글이 없습니다. ==
                </div>
            </div>
            <div class="d-flex mb-4">
                <div class="flex-shrink-0"><img class="rounded-circle"
                                                src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..."></div>
                <div class="ms-3">
                    <div class="fw-bold">Commenter Name</div>
                    If you're going to lead a space frontier, it has to be government; it'll never be private
                    enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified
                    risks. What the Hell!!!!!! == 댓글이 없습니다. ==
                </div>
            </div>
                `;
            }
            document.getElementById('comment').innerHTML = html;

        }).catch(error => {
            alert('정보를 찾을 수 없습니다.');
        });
    }

    // ====================================================================================

    /**
     * 댓글 등록 및 수정
     */
    function insertComment(id) {
        let form = document.getElementById('formComment');

        if (id == null) { // 등록
            let params = {
                "boardIdx" : ${id},
                "content" : form.contents.value,
                "writer" : "${user}",
                "writerIdx" : ${userIdx}
            };

            $.ajax({
                type: "POST",
                contentType: 'application/json',
                url: "/comment/save",
                async: false,
                data: JSON.stringify(params),
                dataType: "json",
                success: function(response) {
                    console.log("등록완료");
                    findComment();
                    document.getElementById('contents').value='';
                }
            });
        } else { // 수정
            let texta = document.getElementById('textar');
            let params = {
                "content" : texta.value
            };

            let url = "/comment/" + id;

            $.ajax({
                type: "PATCH",
                contentType: 'application/json',
                url: url,
                async: false,
                data: JSON.stringify(params),
                dataType: "json",
                success: function(response) {
                    console.log("수정완료");
                    findComment();
                }
            });
        }
    }

    // ====================================================================================

    /**
     * 댓글 삭제
     */
    function deleteComment(id) {

        if (!confirm("댓글을 삭제하시겠습니까?")) {
            return;
        }

        let url = "/comment/" + id;

        $.ajax({
            type: "DELETE",
            contentType: 'application/json',
            url: url,
            async: false,
            success: function(response) {
                console.log("삭제완료");
                findComment();
            }
        });
    }

    // ====================================================================================

    /**
     * 댓글 수정칸 보이기
     */
    function updateComment(idx, id) {

        $("#commentDiv" + idx).hide();
        $("#divComment" + idx).show();
        let comment = document.getElementById('comment'+ idx).dataset.content;

        let html = "<textarea placeholder='댓글을 입력하세요' id='textar' style='width: 800px'>"+ comment +"</textarea>";
        html += `<div style="margin: 18px;">
                    <button type="button" onclick="insertComment(`+ id +`)" class="btn btn-info btn-xs">수정</button>
                    <button type="button" onclick="cancel(`+idx+`)" class="btn btn-secondary btn-xs">취소</button>
                </div>
            `;

        document.getElementById('divComment'+ idx).innerHTML = html;

    }

    // ====================================================================================

    /**
     * 댓글 취소
     */
    function cancel(idx) {
        $("#divComment" + idx).hide();
        $("#commentDiv" + idx).show();
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

    // ====================================================================================

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
     * 상품 장바구니
     */
    function stmdPrdct(id) {
        const userId = ${userIdx};

        if (userId == null) {
            alert("로그인을 해주세요");
            return;
        }

        let params = {
            "boardIdx" : id,
            "userId" : userId,
            "payStus" : 0
        }

        $.ajax({
            type: "POST",
            contentType: 'application/json',
            url: "/api/shopbasket",
            async: false,
            data: JSON.stringify(params),
            success: function(response) {
                basketcount();
                alert("장바구니 " + response);
            }
        })

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