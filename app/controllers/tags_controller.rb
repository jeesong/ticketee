class TagsController < ApplicationController
  def remove
    @ticket = Ticket.find(params[:ticket_id])
    if can?(:tag, @ticket.project) || current_user.admin?
      @tag = Tag.find(params[:id])
      # this will remove the tag from the ticket, but won't delete tag from the db
      @ticket.tags -= [@tag]
      @ticket.save
    end
  end
end
