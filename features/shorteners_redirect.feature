# language: ru
Функционал: Перенаправление запроса с короткого адреса на основной
Получив запрос на контроллер перенаправления
Система должна обработать этот запрос (собрать информацию о пользователе который отправил запрос)
И перенаправить браузер пользователя на основной адрес (с которым связан короткий адрес)

  Предыстория:
    Допустим я не перехожу перехожу по ссылкам перенаправления
    И "business" пользователь уже существует
    К тому же пользователь уже создал Short адрес:
      | origin    |  short  | current_state | clicks_count |
      | ya.ru     |  yandex | proxied       | 0            |
      | smotra.ru |  smotra | pending       | 0            |

   Сценарий: Пользователь переходит по активной ссылке
    Допустим я захожу на /shorteners/yandex/redirect
    Тогда система должна зарегистрировать мой переход
    И мой запрос должен быть перенаправлен на адрес "http://ya.ru"

   Сценарий: Пользователь переходит по активной ссылке
    Допустим я захожу на /shorteners/smotra/redirect
    Тогда система не должна регистрировать этот запрос
    И мой запрос должен быть перенаправлен на адрес "mobile_app/shorteners/is_pending"

   Сценарий: Пользователь использует не существующий короткий адрес
     Допустим я захожу на /shorteners/xxx/redirect
     Тогда система не должна регистрировать этот запрос
     И мой запрос должен быть перенаправлен на адрес "mobile_app/shorteners/not_found"

