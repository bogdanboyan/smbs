# language: ru
Функционал: Перенаправление запроса с короткого адреса на основной
Получив запрос на контроллер перенаправления
Система должна обработать этот запрос (собрать информацию о пользователе который отправил запрос)
И перенаправить браузер пользователя на основной адрес (с которым связан короткий адрес)

  Предыстория:
    Допустим пользователь уже создал Short адрес:
      | origin   |  short  | clicks_count |
      | ya.ru    |  yandex | 0            |

   Сценарий: Пользователь переходит по ссылке короткого адреса
    Допустим я захожу на /shorteners/yandex/redirect
    Тогда система должна зарегистрировать мой переход
    И мой запрос должен быть перенаправлен на адрес "http://ya.ru"

   Сценарий: Пользователь использует не существующий короткий адрес
     Допустим я захожу на /shorteners/xxx/redirect
     Тогда система не должна регистрировать этот запрос
     И я должен получить ошибку "404"
