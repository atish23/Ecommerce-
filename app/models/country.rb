class Country < ActiveRecord::Base
has_many :states

validates :name, :presence => true, :length => { :maximum => 200 }
validates :abbreviation, :presence => true, :length => { :maximum => 10 }


USA_ID = 214
CANADA_ID = 35

ACTIVE_COUNTRY_IDS = [USA_ID,CANADA_ID]

end
