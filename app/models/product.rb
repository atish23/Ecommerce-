class Product < ActiveRecord::Base
	belongs_to :product_type
	belongs_to :prototype
	belongs_to :brand

	has_many :product_properties
	has_many :properties, through: :product_properties

  has_many :variants
  has_many :images, -> {order(:position)},
                    as:        :imageable,
                    dependent: :destroy

  has_many :active_variants, -> { where(deleted_at: nil) },
    class_name: 'Variant'

  accepts_nested_attributes_for :variants,           reject_if: proc { |attributes| attributes['sku'].blank? }
  accepts_nested_attributes_for :product_properties, reject_if: proc { |attributes| attributes['description'].blank? }, allow_destroy: true
  accepts_nested_attributes_for :images,             reject_if: proc { |t| (t['photo'].nil? && t['photo_from_link'].blank? && t['id'].blank?) }, allow_destroy: true

  validates :product_type_id, presence: true
  validates :name, presence: true

  validate :ensure_available


 def self.featured
 	product = where({ products: { featured: true} }).includes(:images)
 	product ? product : includes(:images).where(['products.deleted_at IS NULL'])
 end

  def active(at = Time.zone.now)
    deleted_at.nil? || deleted_at > (at + 1.second)
  end

  def active?(at = Time.zone.now)
    active(at)
  end

  def activate!
    self.deleted_at = nil
    save
  end

 def self.active
    where({products: {active: true}}).includes(:images)
 end
 
  def featured_image(image_size = :small)
  Rails.cache.fetch("Product-featured_image-#{id}-#{image_size}", expires_in: 3.hours) do
    images.first ? images.first.photo.url(image_size) : "no_image_#{image_size.to_s}.jpg"
  end
  end

  def image_urls(image_size = :small)
    Rails.cache.fetch("Product-image_urls-#{id}-#{image_size}", expires_in: 3.hours) do
      images.empty? ? ["no_image_#{image_size.to_s}.jpg"] : images.map{|i| i.photo.url(image_size) }
    end
  end

  def cart_action(current_user_id)
    if $redis.sismember "cart#{current_user_id}", id
      "Remove from"
    else
      "Add to"
    end
  end

private

    def has_active_variants?
      active_variants.any?{|v| v.is_available? }
    end

    def ensure_available
      if active? && deleted_at_changed?
        self.errors.add(:base, 'There must be active variants.')  if active_variants.blank?
        self.errors.add(:base, 'Variants must have inventory.')   unless active_variants.any?{|v| v.is_available? }
        self.deleted_at = deleted_at_was if active_variants.blank? || !active_variants.any?{|v| v.is_available? }
      end
    end
end
