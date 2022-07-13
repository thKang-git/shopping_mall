package com.shopping.controller;

import com.shopping.dto.AmazonS3Dto;
import com.shopping.service.AwsS3Service;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/s3")
public class AmazonS3Controller {
    private final AwsS3Service awsS3Service;

    /**
     * AWS S3 파일 업로드
     * @return 성공 시 200 Success와 함께 업로드 된 파일명 리스트 반환
     */
    @PostMapping("/file")
    public ResponseEntity<List<AmazonS3Dto>> uploadFile(@RequestPart("file") List<MultipartFile> multipartFile, Long boardIdx) {
        return ResponseEntity.ok(awsS3Service.uploadFile(multipartFile, boardIdx));
    }

    /**
     * AWS S3 업로드 된 파일 삭제
     * return 삭제완료(ture) 삭제오류(false)
     */
    @DeleteMapping("/file")
    public ResponseEntity<Boolean> deleteFile(@RequestParam String fileName) {
        return ResponseEntity.ok(awsS3Service.deleteFile(fileName));
    }

    /**
     * AWS 파일 조회(DB)
     */
    @GetMapping("/file/{id}")
    public List<AmazonS3Dto> fileList(@PathVariable Long id) {
        // id = boardIdx
        return awsS3Service.getFileList(id);
    }
}
