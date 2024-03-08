package com.testproject.security.service;

import com.testproject.security.entity.User;
import com.testproject.security.repository.RoleRepository;
import com.testproject.security.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService {
    /*
    * Внедряем зависимости (Dependency Injection) используя конструкторы класса
    * Конструкторы класса использует от Lombok
    */

    // здесь, final потому, что мы используем аннотацию @RequiredArgsConstructor
    // который создает конструкторы final - переменных
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    public Optional<User> findByUsername(String username){
        return userRepository.findByUsername(username);
    }

    /*
    * Раз уж мы имплементировали UserDetailService, мы должны
    * реализовать его метод loadUserByUsername
    * данный метод должен возвращать User, только не наш User в entitites
    * а UserDetails от Spring-a
    *
    * Я не буду особо использовать данный метод, это нужно для Spring-a
    */
    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException{

        // Используем наш метод findByUsername в этом же классе
        // Если находим то просто записываем его в User
        User user = findByUsername(username)
                // А если мы не находим, тогда выбрасываем исключение UsernameNotFoundException
                .orElseThrow(() -> new UsernameNotFoundException(
                        // И выводим соответсвующее сообщение
                        String.format("Пользователь с именем '%s' не найден", username)
                )
        );
        /*
         *Если же мы находим пользователя, то мы должны преобразовать его
         */
        return new org.springframework.security.core.userdetails.User(
                user.getUsername(),
                user.getPassword(),

                /*
                 Также для User-а от Spring-a нам нужен список SimpleGrantedAuthority (список ролей пользователя)
                 Для этого используем stream api, для того чтобы пробегаться по ролям пользователя
                 и собрать это в список под SimpleGrantedAuthority
                 */

                user.getRoles().stream().map(
                        role -> new SimpleGrantedAuthority(role.getName())
                ).collect(Collectors.toList())
        );
    }

    public void createNewUser(User user){
        /*
        * Делаем простую проверку пользователя
        * Условия для создания:
        * Username должен содержать 8 или более символов
        * Password просто не должен быть пустым и должен быть больше 8 символов даже если это хэш
        * Roles (роли пользователя) не должен быть пустым и не должен ссылаться на null
        */
        if(user.getUsername().length() < 8 || user.getPassword().length() < 8
                ||user.getRoles() == null || !user.getRoles().isEmpty()){
            throw new IllegalArgumentException("Неверные данные пользователя");
        }else {
            // Если все норм, тогда просто сохраняем, используя метод репозитория
            userRepository.save(user);
        }
    }
}
