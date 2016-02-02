class Wishlist < ActiveRecord::Base
	has_many :products
	belongs_to :user


def wishlist_item_present(title, content)
	if Wishlist.exists?(:product_id => content) && Wishlist.exists?(:user_id => title)	
		self.errors.add( :user_id, "Already present in your wishlist")
	else
		return false
	end
end

end
