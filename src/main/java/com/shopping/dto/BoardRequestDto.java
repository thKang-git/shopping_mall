package com.shopping.dto;

import com.shopping.domain.Board;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BoardRequestDto {

    private String title; // 제목
    private int price; // 가격
    private String content; // 내용
    private char useyn; // 판매 유무
    private char deleteYn; // 삭제 여부

    public Board toEntity() {
        return Board.builder()
                .title(title)
                .price(price)
                .content(content)
                .hits(0)
                .useyn(useyn)
                .deleteYn(deleteYn)
                .build();
    }
}
