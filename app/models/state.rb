class State < ActiveRecord::Base
belongs_to :country
has_many :addresses

validates :name, :presence => true , :length => {:maximum => 150}
validates :abbreviation, :presence => true , :length => {:maximum => 12}
validates :country_id, :presence => true

end
