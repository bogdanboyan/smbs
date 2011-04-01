# language: ru
Функционал: Отображение списка Мобильных Страниц аккаунта
Я как бизнес хочу иметь возможность видеть список всех моих компаний, которые существуют в системе


  Предыстория:
    Допустим "business" пользователь уже авторизирован
    К тому же пользователь уже создал Mobile Campaign под названием "mobile_campaign"
  
  
  Сценарий: Пользователь должен увидеть список ранее созданых мобильных страниц
    Допустим я захожу на /mobile/campaigns
    И я должен увидеть "Мобильные страницы"
    И я должен увидеть "Создать Мобильную Страницу"
    К тому же я должен увидеть в списке Mobile Campaign c названием "Новый браузер Chrome"
    
  @javascript
  Сценарий: Пользователь кликает "Создать Мобильную Страницу"
    Допустим я захожу на /mobile/campaigns
    Когда я кликну "Создать Мобильную Страницу"
    Тогда я должен увидеть Mobile Campaign страницу "Новая страница"
  
  @javascript
  Сценарий: Пользователь кликает "Редактировать" для ранее созданой мобильной странице
    Допустим я захожу на /mobile/campaigns
    Когда я кликну "Редактировать" для страницы "Новый браузер Chrome"
    Тогда я должен увидеть Mobile Campaign страницу "Редактировать"
  
  @javascript
  Сценарий: Пользователь кликает "Настройки" для ранее созданой мобильной странице
    Допустим я захожу на /mobile/campaigns
    Когда я кликну "Настройки" для страницы "Новый браузер Chrome"
    Тогда я должен увидеть Mobile Campaign страницу "Настройки"
  
  
  Сценарий: Пользователь нажимает "Архивировать" для ранее созданой мобильной странице