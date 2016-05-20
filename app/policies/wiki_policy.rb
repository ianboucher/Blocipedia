class WikiPolicy < ApplicationPolicy

  # is the variable 'user' instead of current user a Pundit convention? Where does
  # it come from ?
  def update?
    user.present?
  end

  def destroy?
    user.admin?
  end
end
