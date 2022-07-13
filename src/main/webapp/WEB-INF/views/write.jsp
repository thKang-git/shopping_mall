<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript">

    window.onload = () => {
        findBoard();
        findFile();
    }
    // ====================================================================================
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

    // ====================================================================================

    /**
     * 파일 조회
     */
    function findFile() {

        const id = ${id};

        if (id == null || id == 0) {
            return;
        }

        fetch(`/s3/file/${id}`).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }
            return response.json();

        }).then(data => {
            if (data.length == 0) {
                return;
            }

            let html = '';
            $('#filediv').empty();

            data.forEach((obj, idx) => {
                console.log(obj);
                html += `
                <div data-name="fileDiv" class="form-group filebox bs3-primary" style="margin-top: 20px">
                <label for="file_`+ idx +`" class="control-label" style="margin-right: 30px">파일</label>
                <input type="text" class="upload-name" data-name="`+ obj.saveName +`" value="`+ obj.originalName +`"  readonly />
                <label for="file_`+ idx +`" class="btn btn-primary">찾아보기</label>
                <input type="file" name="files" id="file_`+ idx +`" class="upload-hidden" onchange="changeFilename(this)" />

                <button type="button" onclick="addFile()" class="btn btn-info">
                    +
                </button>
                <button type="button" onclick="deleteFile(this)" class="btn btn-info">
                    -
                </button>
                </div>
               `;
            });
            document.getElementById('filediv').innerHTML = html;

        }).catch(error => {
            alert('파일 정보를 찾을 수 없습니다.');
            goList();
        });
    }

    // ====================================================================================

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

    // ====================================================================================

    /**
     * 게시글 등록(생성/수정)
     */
    function save() {
        //파일 업로드 여부
        let result = 1;

        if ( !isValid() ) {
            return false;
        }

        var useyn = document.getElementById('useyn').checked;

        if (useyn == true) {
            useyn = 'Y';
        } else {
            useyn = 'N';
        }

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

            const filelength = document.getElementsByName('files').length;
            console.log(filelength);

            let fileYn = [];

            for (let i = 0; i < filelength; i++) {
                fileYn[i] = document.getElementById('file_'+ i +'').files[0];
            }
            console.log(fileYn);

            // 개선 필요(추후 작업 진행)
            if (fileYn[filelength - 1] == undefined) {
                alert('저장되었습니다.(파일x)');
                result = 0;
                goList();
                return;
            }
            return response.json();

        }).then(data => {
            console.log("결과값 : " + result);
            saveFile(data, result);

        }).catch(error => {
            alert('오류가 발생하였습니다.(파일x)' + error);
        });
    }

    // ====================================================================================

    /**
     * 파일 업로드 api 통신
     */
    function saveFile(id, result) {

        if (result == 0) {
            console.log("0임");
            return;
        }

        const filelength = document.getElementsByName('files').length;
        console.log(filelength);

        const formData = new FormData();
        for (let i = 0; i < filelength; i++) {
            formData.append('file', document.getElementById('file_'+ i +'').files[0]);
        }
        formData.append('boardIdx', id);

        fetch('/s3/file', {
            method: 'POST',
            body: formData

        }).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }

            alert('저장되었습니다.(파일o)');
            goList();

        }).catch(error => {
            alert('오류가 발생하였습니다.(파일o)');
        });
    }

    // ====================================================================================

    /**
     * 파일 업로드 삭제
     */
    function deleteFile(elem) {
        const saveName = $(elem).prevAll('input[type="text"]')[0].dataset.name;

        if (!saveName) { // 업로드 된 파일이 없으면 칸만 사라짐
            removeFile(elem);
            return;
        }

       if (!confirm("정말로 삭제하시겠습니까?\n(바로 삭제가 됩니다.)")) {
           return;
       }

       fetch('/s3/file?fileName='+ saveName +'',{
           method: 'DELETE'
            })
            .then(response => response.json())  //응답 결과를 json으로 파싱
            .then(data => {
                console.log(data); //응답 결과를 console 창에 출력
                window.location.reload();
            })
            .catch(error => { // 오류 발생시 오류를 담아서 보여줌
                console.log("삭제 오류가 발생했습니다." + error);
            });
    }

    // ====================================================================================

    /**
     * 파일 첨부 영역추가
     */
    function addFile() {

        let fileIdx = document.getElementsByName('files').length; /*[- 파일 인덱스 처리용 전역 변수 -]*/

        const fileDivs = $('div[data-name="fileDiv"]');
        if (fileDivs.length > 2) {
            alert('파일은 최대 세 개까지 업로드 할 수 있습니다.');
            return false;
        }

        const fileHtml = `
        <div data-name="fileDiv" class="form-group filebox bs3-primary" style="margin-top: 20px">
            <label for="file_`+ fileIdx +`" class="control-label" style="margin-right: 30px">파일</label>
                <input type="text" class="upload-name" value="파일 찾기" readonly />
                <label for="file_`+ fileIdx +`" class="btn btn-primary">찾아보기</label>
                <input type="file" name="files" id="file_`+ fileIdx +`" class="upload-hidden" onchange="changeFilename(this)" />

                <button type="button" onclick="deleteFile(this)" class="btn btn-info">
                    -
                </button>
        </div>
	`;

        $('#btnDiv').before(fileHtml);
    }

    // ====================================================================================

    /**
     * 파일 첨부 영역삭제
     */
    function removeFile(elem) {

        const prevTag = $(elem).prev().prop('tagName');
        if (prevTag === 'BUTTON') {
            const file = $(elem).prevAll('input[type="file"]');
            const filename = $(elem).prevAll('input[type="text"]');
            file.val('');
            filename.val('파일 찾기');
            return false;
        }

        const target = $(elem).parents('div[data-name="fileDiv"]');
        target.remove();
    }

    // ====================================================================================

    /**
     * 파일 첨부 보이기
     */
    function changeFilename(file) {

        file = $(file);
        const filename = file[0].files[0].name;
        const target = file.prevAll('input');
        target.val(filename);
    }

    // ====================================================================================

    /**
     * 페이지 이동
     */
    function goList() {

        let id = ${id};

        if (id == 0) {
            id = "";
        }
        location.href = (id) ? '/shopping/list.do' + location.search : '/shopping/list.do';
    }

    function testf() {
        location.reload();
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
            <label for="useyn" class="control-label" style="display: inline">판매 유무</label>
            <div style="margin-top: 10px; display: inline">
                <input type="checkbox" id="useyn" name="useyn"/>
            </div>
        </div>

        <div class="form-label" style="margin-top: 20px">
            <label for="title" class="control-label">상품명</label>
            <input type="text" id="title" class="form-control" placeholder="상품명을 입력해 주세요."/>
        </div>

        <div class="form-label" style="margin-top: 20px">
            <label for="price" class="control-label">가격</label>
            <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                   id="price" class="form-control" placeholder="가격을 입력해 주세요."/>
        </div>

        <div class="form-label" style="margin-top: 20px">
            <label for="content" class="control-label">내용</label>
            <textarea id="content" class="form-control" style="resize: none; height: 200px;" placeholder="내용을 입력해 주세요."></textarea>
        </div>
        <%--        이미지--%>
        <div id="filediv">
        <div data-name="fileDiv" class="form-group filebox bs3-primary" style="margin-top: 20px">
            <label for="file_0" class="control-label" style="margin-right: 30px">파일</label>
                <input type="text" class="upload-name" value="파일 찾기" readonly />
                <label for="file_0" class="btn btn-primary">찾아보기</label>
                <input type="file" name="files" id="file_0" class="upload-hidden" onchange="changeFilename(this)" />

                <button type="button" onclick="addFile()" class="btn btn-info">
                    +
                </button>
                <button type="button" onclick="deleteFile(this)" class="btn btn-info">
                    -
                </button>
        </div>
        </div>
        <div id="btnDiv"></div>
        </form>
        <%--        이미지--%>
    <div class="btn_wrap text-center">
        <button type="button" onclick="goList()" class="btn btn-secondary">뒤로가기</button>
        <button type="button" class="btn btn-primary" onclick="save()">저장하기</button>
        <button type="button" class="btn btn-primary" onclick="testf()">테스트</button>
    </div>
</div>
</div>

<!-- Footer-->
<footer class="py-5 bg-dark" style="bottom: 0; width: 100%; position: fixed">
    <div class="container"><p class="m-0 text-center text-white">Shopping &copy; Your Website 2022</p></div>
</footer>

</body>
</html>