# encoding: utf-8
module Validations::Url

  def prepare_and_parse_url
    generic_error_msg = "Нужно указать правильный адрес ресурса"
    if self.origin.empty?
      errors.add_to_base("Укажите требуемый адрес для преобразования")
    elsif self.origin.match(/(\w+):\/\/(.+)?/)
      schema, domain = $1, $2
      errors.add_to_base(generic_error_msg) unless schema.match(/(http|https|ftp)/)
      errors.add_to_base(generic_error_msg) unless domain
      errors.add_to_base(generic_error_msg) if     domain and domain.match(/:\/\//)
    else
      self.origin = "http://#{origin}"
    end
    errors.add_to_base(generic_error_msg) unless self.origin.match(URI.regexp)
  end

end