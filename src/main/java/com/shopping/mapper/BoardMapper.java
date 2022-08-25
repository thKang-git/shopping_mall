package com.shopping.mapper;

import com.paging.CommonParams;
import com.shopping.dto.BasketDto;
import com.shopping.dto.BoardResponseDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {

    /**
     * 게시글 수 조회
     */
    int count(final CommonParams params);

    /**
     * 게시글 리스트 조회
     */
    List<BoardResponseDto> findAll(final CommonParams params);

    /**
     * 장바구니 등록
     */
    int insertBasket(BasketDto basketDto);

    /**
     * 장바구니 갯수
     */
    int selectCountBasket(Long userId);
}
