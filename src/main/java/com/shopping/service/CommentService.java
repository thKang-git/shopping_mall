package com.shopping.service;


import com.exception.CustomException;
import com.exception.ErrorCode;
import com.shopping.domain.Comment;
import com.shopping.domain.CommentRepository;
import com.shopping.dto.CommentDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentRepository commentRepository;


    /**
     *  댓글 조회
     */
    public List<CommentDto> findAllList(Long boardIdx) {
        char deleteYn = 'N';
        Sort sort = Sort.by(Sort.Direction.DESC, "id", "insertTime");

        List<Comment> commentList = commentRepository.findAllByBoardIdxAndDeleteYn(boardIdx, deleteYn, sort);

        if (commentList.isEmpty()) {
            return Collections.emptyList();
        }

        return commentList.stream().map(CommentDto :: new).collect(Collectors.toList());
    }

    /**
     * 댓글 등록
     */
    @Transactional
    public Long save(CommentDto commentDto) {
        Comment result = commentRepository.save(commentDto.toEntity());
        return result.getId();
    }

    /**
     * 댓글 수정
     */
    @Transactional
    public Long update(Long id, CommentDto commentDto) {
        Comment result = commentRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.INTERNAL_COMMENT_DELETE_SERVER_ERROR));
        result.update(commentDto.getContent());
        return id;
    }

    /**
     * 댓글 삭제
     */
    @Transactional
    public Long delete(Long id) {
        Comment result = commentRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.INTERNAL_COMMENT_DELETE_SERVER_ERROR));
        result.delete();
        return id;
    }
}
