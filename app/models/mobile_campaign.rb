# encoding: utf-8
class MobileCampaign < ActiveRecord::Base
  
  include Dashboardable
  
  # init final state machine
  include AASM
  
  aasm_column :current_state
  aasm_initial_state :draft
  
  aasm_state :draft
  aasm_state :published
  aasm_state :pending
  aasm_state :archived
  
  aasm_event :archive do
    transitions :to => :archived, :from => [ :published, :pending, :draft ],
      :on_transition => Proc.new { |mc| mc.short_url.disable! if mc.short_url.try :proxied? }
  end
  
  aasm_event :publish do
    transitions :to => :published, :from => [ :pending ],
      :on_transition => Proc.new { |mc| mc.short_url.enable! if mc.short_url.try :pending?  }
  end
  
  aasm_event :unpublish do
    transitions :to => :pending, :from => [ :published ], 
      :on_transition => Proc.new { |mc| mc.short_url.disable! if mc.short_url.try :proxied? }
  end
  
  aasm_event :request_approve do
    transitions :to => :pending, :from => [ :draft ]
  end
  
  aasm_event :cancel_response do
    transitions :to => :draft, :from => [ :pending, :published ]
  end
  
  
  # tags
  acts_as_taggable_on :cities, :places, :labels
  
  
  belongs_to :account
  belongs_to :user
  belongs_to :short_url

  has_many :like_its

  has_and_belongs_to_many :asset_files, :uniq => true do
    def only_images
      where(:type => 'ImageAsset')
    end
    
    # HACK :uniq => true doesnot works!
    def push!(*records)
      records.each{ |o| (@owner.asset_files << o) unless @owner.asset_files.include?(o) }
    end
    
  end
  
  
  after_save :map_document_model_images, :map_document_model_likeits
  before_save :disable_short_url_callback
  
  validate :document_state
  
  
  def document_model_as(format = :json)
    case format
      when :json  then attributes['document_model']
      when :array then ActiveSupport::JSON.decode(attributes['document_model'])
      else
        raise 'unknown format: %s' % format
    end
  end

  def sanitize(document = [])
    document = document.delete_if do |partial|
      type, value = partial['type'], partial['value']
      type.nil? || type =~ /[^header|text|images]/ || value.nil? || value.empty? || sanitize_partial(type, value)
    end
    document.compact
  end
  
  def map_document_model_images
    document_model_as(:array).select{ |partial| partial['type'] == 'images' }.each do |partial|
      partial['value'].each do |image_model|
        asset_files.push!(ImageAsset.find image_model['asset_id']) if ImageAsset.exists?(image_model['asset_id'])
      end
    end
  end
  
  def map_document_model_likeits
    document_model_as(:array).select{ |partial| partial['type'] == 'likeit' }.each do |partial|
      LikeIt.create(:tag => partial['tag'], :mobile_campaign => self) unless like_its.find_by_tag partial['tag']
    end
  end
  
  
  protected
  
  def document_state
    (errors.add(:base, 'document_model is empty') && return) unless attributes['document_model']
    
    sanitized_document_model = sanitize(document_model_as(:array))
    
    (errors.add(:base, 'Пустой документ не может быть сохранен') && return) if (!sanitized_document_model || sanitized_document_model.empty?)
    
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

  def sanitize_partial(type, value)
    case type
        when 'images' then !value.is_a?(Array) || (value.is_a?(Array) && value.empty?)
    end
  end
  
  
  private
  
  def disable_short_url_callback
    if draft? || pending?
      short_url.disable! if short_url.try :proxied?
    end
  end
  
end