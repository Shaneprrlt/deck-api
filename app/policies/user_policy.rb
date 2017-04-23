class UserPolicy < ApplicationPolicy

  def update_role?
    user.has_role?(:admin) || user.id === record.id
  end

  def destroy?
    user.has_role?(:admin)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
