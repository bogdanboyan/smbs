# encoding: utf-8
include  ApplicationHelper, ActionController::RecordIdentifier


Допустим /^(?:|пользователь|бизнес) уже создал Mobile Campaign под названием "([^\"]*)"$/ do |factory_name|
  Допустим %Q(пользователь "#{current_user.email}" уже создал Mobile Campaign под названием "#{factory_name}")
end

Допустим /^пользователь "([^\"]*)" уже создал Mobile Campaign под названием "([^\"]*)"$/ do |email, factory_name|
  AssetFile.destroy_all
  user = User.find_by_email(email)
  
  @mobile_campaign = Factory.create(factory_name, :user => user, :account => user.account)
end


Допустим /^я должен увидеть в списке Mobile Campaign c названием "([^\"]*)"$/ do |campaign_title|
  mobile_campaign = MobileCampaign.find_by_title campaign_title
  
  within('.history_item') do
    page.should have_content(I18n.l(mobile_campaign.created_at.to_date, :format => :short))
    page.should have_content(mobile_campaign.title)
    
    page.should have_link('Редактировать')
    page.should have_link('Настройки')
    page.should have_link('Архивировать')
  end
end

Когда /^я кликну "([^"]*)" для страницы "([^"]*)"$/ do |member, campaign_title|
  @mobile_campaign = MobileCampaign.find_by_title campaign_title
  
  with_scope '#' + dom_id(@mobile_campaign) do
    click_link(member)
  end
end

Тогда /^я должен увидеть Mobile Campaign страницу "([^\"]*)"$/ do |member|
  case member
  when "Новая страница" then specify_new_mobile_campaign_page
  when "Редактировать"  then specify_edit_mobile_campaign_page
  when "Настройки"      then specify_settings_mobile_campaign_page
  else raise "Can't find assertion for '#{member}' page"
  end
end

def specify_new_mobile_campaign_page
  page.should have_field('title')
  
  page.should have_link('Сохранить')
  page.should have_link('Закрыть')
  page.should have_link('Настройки')
  
  with_scope '#document_partials' do
    page.should have_content('Заголовок')
    page.should have_content('Текстовый блок')
    page.should have_content('Изображения')
  end
end

def specify_edit_mobile_campaign_page
  page.should have_field('title')
  
  page.should have_link('Обновить')
  page.should have_link('Закрыть')
  page.should have_link('Настройки')
end

def specify_settings_mobile_campaign_page
  page.should have_field('title')
  
  page.should have_link('Редактировать')
  page.should have_link('Закрыть')

  page.should have_xpath("//iframe[@id='preview_frame']")
end
