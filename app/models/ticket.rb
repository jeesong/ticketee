class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :state
  # since we don't have a model named author, use the class_name option helps point towards user model
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_many :assets
  has_many :comments
  
  accepts_nested_attributes_for :assets
end
