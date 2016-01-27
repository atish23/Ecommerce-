class Address < ActiveRecord::Base
	belongs_to :country
	belongs_to :state
	belongs_to :address_type
	belongs_to :addresable, :polymorphic => true
end
