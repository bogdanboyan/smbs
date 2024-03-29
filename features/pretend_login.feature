# language: ru
Функционал: Администратор может зайти под именем другого пользователя
Я как администратор хочу иметь возможность зайти от имени другого пользователя
И получить возможность видеть систему глазами пользователя
Для того чтоб получить возможность управлять данными пользователя


Предыстория:
  Допустим "yamco" пользователь уже авторизирован

Сценарий: Аутентификация от имени "business" пользователя
  Допустим существует аккаунт типа "business"
  И пользователь "business@yam.co.ua" c паролем "yamco!"
  И администратор зашел от имени пользователя "business@yam.co.ua"
  К тому же я должен находиться по адресу /business/dashboard
  Когда я кликну на "Завершить просмотр"
  Тогда я должен находиться по адресу /admin/dashboard


Сценарий: Аутентификация от имени "reseller" пользователя
  Допустим существует аккаунт типа "reseller"
  И пользователь "reseller@yam.co.ua" c паролем "yamco!"
  И администратор зашел от имени пользователя "reseller@yam.co.ua"
  К тому же я должен находиться по адресу /reseller/dashboard
  Когда я кликну на "Завершить просмотр"
  Тогда я должен находиться по адресу /admin/dashboard
