# encoding:utf-8
class InviteController < ApplicationController
  
  before_filter :require_no_user
  
  def create
    invite = Invite.create(params[:invite])
    if is_saved = invite.save
      message = "Ваша заявка принята. Мы обязательно с вами свяжемся."
    else
      message = "Пожалуйста заполните все поля правильно!"
    end
    
    render :json => { :message => message, :error => !is_saved }
  end
  
end
