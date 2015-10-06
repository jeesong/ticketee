class Comment < ActiveRecord::Base
  attr_accessor :tag_names
  
  belongs_to :state
  belongs_to :ticket
  belongs_to :user
  # belongs_to: class_name
  belongs_to :previous_state, class_name: "State"

  validates :text, presence: true

  # callback before comment is created to set previous state
  before_create :set_previous_state

  # callback after comment is created
  after_create :set_ticket_state
  after_create :associate_tags_with_ticket

  # allows you to call comment.project, which is really doing ticket.project
  delegate :project, to: :ticket

  private 

    def set_previous_state
      self.previous_state = ticket.state
    end

    def associate_tags_with_ticket
      if tag_names
        tags = tag_names.split(" ").map do |name|
          Tag.find_or_create_by(name: name)
        end
        self.ticket.tags += tags
        self.ticket.save
      end
    end

    def set_ticket_state
      self.ticket.state = self.state 
      self.ticket.save!
    end
end
