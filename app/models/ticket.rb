class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :state
  # since we don't have a model named author, use the class_name option helps point towards user model
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  has_many :assets
  has_many :comments
  # not a database field, but a virtual attribute 
  attr_accessor :tag_names

  has_and_belongs_to_many :tags
  
  accepts_nested_attributes_for :assets

  before_create :associate_tags

  private

    def associate_tags
      if tag_names
        tag_names.split(" ").each do |name|
          self.tags << Tag.find_or_create_by(name: name)
        end
      end
    end

end
