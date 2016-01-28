puts "ROLES"
roles = Role::ROLES
roles.each do |role|
  Role.find_or_create_by(name: role)
end

puts "USER"
User.create(email: "admin@admin.com", password: '12345678', password_confirmation: '12345678')

puts "UserRole"
UserRole.create(role_id: '1', user_id: '1')