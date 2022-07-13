package com.shopping.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.*;
import com.exception.CustomException;
import com.exception.ErrorCode;
import com.shopping.dto.AmazonS3Dto;
import com.shopping.mapper.AmazonS3Mapper;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

@Service
@RequiredArgsConstructor
public class AwsS3Service {

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    private final AmazonS3 amazonS3;

    private final AmazonS3Mapper amazonS3Mapper;

    /**
     * 파일 업로드 처리
     * @param multipartFile
     * @return
     */
    public List<AmazonS3Dto> uploadFile(List<MultipartFile> multipartFile, Long boardIdx) {
        List<AmazonS3Dto> fileNameList = new ArrayList<>();

        // forEach 구문을 통해 multipartFile로 넘어온 파일들 하나씩 fileNameList에 추가
        multipartFile.forEach(file -> {
            String orgName = file.getOriginalFilename();
            String fileName = createFileName(orgName);

            ObjectMetadata objectMetadata = new ObjectMetadata();
            objectMetadata.setContentLength(file.getSize());
            objectMetadata.setContentType(file.getContentType());

            // AWS S3 파일 업로드
            try(InputStream inputStream = file.getInputStream()) {
                amazonS3.putObject(new PutObjectRequest(bucket, fileName, inputStream, objectMetadata)
                        .withCannedAcl(CannedAccessControlList.PublicRead));

                // DB에 업로드한 파일 정보저장
                AmazonS3Dto amzon = new AmazonS3Dto();
                amzon.setBoardIdx(boardIdx);
                amzon.setOriginalName(orgName);
                amzon.setSaveName(fileName);
                amzon.setFilePath(amazonS3.getUrl(bucket, fileName).toString());
                amzon.setSize((int) objectMetadata.getContentLength());
                amzon.setType(objectMetadata.getContentType());

                fileNameList.add(amzon);

            } catch (IOException e) {
                throw new CustomException(ErrorCode.INTERNAL_FILE_SERVER_ERROR);
            }
        });

        if(fileNameList != null && !fileNameList.isEmpty()) {
            amazonS3Mapper.saveFile(fileNameList);
        }

        return fileNameList;
    }

    /**
     * 파일 삭제처리
     * @param fileName
     */
    public boolean deleteFile(String fileName) {
        int result = 0;

        try {
            amazonS3.deleteObject(new DeleteObjectRequest(bucket, fileName));
            result = amazonS3Mapper.deleteFile(fileName);
        } catch (AmazonS3Exception e) {
            throw new CustomException(ErrorCode.INTERNAL_FILE_DELETE_SERVER_ERROR);
        }

        return (result == 1) ? true : false;
    }

    private String createFileName(String fileName) { // 먼저 파일 업로드 시, 파일명을 난수화하기 위해 random으로 돌립니다.
        return UUID.randomUUID().toString().concat(getFileExtension(fileName));
    }

    private String getFileExtension(String fileName) { // file 형식이 잘못된 경우를 확인하기 위해 만들어진 로직이며, 파일 타입과 상관없이 업로드할 수 있게 하기 위해 .의 존재 유무만 판단하였습니다.
        try {
            return fileName.substring(fileName.lastIndexOf("."));
        } catch (StringIndexOutOfBoundsException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "잘못된 형식의 파일(" + fileName + ") 입니다.");
        }
    }

    /**
     * 파일 조회
     */
    public List<AmazonS3Dto> getFileList(Long boardIdx) {
        List<AmazonS3Dto> fileList = amazonS3Mapper.selectFile(boardIdx);

        if (fileList.isEmpty()) {
            return Collections.emptyList();
        }

        return fileList;
    }
}
