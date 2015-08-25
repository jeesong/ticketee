module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do 
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  # takes a block, which is the code between the do & end on the app view
  def admins_only(&block)
    # Try method tries a method on a object, if method doesn't exist, gives up and returns nil instead
    # of nomethoderror
    block.call if current_user.try(:admin?)
  end

  def authorized?(permission, thing, &block)
    block.call if can?(permission.to_sym, thing) || current_user.try(:admin?)
  end
end
