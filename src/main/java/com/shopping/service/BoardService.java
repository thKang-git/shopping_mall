package com.shopping.service;

import com.shopping.domain.Board;
import com.shopping.domain.BoardRepository;
import com.shopping.dto.BoardRequestDto;
import com.shopping.dto.BoardResponseDto;
import com.shopping.exception.CustomException;
import com.shopping.exception.ErrorCode;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BoardService {

    private final BoardRepository boardRepository;

    /**
     * 게시글 저장
     */
    @Transactional
    public Long save(final BoardRequestDto params) {

        Board entity = boardRepository.save(params.toEntity());
        return entity.getId();
    }

    /**
     * 게시글 삭제
     */
    @Transactional
    public Long delete(final Long id) {
        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));
        entity.delete();
        return id;
    }

    /**
     * 게시글 조회 - 사용 안함
     */
    public List<BoardResponseDto> findAll() {
        Sort sort = Sort.by(Sort.Direction.DESC, "id", "createdDate");
        List<Board> list = boardRepository.findAll(sort);
        return list.stream().map(BoardResponseDto :: new).collect(Collectors.toList());
    }

    /**
     * 게시글 조회 - 삭제여부 N
     */
    public List<BoardResponseDto> findAllByDeleteYn(char deleteYn) {
        Sort sort = Sort.by(Sort.Direction.DESC, "id", "createdDate");
        List<Board> list = boardRepository.findAllByDeleteYn(deleteYn, sort);
        return list.stream().map(BoardResponseDto :: new).collect(Collectors.toList());
    }

    /**
     * 게시글 수정
     */
    @Transactional
    public Long update(final Long id, final BoardRequestDto params) {

        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));

        entity.update(params.getTitle(), params.getPrice() ,params.getContent(), params.getUseyn());
        return id;
    }

    /**
     * 상세보기
     */
    @Transactional
    public BoardResponseDto findById(final Long id) {
        Board entity = boardRepository.findById(id).orElseThrow(() -> new CustomException(ErrorCode.POSTS_NOT_FOUND));

        entity.hitsup();
        return new BoardResponseDto(entity);
    }
}
