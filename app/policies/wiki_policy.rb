class WikiPolicy < ApplicationPolicy

  class Scope < Scope

    def resolve
      if user.admin?
        scope.all
      elsif user.premium?
        scope.where(private: true, user_id: user.id) | scope.where(private: false)
      else
        scope.where(private: false) | user.shared_wikis
      end
    end
  end

  def show?
    user.admin? || !record.private? || record.user_id == user.id ||
    record.collaborations.where(user_id: user.id).any?
  end

  def update?
    if record.private?
      user.admin? || record.user_id == user.id ||
      record.collaborations.where(user_id: user.id).any?
    else
      user.present?
    end
  end

  def destroy?
    user.admin? || (record.private? && record.user_id == user.id)
  end
end
