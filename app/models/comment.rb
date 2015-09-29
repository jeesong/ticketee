class Comment < ActiveRecord::Base
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

  # allows you to call comment.project, which is really doing ticket.project
  delegate :project, to: :ticket

  private 

    def set_previous_state
      self.previous_state = ticket.state
    end

    def set_ticket_state
      self.ticket.state = self.state 
      self.ticket.save!
    end
end
