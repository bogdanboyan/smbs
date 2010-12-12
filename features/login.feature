# language: ru
Функционал: Авторизация пользователя
Я как пользователь который принадлежит к "business", "reseller" или "yamco" аккаунту
Должен пройти процес авторизации
Для того чтоб иметь возможность использовать сервис

  @javascript
  Сценарий: Пользователь неверно указывает свои данные
    Допустим существует аккаунт типа "business"
    И пользователь "alex@yam.co.ua" c паролем "yamco!"
    
    Когда я захожу на /login
    Тогда я должен увидеть "Авторизация пользователя"
    И я должен увидеть "введите свой email:" 
    И я должен увидеть "введите пароль:"
    И я должен увидеть "запомнить меня"
    Когда я нажму "Войти"
    Тогда я должен увидеть "Пожалуйста укажите свой email и пароль"
    
    Когда я захожу на /login
    И я заполню "user_session_email" значением "abc@abc.com"
    И нажму "Войти"
    Тогда я должен увидеть "Пароль не указан"
    
    Когда я захожу на /login
    И я заполню "user_session_email" значением "abc@abc.com"
    И я заполню "user_session_password" значением "abc"
    И нажму "Войти"
    Тогда я должен увидеть "Такой почтовый адрес не зарегистрирован, либо пароль неверный"

  Сценарий: Пользователь "business" аккаунта успешно авторизирует себя
    Допустим существует аккаунт типа "business"
    И пользователь "alex@yam.co.ua" c паролем "yamco!"
    
    Когда я захожу на /login
    И я заполню "user_session_email" значением "alex@yam.co.ua"
    И я заполню "user_session_password" значением "yamco!"
    И я нажму "Войти"
    Тогда я должен находиться по адресу /business/dashboard
    К тому же я должен увидеть "Раздел на стадии разработки"

  Сценарий: Пользователь "reseller" аккаунта успешно авторизирует себя
    Допустим существует аккаунт типа "reseller"
    И пользователь "alex@yam.co.ua" c паролем "yamco!"
    
    Когда я захожу на /login
    И я заполню "user_session_email" значением "alex@yam.co.ua"
    И я заполню "user_session_password" значением "yamco!"
    И я нажму "Войти"
    Тогда я должен находиться по адресу /reseller/dashboard
    К тому же я должен увидеть "Раздел на стадии разработки"
  
  Сценарий: Пользователь "yamco" аккаунта успешно авторизирует себя
    Допустим существует аккаунт типа "yamco"
    И пользователь "alex@yam.co.ua" c паролем "yamco!"
    
    Когда я захожу на /login
    И я заполню "user_session_email" значением "alex@yam.co.ua"
    И я заполню "user_session_password" значением "yamco!"
    И я нажму "Войти"
    Тогда я должен находиться по адресу /admin/dashboard
    К тому же я должен увидеть "Раздел на стадии разработки"

