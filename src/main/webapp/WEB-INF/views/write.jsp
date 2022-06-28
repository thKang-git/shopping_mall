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

        let id = ${id};

        if (id == 0) {
            id = "";
        }

        if ( !id ) {
            return false;
        }

        fetch(`/api/boards/${id}`).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }
            return response.json();

        }).then(data => {
            const form = document.getElementById('subform');
            if (data.useyn == 'Y') {
                $("#useyn").prop("checked", true);
            }
            form.title.value = data.title;
            form.price.value = data.price;
            form.content.value = data.content;

        }).catch(error => {
            alert('게시글 정보를 찾을 수 없습니다.');
            location.href = '/shopping/list.do';
        });
    }


    /**
     * 검사
     */
    function isValid() {
        const subform = document.getElementById('subform');

        if (!subform.title.value.trim()) {
            alert('제목을 입력해 주세요.');
            form.title.value = '';
            form.title.focus();
            return false;
        }

        if (!subform.price.value.trim()) {
            alert('가격을 입력해 주세요.');
            form.price.value = '';
            form.price.focus();
            return false;
        }

        if (!subform.content.value.trim()) {
            alert('내용을 입력해 주세요.');
            form.content.value = '';
            form.content.focus();
            return false;
        }

        return true;
    }

    /**
     * 게시글 등록(생성/수정)
     */
    function save() {

        if ( !isValid() ) {
            return false;
        }

        var useyn = document.getElementById('useyn').checked;

        if (useyn == true) {
            useyn = 'Y';
        } else {
            useyn = 'N';
        }

        console.log(useyn);

        const form = document.getElementById('subform');
        const params = {
            useyn: useyn,
            title: form.title.value,
            price: form.price.value,
            content: form.content.value,
            deleteYn: 'N'
        };

        let id = ${id};

        if (id == 0) {
            id = "";
        }

        const uri = ( id ) ? `/api/boards/${id}`: '/api/boards';

        const method = ( id ) ? 'PATCH' : 'POST';

        fetch(uri, {
            method: method,
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(params)

        }).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }

            alert('저장되었습니다.');
            location.href = 'list.do';

        }).catch(error => {
            alert('오류가 발생하였습니다.');
        });
    }
</script>
<body>

<!-- Header-->
<header class="bg-dark py-5">
    <div class="container px-4 px-lg-5 my-5">
        <div class="text-center text-white">
            <h1 class="display-4 fw-bolder">Shop in Write</h1>
            <p class="lead fw-normal text-white-50 mb-0">With this shop write page</p>
        </div>
    </div>
</header>

<div class="main-content" style="margin-top: 50px;">
    <form id="subform" class="container" action="/api/save" method="POST">

        <div class="form-label">
            <label for="useyn" class="col-sm-2 control-label" style="display: inline">판매 유무</label>
            <div class="col-sm-10" style="margin-top: 10px; display: inline">
                <input type="checkbox" id="useyn" name="useyn"/>
            </div>
        </div>

        <div class="form-label" style="margin-top: 20px">
            <label for="title" class="col-sm-2 control-label">상품명</label>
            <input type="text" id="title" class="form-control" placeholder="상품명을 입력해 주세요."/>
        </div>

        <div class="form-label" style="margin-top: 20px">
            <label for="price" class="col-sm-2 control-label">가격</label>
            <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                   id="price" class="form-control" placeholder="가격을 입력해 주세요."/>
        </div>

        <div class="form-label" style="margin-top: 20px">
            <label for="content" class="col-sm-2 control-label">내용</label>
            <textarea id="content" class="form-control" placeholder="내용을 입력해 주세요."></textarea>
        </div>

        <div class="btn_wrap text-center">
            <a href="list.do" class="btn btn-secondary">뒤로가기</a>
            <button type="button" class="btn btn-primary" onclick="save()">저장하기</button>
        </div>

    </form>
</div>
</div>

<!-- Footer-->
<footer class="py-5 bg-dark" style="bottom: 0; width: 100%; position: fixed">
    <div class="container"><p class="m-0 text-center text-white">Shopping &copy; Your Website 2022</p></div>
</footer>

</body>
</html>