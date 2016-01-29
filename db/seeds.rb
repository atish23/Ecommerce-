puts "START SEEDING"

puts "COUNTRIES"
file_to_load  = Rails.root + 'db/seed/countries.yml'
countries_list   = YAML::load( File.open( file_to_load ) )
countries_list.each_pair do |key,country|
	s = Country.find_by(abbreviation: country['abbreviation'])
	unless s
		c = Country.create(country) unless s
		c.update_attributes(active: true) if Country::ACTIVE_COUNTRY_IDS.include?(c.id)
	end
end

puts "STATES"
file_to_load = Rails.root + 'db/seed/states.yml'
states_list = YAML::load( File.open( file_to_load))

states_list.each_pair do |key,state|
	s = State.find_by(abbreviation: state['attributes']['abbreviation'],country_id: state['attributes']['country_id'])
	State.create(state['attributes']) unless s
end

puts "ADDRESS TYPES"
AdressType::NAMES.each do |address_type|
	AdressType.find_or_create_by(name: address_type)
end

puts "ROLES"
roles = Role::ROLES
roles.each do |role|
  Role.find_or_create_by(name: role)
end

puts "USER"
u = User.create(email: "admin@admin.com", password: '12345678', password_confirmation: '12345678')

puts "UserRole"
UserRole.create(role_id: '1', user_id: u.id)