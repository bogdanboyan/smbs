# encoding: utf-8
module QrCodesHelper
  
  def qr_code_title(qr)
    desc = case(qr)
      when LinkCode then "%s" % qr.origin.gsub('http://', '')
      when SmsCode  then "%s (%s)" % [qr.tel, qr.text]
      when TextCode then "%s" % qr.text
    end
    
    desc.mb_chars.length >= 35 ? desc.mb_chars.slice(0, 35 - 3) + '...' : desc
  end
  
  def qr_code_annotation(qr)
    qr = qr.first if qr.kind_of?(Array)
    case(qr)
      when LinkCode then "ссылка на сайт: <strong>%s</strong>" % qr.origin
      when SmsCode  then "смс сообщение на номер %s с текстом: %s" % [qr.tel, qr.text]
      when TextCode then "текст: <strong>%s</strong>" % qr.text.strip
    end
  end
  
end
