package com.shopping.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class BasketDto {
    private Long ordId;             // 주문번호
    private Long boardIdx;          // 상품번호
    private int userId;             // 회원번호
    private int payStus;            // 결제여부
    private LocalDateTime createdDate; // 생성일시
}
