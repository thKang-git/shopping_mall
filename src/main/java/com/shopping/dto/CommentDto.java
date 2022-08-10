package com.shopping.dto;

import com.shopping.domain.Board;
import com.shopping.domain.Comment;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CommentDto {

    private Long id; // PK
    private Long boardIdx; // 게시글 번호
    private String content; // 내용
    private String writer; // 작성자
    private int writerIdx; // 작성자 번호
    private char deleteYn; // 삭제여부
    private LocalDateTime insertTime; // 등록일
    private LocalDateTime updateTime; // 수정일
    private LocalDateTime deleteTime; // 삭제일

    //Entity를 DTO로 변환하기 위해
    public CommentDto(Comment entity) {
        this.id = entity.getId();
        this.boardIdx = entity.getBoardIdx();
        this.content = entity.getContent();
        this.writer = entity.getWriter();
        this.writerIdx = entity.getWriterIdx();
        this.deleteYn = entity.getDeleteYn();
        this.insertTime = entity.getInsertTime();
        this.updateTime = entity.getUpdateTime();
        this.deleteTime = entity.getDeleteTime();
    }

    // 저장 부분을 위한 toEntity(service에 넣기 싫음)
    public Comment toEntity() {
        return Comment.builder()
                .boardIdx(boardIdx)
                .content(content)
                .writer(writer)
                .writerIdx(writerIdx)
                .deleteYn('N')
                .build();
    }
}
