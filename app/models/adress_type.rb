class AdressType < ActiveRecord::Base
	has_many :address

	BILLING = "Billing"
	SHIPPING = "Shipping"

	NAMES = [BILLING,SHIPPING]

	BILLING_ID = 1
	SHIPPING_ID = 2

	validates :name , :presence => true,:length => { :maximum => 55}
end
