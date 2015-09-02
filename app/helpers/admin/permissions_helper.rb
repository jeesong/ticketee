module Admin::PermissionsHelper
  # This method is specific to views from the Admin::PermissionsController
  def permissions
    {
      "view" => "View",
      "create tickets" => "Create Tickets",
      "edit tickets" => "Edit Tickets",
      "delete tickets" => "Delete Tickets"
    }
  end
end
