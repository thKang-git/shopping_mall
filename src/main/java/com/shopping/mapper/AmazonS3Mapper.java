package com.shopping.mapper;

import com.shopping.dto.AmazonS3Dto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AmazonS3Mapper {

    /**
     * 파일 업로드 DB 저장
     */
    public int saveFile(List<AmazonS3Dto> amazonS3Dtos);

    /**
     * 업로드 파일 삭제
     */
    public int deleteFile(String fileName);

    /**
     * 업로드 된 파일 조회
     */
    public List<AmazonS3Dto> selectFile(Long boardIdx);
}
