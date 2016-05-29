class Wiki < ActiveRecord::Base

  belongs_to :user
  has_many   :collaborations
  has_many   :collaborating_users, through: :collaborations, source: :user

  default_scope { order('updated_at DESC') }
end
