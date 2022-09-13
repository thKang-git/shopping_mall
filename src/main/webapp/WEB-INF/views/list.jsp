<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript">

    window.onload = () => {
        setQueryStringParams();
        findAll();
        addEnterSearchEvent();
    }

    // ====================================================================================

    /**
     * 키워드 - 엔터 검색 이벤트 바인딩
     */
    function addEnterSearchEvent() {

        document.getElementById('keyword').addEventListener('keyup', (e) => {
            if (e.keyCode === 13) {
                findAll(1);
            }
        });
    }

    // ====================================================================================

    /**
     * 쿼리 스트링 파라미터 셋팅
     */
    function setQueryStringParams() {

        if ( !location.search ) {
            return false;
        }

        const form = document.getElementById('searchForm');

        new URLSearchParams(location.search).forEach((value, key) => {
            if (form[key]) {
                form[key].value = value;
            }
        });
    }

    // ====================================================================================

    /**
     * 페이지 조회
     */
    function findAll(page) {

        const pageParam = Number(new URLSearchParams(location.search).get('page'));
        page = (page) ? page : ((pageParam) ? pageParam : 1);

        let form = document.getElementById('searchForm');

        const params = {
            page : page,
            recordPerPage : 12,
            pageSize : 10,
            searchType : form.searchType.value,
            keyword : form.keyword.value
        };

        const queryString = new URLSearchParams(params).toString();
        const replaceUri = location.pathname + '?' + queryString;
        history.replaceState({}, '', replaceUri);

        let uri = '/api/boards'

        if (params) {
            uri = uri + '?' + new URLSearchParams(params).toString();
        }

        fetch(uri)
            .then(response => {
            if (response.ok) {
                return response.json();
            }
        }).then(data => {
            let html = '';

            if (!data.list.length) {
                html = '<td colspan="5">등록된 게시글이 없습니다.</td>';
                drawPages();
                return false;
            } else {
                data.list.forEach((obj, idx) => {
                    const viewUri = '/shopping/view/'+ obj.id +'' + '?' + queryString;

                    if (obj.file_path != null) { // 썸네일 이미지가 있을 때 썸네일 표시
                        html += `
                            <div class="col mb-5">
                                <div class="card h-100">
                                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">조회수 : `+ obj.hits +`</div>
                                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; left: 0.5rem">`+ obj.id +`</div>
                                    <img class="card-img-top" style="width: 253px; height: 169px" src="`+ obj.file_path +`" alt="..." />
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
                                            `+ obj.price.toLocaleString() +`원
                                        </div>
                                    </div>
                                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                            <div class="text-center"><a class="btn btn-info mt-auto" href="`+ viewUri +`">상세보기</a></div>
                                        </div>
                                    </div>
                                </div>
                        `;

                    } else { // 썸네일 이미지가 없을 때 빈 썸네일 표시
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
                                            `+ obj.price.toLocaleString() +`원
                                        </div>
                                    </div>
                                        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                            <div class="text-center"><a class="btn btn-info mt-auto" href="`+ viewUri +`">상세보기</a></div>
                                        </div>
                                    </div>
                                </div>
                        `;
                    }
                });
            }

            document.getElementById('card-shop').innerHTML = html;
            drawPages(data.params);
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
     * 페이지 HTML 렌더링
     */
    function drawPages(params) {

        if (!params) {
            document.querySelector('.pagination').innerHTML = '';
            return false;
        }

        let html = '';
        const pagination = params.pagination;

        // 첫 페이지, 이전 페이지
        if (pagination.existPrevPage) {
            let existPrevPage = pagination.startPage - 1;
            html += `
 				<li><a href="javascript:void(0)" onclick="findAll(1);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
 				<li><a href="javascript:void(0)" onclick="findAll(`+ existPrevPage +`);" aria-label="Previous"><span aria-hidden="true">&lsaquo;</span></a></li>
 			`;
        }

        // 페이지 번호
        for (let i = pagination.startPage; i <= pagination.endPage; i++) {
            const active = (i === params.page) ? 'class="active"' : '';
            html += `<li ` + active + `><a href="javascript:void(0)" onclick="findAll(`+ i +`)">`+ i +`</a></li>`;
        }

        // 다음 페이지, 마지막 페이지
        if (pagination.existNextPage) {
            let existNextPage = pagination.endPage + 1;
            html += `
 				<li><a href="javascript:void(0)" onclick="findAll(` + existNextPage + `);" aria-label="Next"><span aria-hidden="true">&rsaquo;</span></a></li>
 				<li><a href="javascript:void(0)" onclick="findAll(`+ pagination.totalPageCount +`);" aria-label="Next" <span aria-hidden="true">&raquo;</span></a></li>
 			`;
        }

        document.querySelector('.pagination').innerHTML = html;
    }

</script>
<body>

<!-- Header-->
<header class="bg-secondary py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shop in List</h1>
            <p class="lead fw-normal text-white-50 mb-0">With this shop list page</p>
        </div>
    </div>
</header>

<!-- Section-->
<section class="py-5">
    <%@include file="common/board-search.jsp" %>
    <div class="container px-4 px-lg-5 mt-5">
        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center" id="card-shop">
        </div>
        <div class="btn_wrap" style="float: right">
            <a href="/shopping/write.do" class="btn btn-primary waves-effect waves-light">등록</a>
        </div>
    </div>
</section>

<!-- 페이지네이션 Rendering 영역 -->
<nav aria-label="Page navigation" class="text-center">
    <ul class="pagination">
    </ul>
</nav>

<!-- 하단 -->
<footer id="footer" class="py-5 bg-dark">
    <div class="container"><p class="m-0 text-center text-white">Shopping &copy; Your Website 2022</p></div>
</footer>


</body>
</html>