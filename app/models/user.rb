class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :permissions

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  scope :admins, ->{ where(:admin => true) }
end
