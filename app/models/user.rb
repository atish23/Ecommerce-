class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many    :user_roles, dependent: :destroy
  has_many    :roles,through: :user_roles
  has_many    :carts, dependent: :destroy
  has_many    :addresses,       dependent: :destroy,       as: :addressable
  accepts_nested_attributes_for :addresses, :user_roles

  def role?(role_name)
    roles.any? {|r| r.name == role_name.to_s}
  end

  def admin?
  	role?(:adminstrator) || role?(:super_administrator)
  end

  def super_admin?
  	role?(:super_administrator) 
  end

  def cart_count
    $redis.scard "cart#{id}"
  end
end
