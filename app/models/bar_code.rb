class BarCode < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :user
  
  before_save  :encode_code_source
  after_create :save_image_boundle
  
  scope :unbound, where(:campaign_id => nil)
  
  
  include Dashboardable
  
  
  def encode_code_source
    BarbyBarcode.encode_svg(self)
  end

  def save_image_boundle
    BarbyBarcode.encode_png_boundles(self)
  end
end
