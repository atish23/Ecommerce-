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

 def self.featured
 	product = where({ products: { featured: true} }).includes(:images)
 	product ? product : includes(:images).where(['products.deleted_at IS NULL'])
 end

 def self.active
    where({products: {active: true}}).includes(:images)
 end
 
  def featured_image(image_size = :small)
  Rails.cache.fetch("Product-featured_image-#{id}-#{image_size}") do
    images.first ? images.first.photo.url(image_size) : "no_image_#{image_size.to_s}.jpg"
  end
  end

  def image_urls(image_size = :small)
    Rails.cache.fetch("Product-image_urls-#{id}-#{image_size}") do
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
end
