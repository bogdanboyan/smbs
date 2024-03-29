# language: ru
Функционал: Перенаправление запроса с короткого адреса на основной
Получив запрос на контроллер перенаправления
Система должна обработать этот запрос (собрать информацию о пользователе который отправил запрос)
И перенаправить браузер пользователя на основной адрес (с которым связан короткий адрес)

Предыстория:
  Допустим я не перехожу по ссылкам перенаправления
  И "business" пользователь уже существует
  К тому же пользователь уже создал Short адрес:
    | origin              |  short        | current_state | clicks_count |
    | bbc.co.uk           |  2Bc          | proxied       | 0            |
    | ya.ru               |  yandex       | proxied       | 0            |
    | amoterra.com.ua     |  amoterra.tel | proxied       | 0            |
    | smotra.ru           |  smotra       | pending       | 0            |

Сценарий: Пользователь переходит по активной ссылке (2Bc)
  Допустим я захожу на /shorteners/2Bc/redirect
  Тогда количество переходов по короткому адресу "2Bc" должно быть "1"
  И мой запрос должен быть перенаправлен на адрес "http://bbc.co.uk"

Сценарий: Пользователь переходит по активной ссылке (yandex)
  Допустим я захожу на /shorteners/yandex/redirect
  Тогда количество переходов по короткому адресу "yandex" должно быть "1"
  И мой запрос должен быть перенаправлен на адрес "http://ya.ru"

Сценарий: Пользователь переходит по активной ссылке (amoterra.tel)
  Допустим я захожу на /shorteners/amoterra.tel/redirect
  Тогда количество переходов по короткому адресу "amoterra.tel" должно быть "1"
  И мой запрос должен быть перенаправлен на адрес "http://amoterra.com.ua"

Сценарий: Пользователь переходит по ссылке доступ к которой ограничен
  Допустим я захожу на /shorteners/smotra/redirect
  Тогда количество переходов по короткому адресу "smotra" должно быть "0"
  И мой запрос должен быть перенаправлен на адрес "mobile_app/shorteners/is_pending"

Сценарий: Пользователь использует не существующий короткий адрес
  Допустим я захожу на /shorteners/xxx/redirect
  Тогда количество переходов по короткому адресу "xxx" должно быть "0"
  И мой запрос должен быть перенаправлен на адрес "mobile_app/shorteners/not_found"

