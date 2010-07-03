Feature: Create short links
  As I business
  I want to create short url links
  So I can see visitors analytic information

  Background:
    Given short urls for business:
    | origin   |  short | clicks_count |
    | ya.ru    |  AbC   | 2            |
    | bit.ly   |  DeF   | 3            |


  Scenario: Business views "Create Short Url" page
    Given I go to /shorteners
    Then I should see "Создать короткий адрес"
    And  I should see "Преобразованые ссылки"
    And  I should see short links:
    | origin          |  short | clicks_count |
    | http://ya.ru    |  AbC   | 2            |
    | http://bit.ly   |  DeF   | 3            |

  @javascript
  Scenario: Business wants create short link
    Given I am on /shorteners
    Then  I should see "введите адрес который нужно сократить:"
    And   I fill in "short_url_origin" with "korrespondent.net"
    And   I press "создать ссылку"
    And   I should see new short links:
    | origin                      | clicks_count |
    | http://korrespondent.net    | 0            |

  @javascript
  Scenario: Business tries create short link
    Given I am on /shorteners
    And  I fill in "short_url_origin" with ""
    And   I press "создать ссылку"
    Then I should see message "Укажите требуемый адрес для преобразования"
    And  I fill in "short_url_origin" with "http://"
    And   I press "создать ссылку"
    Then I should see message "Нужно указать правильный адрес ресурса"
    

