class InvitationPolicy < ApplicationPolicy

  def index?
    user.has_role?(:admin)
  end

  def create?
    user.has_role?(:admin)
  end

  def destroy?
    user.has_role?(:admin)
  end

  def remind?
    user.has_role?(:admin)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
