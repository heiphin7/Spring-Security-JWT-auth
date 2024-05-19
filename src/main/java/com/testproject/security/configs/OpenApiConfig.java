package com.testproject.security.configs;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.info.Contact;
import io.swagger.v3.oas.annotations.info.Info;

// Настройки для отображения Swagger-ui
@OpenAPIDefinition(
        info = @Info(
                title = "Spring-Security JWT API",
                description = "API, предназначенное для аунтентификации пользователь и получения JWT токена",
                contact = @Contact(
                        name = "@heiphin7",
                        email = "r.shalgin@gmail.com"
                ),
                version = "v1"
        )
)
public class OpenApiConfig {
}
