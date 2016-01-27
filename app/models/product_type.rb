class ProductType < ActiveRecord::Base
  has_many :products, dependent: :restrict_with_exception
end
