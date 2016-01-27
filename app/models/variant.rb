class Variant < ActiveRecord::Base
	belongs_to :product
	delegate  :brand, :to => :product, :allow_nil => true

end
