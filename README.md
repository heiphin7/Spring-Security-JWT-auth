# Spring-Security-JWT-Auth

# Project design

Логика получения токена (после входа в аккаунт):

![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/project%20architecture.png)

Логика создания нового пользователя: 

![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-03-10%20205039.png)


# Коротко о API

Данный проект - простое REST - приложение, которые выполняет функцию входа в аккаунт, создание аккаунта(регистрация) а также аутентификации пользователя и генерация JWT токен для пользователя, успешно прошедшего аутентификацию. Проект имеет достаточно хорошую безопастность, потому что использует Spring security и хэширование паролей и использование токенов, таких как JWT. Но в проекте не реализована логика использования 
самого JWT. 

Было использовано:
Spring boot, Spring security, Hibernate ,postgresql, postman(тестирование api), jjwt (для jwt), lombok

# Из чего состоит JWT токен:

 Как мы знаем, JWT токен состоит из 3 - ех частей: Header, payload, signature (заголовок, полезная нагрузка, подпись)
 В данном случае, в payload (полезная нагрзука) содержит в себе: subject (username), roles , iat (issued at), exp (expiration date)

# Логика программы & Генерация JSON Web Token

Так как это API, то это значит что сервис не имеент интерфейса, а лишь обрабатывает HTTP - запросы. Здесь, API принимает только GET - запрос по 
URL /auth и /reg, в который пользователь должен ввести свой username и password для авторизации и username, password, email для регистрации. 
Далее, эти данные обрабатываются AuthController и RegistrationController.

Для аутентификации мы используем метод от самого Spring security, а точнее authenticate. А для регистрации нового пользователя, мы используем метод 
save нашего UserRepository.

Итак, мы примерно понимаем как мы аутентифицируем пользователя, и после успешной аутентификации, мы должны сгенерировать для него JWT токен, и вот как это
происходит:

Для генерации нам нужны следующие данные: secret (секрет, который используется для подписи), lifetime (время действия токена) и такие данные как 
роли пользователя и его имя.

Всю подробную реализацию этих методов вы можете увидеть в классе JwtTokenUtils

# Тестирование и Демонстрация API

registration-controller

POST
/reg

auth-controller

POST
/auth

main-controller

GET
/users/{id}

GET
/unsecured

GET
/secured

GET
/info

GET
/admin

Все данные endpoint-ы можете просмотреть в swagger ui при локальном запуске: localhost:{port}/swagger-ui/index.html


