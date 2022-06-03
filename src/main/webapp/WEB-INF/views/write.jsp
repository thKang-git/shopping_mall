<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="layout/top.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript">

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

        fetch('/api/save', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(params)

        }).then(response => {
            if (!response.ok) {
                throw new Error('Request failed...');
            }

            alert('저장되었습니다.');
            location.href = '/list.do';

        }).catch(error => {
            console.log(params);
            alert('오류가 발생하였습니다.');
        });
    }


</script>
<body>
<div class="main-content">
    <div class="row row-inline-block small-spacing">
        <div class="col-xs-12">
            <div class="box-content">
                <div class="clearfix">

                        <form id="subform" class="form-horizontal" action="/api/save" method="POST">

                            <div class="form-group">
                                <label for="useyn" class="col-sm-2 control-label">판매 유무</label>
                                <div class="col-sm-10" style="margin-top: 10px;">
                                    <input type="checkbox" id="useyn" name="useyn"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="title" class="col-sm-2 control-label">상품명</label>
                                <div class="col-sm-8">
                                    <input type="text" id="title" class="form-control" placeholder="상품명을 입력해 주세요."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="price" class="col-sm-2 control-label">가격</label>
                                <div class="col-sm-8">
                                    <input type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" id="price" class="form-control" placeholder="가격을 입력해 주세요."/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="content" class="col-sm-2 control-label">내용</label>
                                <div class="col-sm-8">
                                    <textarea id="content" class="form-control" placeholder="내용을 입력해 주세요."></textarea>
                                </div>
                            </div>

                            <div class="btn_wrap text-center">
                                <a href="list.do" class="btn btn-default waves-effect waves-light">뒤로가기</a>
                                <button type="button" class="btn btn-primary waves-effect waves-light" onclick="save()">저장하기</button>
                            </div>

                        </form>
                    </div>

            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>