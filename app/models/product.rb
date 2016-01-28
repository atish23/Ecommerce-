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
    Rails.cache.fetch("Product-featured_image-#{id}-#{image_size}", expires_in: 3.hours) do
      images.first ? images.first.photo.url(image_size) : "no_image_#{image_size.to_s}.jpg"
    end
    end
end
