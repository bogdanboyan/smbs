module BarcodesHelper
  
  def bar_code_title(bar_code)
    case(bar_code)
      when LinkCode then "ссылка на сайт: <strong>%s</strong>" % bar_code.origin
      when SmsCode  then "смс сообщение на номер %s с текстом: %s" % [bar_code.tel, bar_code.text]
      when TextCode then "текст: <strong>%s</strong>" % bar_code.text
    end
  end
end
