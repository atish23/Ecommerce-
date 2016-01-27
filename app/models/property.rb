class Property < ActiveRecord::Base
  has_many :prototype_properties
  has_many :prototypes,          :through => :prototype_properties

  has_many :product_properties
  has_many :products,          :through => :product_properties
	
end
