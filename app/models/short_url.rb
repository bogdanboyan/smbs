# == Schema Info
# Schema version: 20100503141450
#
# Table name: short_urls
#
#  id           :integer(4)      not null, primary key
#  clicks_count :integer(4)      not null, default(0)
#  description  :text
#  origin       :string(255)     not null
#  short        :string(255)     not null
#  title        :string(255)
#  created_at   :datetime
#  updated_at   :datetime

class ShortUrl < ActiveRecord::Base
  
  has_many :clicks
  
  validate :prepare_and_parse_url
  
  def short_url(request)
    "#{request.domain}/g/#{self.short}"
  end
  
  def has_clicks?
    self.clicks_count > 0
  end
  
  protected
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
