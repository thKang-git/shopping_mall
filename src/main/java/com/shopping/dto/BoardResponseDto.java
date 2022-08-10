package com.shopping.dto;

import com.shopping.domain.Board;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BoardResponseDto {

    private Long id; // PK
    private String title; // 상품명
    private int price; // 가격
    private String content; // 내용
    private int hits; // 조회 수
    private char useyn; // 판매 유무
    private char deleteYn; // 삭제 여부
    private LocalDateTime createdDate; // 생성일
    private LocalDateTime modifiedDate; // 수정일

    private Long attach_id; // 파일 번호
    private String file_path; // 업로드 URL

    public BoardResponseDto(Board entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.price = entity.getPrice();
        this.content = entity.getContent();
        this.hits = entity.getHits();
        this.useyn = entity.getUseyn();
        this.deleteYn = entity.getDeleteYn();
        this.createdDate = entity.getCreatedDate();
        this.modifiedDate = entity.getModifiedDate();
    }

}