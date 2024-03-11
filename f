[1mdiff --git a/README.md b/README.md[m
[1mindex 9aae2ad..56528d0 100644[m
[1m--- a/README.md[m
[1m+++ b/README.md[m
[36m@@ -2,13 +2,22 @@[m
 [m
 # Project architecture[m
 [m
[32m+[m[32mЛогика получения токена (после входа в аккаунт):[m
[32m+[m
 ![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/project%20architecture.png)[m
 [m
[32m+[m[32mЛогика создания нового пользователя:[m[41m [m
[32m+[m
[32m+[m[32m![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024-03-10%20205039.png)[m
[32m+[m
[32m+[m
 # Коротко о API[m
 [m
[31m-Данный проект - простое REST - приложение, которые выполняет функцию входа в аккаунт, а также аутентификации пользователя и генерирует JWT токен для пользователя, успешно прошедшего аутентификацию.[m
[31m-Использовал:[m
[31m-Spring boot, Spring security, postgresql, postman(тестирование api), jjwt (для jwt), lombok[m
[32m+[m[32mДанный проект - простое REST - приложение, которые выполняет функцию входа в аккаунт, создание аккаунта(регистрация) а также аутентификации пользователя и генерация JWT токен для пользователя, успешно прошедшего аутентификацию. Проект имеет достаточно хорошую безопастность, потому что использует Spring security и хэширование паролей и использование токенов, таких как JWT. Но в проекте не реализована логика использования[m[41m [m
[32m+[m[32mсамого JWT.[m[41m [m
[32m+[m
[32m+[m[32mБыло использовано:[m
[32m+[m[32mSpring boot, Spring security, Hibernate ,postgresql, postman(тестирование api), jjwt (для jwt), lombok[m
 [m
 # Из чего состоит JWT токен:[m
 [m
[36m@@ -18,8 +27,11 @@[m [mSpring boot, Spring security, postgresql, postman(тестирование api),[m
 # Логика программы & Генерация JSON Web Token[m
 [m
 Так как это API, то это значит что сервис не имеент интерфейса, а лишь обрабатывает HTTP - запросы. Здесь, API принимает только GET - запрос по [m
[31m-URL /auth, в который пользователь должен ввести свой username и password. Далее, эти данные обрабатываются AuthController, а точнее его методом[m
[31m-AuthenticationManager.autenticate(username, password) - как это описано в коде. AuthenticationManager - Бин, который мы описали в SecurityConfig.[m
[32m+[m[32mURL /auth и /reg, в который пользователь должен ввести свой username и password для авторизации и username, password, email для регистрации.[m[41m [m
[32m+[m[32mДалее, эти данные обрабатываются AuthController и RegistrationController.[m
[32m+[m
[32m+[m[32mДля аутентификации мы используем метод от самого Spring security, а точнее authenticate. А для регистрации нового пользователя, мы используем метод[m[41m [m
[32m+[m[32msave нашего UserRepository.[m
 [m
 Итак, мы примерно понимаем как мы аутентифицируем пользователя, и после успешной аутентификации, мы должны сгенерировать для него JWT токен, и вот как это[m
 происходит:[m
[36m@@ -31,6 +43,8 @@[m [mAuthenticationManager.autenticate(username, password) - как это описа[m
 [m
 # Тестирование и Демонстрация API[m
 [m
[32m+[m[32mДалее идут демонстрации Авторизации и создания нового пользователя[m
[32m+[m
 Случай успешного прохождения аутентификации:[m
 [m
 ![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/GetToken.png)[m
[36m@@ -39,3 +53,25 @@[m [mAuthenticationManager.autenticate(username, password) - как это описа[m
 Случай, когда данные неверные:[m
 [m
 ![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/ErrorMessage.png)[m
[32m+[m
[32m+[m
[32m+[m[32m# Регистрация нового пользователя[m
[32m+[m
[32m+[m[32mУспешное создание нового пользователя[m
[32m+[m
[32m+[m[32m![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/SuccessRegistration.png)[m
[32m+[m
[32m+[m
[32m+[m[32mСлучай, когда юзер пытается зарегистрировать пользователя с занятым именем[m
[32m+[m
[32m+[m[32m![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/usernameIsTakenExcep.png)[m
[32m+[m
[32m+[m
[32m+[m[32mКогда не совпадают пароль и подтверждение[m
[32m+[m
[32m+[m[32m![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/WrongPasswordException.png)[m
[32m+[m
[32m+[m
[32m+[m[32mПользователь пытается отпавить пустой пароль[m
[32m+[m
[32m+[m[32m![Image alt](https://github.com/heiphin7/Spring-Security-JWT-Auth/blob/main/img/EmptyPasswordException.png)[m
[1mdiff --git a/img/EmptyPasswordException.png b/img/EmptyPasswordException.png[m
[1mnew file mode 100644[m
[1mindex 0000000..e547381[m
Binary files /dev/null and b/img/EmptyPasswordException.png differ
[1mdiff --git a/img/SuccessRegistration.png b/img/SuccessRegistration.png[m
[1mnew file mode 100644[m
[1mindex 0000000..33b04cd[m
Binary files /dev/null and b/img/SuccessRegistration.png differ
[1mdiff --git a/img/WrongPasswordException.png b/img/WrongPasswordException.png[m
[1mnew file mode 100644[m
[1mindex 0000000..114f947[m
Binary files /dev/null and b/img/WrongPasswordException.png differ
[1mdiff --git a/img/usernameIsTakenExcep.png b/img/usernameIsTakenExcep.png[m
[1mnew file mode 100644[m
[1mindex 0000000..36ce282[m
Binary files /dev/null and b/img/usernameIsTakenExcep.png differ
[1mdiff --git "a/img/\320\241\320\275\320\270\320\274\320\276\320\272 \321\215\320\272\321\200\320\260\320\275\320\260 2024-03-10 205039.png" "b/img/\320\241\320\275\320\270\320\274\320\276\320\272 \321\215\320\272\321\200\320\260\320\275\320\260 2024-03-10 205039.png"[m
[1mnew file mode 100644[m
[1mindex 0000000..f98df8c[m
Binary files /dev/null and "b/img/\320\241\320\275\320\270\320\274\320\276\320\272 \321\215\320\272\321\200\320\260\320\275\320\260 2024-03-10 205039.png" differ
