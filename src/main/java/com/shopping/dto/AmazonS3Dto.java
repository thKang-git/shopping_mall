package com.shopping.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
public class AmazonS3Dto {
    private Long id; // 파일 번호
    private Long boardIdx; // 게시글 번호(연동)
    private String originalName; // 원본 이름
    private String saveName; // 업로드 이름
    private String filePath; // 업로드 URL
    private int size; // 파일 크기
    private String type; // 파일 확장자
    private Date insertTime; // 등록일
}
