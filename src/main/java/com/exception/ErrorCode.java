package com.exception;

import org.springframework.http.HttpStatus;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorCode {

    /*
     * 400 BAD_REQUEST: 잘못된 요청
     */
    BAD_REQUEST(HttpStatus.BAD_REQUEST, "잘못된 요청입니다."),

    /*
     * 404 NOT_FOUND: 리소스를 찾을 수 없음
     */
    POSTS_NOT_FOUND(HttpStatus.NOT_FOUND, "게시글 정보를 찾을 수 없습니다."),

    /*
     * 405 METHOD_NOT_ALLOWED: 허용되지 않은 Request Method 호출
     */
    METHOD_NOT_ALLOWED(HttpStatus.METHOD_NOT_ALLOWED, "허용되지 않은 메서드입니다."),

    /*
     * 500 INTERNAL_SERVER_ERROR: 내부 서버 오류
     */
    INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "내부 서버 오류입니다."),

    /*
     * 500 INTERNAL_FILE_SERVER_ERROR: 파일 업로드 오류
     */
    INTERNAL_FILE_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "파일 업로드 실패했습니다."),

    /*
     * 500 INTERNAL_FILE_DELETE_SERVER_ERROR: 파일 삭제 오류
     */
    INTERNAL_FILE_DELETE_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "파일 삭제를 실패했습니다."),

    /*
     * 500 INTERNAL_COMMENT_DELETE_SERVER_ERROR: 댓글 처리 오류
     */
    INTERNAL_COMMENT_DELETE_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "댓글 처리 오류입니다."),

    ;

    private final HttpStatus status;
    private final String message;

}