package com.testproject.security;

import com.testproject.security.controllers.RegistrationController;
import com.testproject.security.dtos.RegistrationUserDto;
import com.testproject.security.exceptions.AppErorr;
import com.testproject.security.repository.RoleRepository;
import com.testproject.security.repository.UserRepository;
import com.testproject.security.service.UserService;
import org.junit.Assert;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootTest
public class RegistrationServiceTest {
    private static RegistrationController registrationController;
    private static UserService userService;
    private static PasswordEncoder passwordEncoder;
    private static UserRepository userRepository;
    private static RoleRepository roleRepository;


    // RegistrationUserDto for testing
    private static RegistrationUserDto userWithDiffPassword;
    private static RegistrationUserDto goodUser;
    private static RegistrationUserDto emptyUser;

    // For init services & users for testing
    @BeforeAll
    public static void init() {
        // init users
        userWithDiffPassword = new RegistrationUserDto(
                "testUser1", "password1", "password2", "testUser@gmail.com"
        );

        goodUser = new RegistrationUserDto(
                "testUser2", "passwordTEST", "passwordTEST", "r.shalgin@gmail.com"
        );

        emptyUser = new RegistrationUserDto(
                null, null, null, null
        );


        // Init modules

        userService = new UserService(
                userRepository, roleRepository
        );

        registrationController = new RegistrationController(
                userService, passwordEncoder
        );
    }

    @Test
    public void passwordsNotMatches() {
        ResponseEntity<?> response = registrationController.registration(userWithDiffPassword);
        AppErorr error = (AppErorr) response.getBody();

        Assert.assertEquals(400, error.getStatus());
        Assert.assertEquals("Пароли не совпадают", error.getMessage());
    }

    @Test
    public void successRegistrationTest() {
        ResponseEntity<?> response = registrationController.registration(goodUser);
        String message = response.toString();

        Assert.assertEquals("Успешная регистрация", message);

        // После успешной регистрации, мы должны удалить пользователя
        userService.deleteByUsername(goodUser.getUsername());
    }

    @Test
    public void emptyUserTest() {
        ResponseEntity<?> response = registrationController.registration(emptyUser);
        AppErorr error = (AppErorr) response.getBody();

        Assert.assertEquals("Все поля должны быть заполнены!", error.getMessage());
    }
}
