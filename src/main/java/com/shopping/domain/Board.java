package com.shopping.domain;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "shopboard")
public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // PK

    private String title; // 상품명

    private int price; // 가격

    private String content; // 내용

    private int hits; // 조회 수

    private char useyn; // 판매 유무

    private char deleteYn; // 삭제 여부

    private LocalDateTime createdDate = LocalDateTime.now(); // 생성일

    private LocalDateTime modifiedDate; // 수정일

    @Builder
    public Board(String title, int price, String content, int hits, char useyn, char deleteYn) {
        this.title = title;
        this.price = price;
        this.content = content;
        this.hits = hits;
        this.useyn = useyn;
        this.deleteYn = deleteYn;
    }

    /**
     * 게시글 수정
     */
    public void update(String title, int price, String content, char useyn) {
        this.title = title;
        this.price = price;
        this.content = content;
        this.useyn = useyn;
        this.modifiedDate = LocalDateTime.now();
    }

    /**
     * 조회 수 증가
     */
    public void hitsup() {
        this.hits++;
    }

    /**
     * 게시글 삭제
     */
    public void delete() {
        this.deleteYn = 'Y';
    }
}
