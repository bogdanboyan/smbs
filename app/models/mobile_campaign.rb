# == Schema Info
#
# Table name: mobile_campaigns
#
#  id             :integer(4)      not null, primary key
#  document_model :text
#  style_model    :text
#  title          :string(255)
#  created_at     :datetime
#  updated_at     :datetime

class MobileCampaign < ActiveRecord::Base

  has_many :image_assets, :dependent => :destroy
  
  validate :document_state

  # init final state machine
  include AASM
  
  aasm_column :current_state
  aasm_initial_state :published
  
  aasm_state :published
  aasm_state :pending
  aasm_state :archived
  
  aasm_event :archive do
    transitions :to => :archived, :from => [:published, :pending]
  end
  
  aasm_event :publish do
    transitions :to => :published, :from => [:pending]
  end
  
  aasm_event :unpublish do
    transitions :to => :pending, :from => [:published]
  end


  def document_model_as(format = :json)
    case format
      when :json  then attributes['document_model']
      when :array then ActiveSupport::JSON.decode(attributes['document_model'])
      else
        raise 'unknown format: %s' % format
    end
  end


  protected
  
  def document_state
    (errors.add(:base, 'document_model is empty') && return) unless attributes['document_model']
    
    sanitized_document_model = sanitize(document_model_as(:array))
    
    (errors.add(:base, 'document_model is empty and sanitized') && return) if (!sanitized_document_model || sanitized_document_model.empty?)
    
    sanitized_document_model.each do |partial|
      type, value = partial['type'], partial['value']
      case type
        when 'images'
          value.each do |image|
            should_be_true(
              image.is_a?(Hash) && image.size == 4
            )

            should_be_true(
              image['asset_id'].is_a?(String) && image['asset_id'].to_i.is_a?(Numeric),
              image['style'].is_a?(String),
              image['width'].is_a?(String),
              image['path'].is_a?(String)
            )
          end
      end
    end #each
  end #def

  def should_be_true(*state)
    errors.add("value", "has invalid format") unless state.delete_if {|s| s}.empty?
  end

  def sanitize(document = [])
    document = document.delete_if do |partial|
      type, value = partial['type'], partial['value']
      type.nil? || type =~ /[^header|text|images]/ || value.nil? || value.empty? || sanitize_partial(type, value)
    end
    document.compact
  end

  def sanitize_partial(type, value)
    case type
        when 'images' then !value.is_a?(Array) || (value.is_a?(Array) && value.empty?)
    end
  end
  
end