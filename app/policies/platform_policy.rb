class PlatformPolicy < ApplicationPolicy

  def index?
    user.has_role?(:admin) || user.has_role?(:developer)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
