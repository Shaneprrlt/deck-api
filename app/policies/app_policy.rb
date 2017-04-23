class AppPolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.has_role?(:admin) || user.has_role?(:developer)
  end

  def show?
    true
  end

  def update?
    user.has_role?(:admin) || user.has_role?(:developer)
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
