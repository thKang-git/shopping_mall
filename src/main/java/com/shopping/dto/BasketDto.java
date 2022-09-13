package com.shopping.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BasketDto {
    private Long ordId;             // 주문번호
    private Long boardIdx;          // 상품번호
    private int userId;             // 회원번호
    private int payStus;            // 결제여부
    private LocalDateTime createdDate; // 생성일시

    private String title;     // 상품명

    @JsonFormat(pattern = "###,###")
    private int price;        // 가격

    private char useYn;       // 판매 유무
    private char deleteYn;   // 삭제 여부
    private String filePath; // 업로드 URL

}
