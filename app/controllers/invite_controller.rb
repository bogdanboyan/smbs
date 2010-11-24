# encoding:utf-8
class InviteController < ApplicationController
  
  def create
    invite = Invite.create(params[:invite])
    if invite.save
      flash[:notice] = "Ваша заявка принята :) Мы обязательно с вами свяжемся"
    else
      flash[:error] = "#{invite.errors.full_messages.join(', ')}. Пожайлуста заполните все поля правильно"
    end
    
    redirect_to root_url
  end
  
end
