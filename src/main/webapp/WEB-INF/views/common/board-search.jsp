<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!--/* 검색 영역 */-->
<div class="input-group" id="adv-search">
    <form id="searchForm" onsubmit="return false;">
        <select id="searchType" class="form-control" style="width: 100px;">
            <option value="">전체</option>
            <option value="title">제목</option>
            <option value="content">내용</option>
        </select>
        <input type="text" id="keyword" class="form-control" placeholder="키워드를 입력해 주세요." style="width: 300px;" />
    </form>
    <button type="button" onclick="findAll(1);" class="btn btn-primary">
        <span aria-hidden="true" class="glyphicon glyphicon-search"></span>
    </button>
</div>