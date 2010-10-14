# language: ru
Функционал: Создание рекламной компании
  Для продвижения своих услуг и товаров
  Бизнес пользователь
  Создает и регистрирует свою рекламную компанию
  
  # Предыстория:
  #   Допустим пользователь уже создал QR коды:
  #     | type      | origin   | text                   | tel            |
  #     | link_code | drive.ru |                        |                |
  #     | sms_code  |          | Акционный код: 337788  | +380978053300  |
  #   Допустим пользователь уже создал Short адрес:
  #     | origin   |  short |
  #     | drive.ru |  AbCdf |
  # 
  #   @javascript
  #   Сценарий: Пользователь составляет рекламную компанию с уже созданных элементов
  #     Допустим я захожу на /campaigns/new
  #     Тогда я должен увидеть "Создать компанию"
  #     Когда я кликну "Выбрать" внутри "#shorteners_wizard"
  #     То я должен увидеть список ранее созданых Short адресов
  #     И когда я выбираю адрес "drive.ru" из списка
  #     Тогда я должен увидеть Short адрес:
  #       | origin       | http://drive.ru |
  #     Когда я кликну "Выбрать" внутри "#codes_wizard"
  #     То я должен увидеть список ранее созданых QR кодов
  #     И когда я выбираю код "drive.ru" из списка
  #     Тогда я должен увидеть QR код:
  #       | type | link_code |
  #     Когда я заполню "campaign_title" значением "Реклама для drive.ru"
  #     И нажму "сохранить компанию" внутри "#campaign_form"
  #     Тогда я должен увидеть сообщение "Компания 'Реклама для drive.ru' была успешно создана"
  # 
  #   @javascript
  #   Сценарий: Пользователь создает новые компоненты и присоединяет их к новой компании
  #     Допустим я захожу на /campaigns/new
  #     Тогда я должен увидеть "Создать компанию"
  #     Когда я кликну "Создать" внутри "#shorteners_wizard"
  #     Тогда я заполню "short_url_origin" значением "smotra.ru"
  #     И нажму "создать ссылку"
  #     Тогда я должен увидеть Short адрес:
  #       | origin       | http://smotra.ru |
  #     Когда я кликну "Создать" внутри "#codes_wizard"
  #     Тогда я кликну на "смс-сообщение"
  #     И заполню "sms_code_tel" значением "+380978053300"
  #     И заполню "sms_code_text" значением "272727"
  #     И нажму "создать код" внутри "#sms_form"
  #     Тогда я должен увидеть QR код:
  #       | type | sms_code |
  #     Когда я заполню "campaign_title" значением "Реклама для smotra.ru"
  #     И нажму "сохранить компанию" внутри "#campaign_form"
  #     Тогда я должен увидеть сообщение "Компания 'Реклама для smotra.ru' была успешно создана"
  # 
  #   Сценарий: Пользователь пытается сохранить не заполненую форму
  #     Допустим я захожу на /campaigns/new
  #     Тогда я должен увидеть "Создать компанию"
  #     Когда я заполню "campaign_title" значением "Просто проверяем"
  #     И нажму "сохранить компанию" внутри "#campaign_form"
  #     Тогда я должен увидеть сообщение "Для создания компании нужно задать: Мобильный сайт или Короткий адрес и QR код"
