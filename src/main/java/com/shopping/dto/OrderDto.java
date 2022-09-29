package com.shopping.dto;

import lombok.Data;

import java.util.List;

@Data
public class OrderDto {
    private List<Long> ordId;             // 주문번호
    private Long userId;             // 회원번호
}
