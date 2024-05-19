package com.testproject.security.mapper;

import com.testproject.security.dtos.RegistrationUserDto;
import com.testproject.security.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserMapper {

    private final PasswordEncoder passwordEncoder;

    public User RegDtoToUser(RegistrationUserDto registrationUserDto) {
        // encode password for save
        String encodedPassword = passwordEncoder.encode(registrationUserDto.getPassword());
        User user = new User();
        user.setUsername(registrationUserDto.getUsername());
        user.setPassword(encodedPassword);
        user.setEmail(registrationUserDto.getEmail());
        return user;
    }

}
