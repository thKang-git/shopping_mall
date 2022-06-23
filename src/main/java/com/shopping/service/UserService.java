package com.shopping.service;

import com.shopping.domain.User;
import com.shopping.domain.UserRepository;
import com.shopping.dto.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.dao.DataAccessException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@RequiredArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder encoder;

    @Transactional
    public Long join(UserDto userDto) {
        Long result = null;

        // 사용자 비밀번호를 해쉬 암호화 처리 후 레파지토리에 저장
        userDto.setPassword(encoder.encode(userDto.getPassword()));

        try {
            result = userRepository.save(userDto.toEntity()).getId();

        } catch (DataAccessException e) {
            System.out.println("데이터베이스 오류");
            e.printStackTrace();

        } catch (Exception e) {
            System.out.println("시스템 오류");
            e.printStackTrace();
        }

        return result;
    }
}
