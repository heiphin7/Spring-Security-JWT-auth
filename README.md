# Spring-Security-JWT-Auth

# Project architecture

![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/project%20architecture.png)

# Коротко о API

Данный проект - простое REST - приложение, которые выполняет функцию входа в аккаунт, а также аутентификации пользователя и генерирует JWT токен для пользователя, успешно прошедшего аутентификацию.
Использовал:
Spring boot, Spring security, postgresql, postman(тестирование api), jjwt (для jwt), lombok

# Из чего состоит JWT токен:

 Как мы знаем, JWT токен состоит из 3 - ех частей: Header, payload, signature (заголовок, полезная нагрузка, подпись)
 В данном случае, в payload (полезная нагрзука) содержит в себе: subject (username), roles , iat (issued at), exp (expiration date)

# Логика программы & Генерация JSON Web Token

Так как это API, то это значит что сервис не имеент интерфейса, а лишь обрабатывает HTTP - запросы. Здесь, API принимает только GET - запрос по 
URL /auth, в который пользователь должен ввести свой username и password. Далее, эти данные обрабатываются AuthController, а точнее его методом
AuthenticationManager.autenticate(username, password) - как это описано в коде. AuthenticationManager - Бин, который мы описали в SecurityConfig.

Итак, мы примерно понимаем как мы аутентифицируем пользователя, и после успешной аутентификации, мы должны сгенерировать для него JWT токен, и вот как это
происходит:

Для генерации нам нужны следующие данные: secret (секрет, который используется для подписи), lifetime (время действия токена) и такие данные как 
роли пользователя и его имя.

Всю подробную реализацию этих методов вы можете увидеть в классе JwtTokenUtils

# Тестирование и Демонстрация API

Случай успешного прохождения аутентификации:

![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/GetToken.png)


Случай, когда данные неверные:

![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/ErrorMessage.png)
