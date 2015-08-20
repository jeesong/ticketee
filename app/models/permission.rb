class Permission < ActiveRecord::Base
  belongs_to :user
  # set up polymorphic relationship since permission can be granted for a project, ticket, etc.
  belongs_to :thing, polymorphic: true
end
