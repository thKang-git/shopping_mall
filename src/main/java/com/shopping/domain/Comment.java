package com.shopping.domain;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@AllArgsConstructor
@Table(name = "Comment")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; //PK

    private Long boardIdx; // 게시글 번호

    private String content; // 내용

    private String writer; // 작성자

    private int writerIdx; // 작성자 번호

    private char deleteYn; // 삭제여부

    private LocalDateTime insertTime = LocalDateTime.now(); // 등록일

    private LocalDateTime updateTime; // 수정일

    private LocalDateTime deleteTime; // 삭제일

    @Builder
    public Comment(Long boardIdx, String content, String writer, int writerIdx, char deleteYn) {
        this.boardIdx = boardIdx;
        this.content = content;
        this.writer = writer;
        this.writerIdx = writerIdx;
        this.deleteYn = deleteYn;
    }

    /**
     * 댓글 수정
     */
    public void update(String content) {
        this.content = content;
        this.updateTime = LocalDateTime.now();
    }

    /**
     * 댓글 삭제
     */
    public void delete() {
        this.deleteYn = 'Y';
        this.deleteTime = LocalDateTime.now();
    }

}
