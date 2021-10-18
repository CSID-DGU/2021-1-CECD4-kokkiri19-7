package com.example.service;


import com.example.domain.User;
import com.example.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;

    //회원가입
    @Transactional
    public Long join(User user) {
        if (validateDuplicateUser(user) == true) {
            //회원정보가 없을 때 회원가입
            userRepository.save(user);
        }
        return user.getId();
    }

    public User findUserById(Long id){
        return userRepository.findOne(id);
    }

    //false = 이미 존재 , true = 없음
    private boolean validateDuplicateUser(User user) {
        List<User> findUser = userRepository.findByNickname(user.getNickname());
        if (!findUser.isEmpty()) {
            return false;
        }
        return true;
    }
}
