package com.shopping.domain;

import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {

    /**
     * 댓글 조회
     */
    public List<Comment> findAllByBoardIdxAndDeleteYn(Long boardIdx, char deleteYn, final Sort sort);
}
