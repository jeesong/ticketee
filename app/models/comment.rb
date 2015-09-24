class Comment < ActiveRecord::Base
  belongs_to :state
  belongs_to :ticket
  belongs_to :user

  validates :text, presence: true

  # callback after comment is created
  after_create :set_ticket_state

  # allows you to call comment.project, which is really doing ticket.project
  delegate :project, to: :ticket

  private 

    def set_ticket_state
      self.ticket.state = self.state 
      self.ticket.save!
    end
end
