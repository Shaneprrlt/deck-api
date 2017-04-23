class CardPolicy < ApplicationPolicy

  def update?
    user.has_role?(:admin) || user.has_role?(:contributor, record) || user.id === record.user_id
  end

  def destroy?
    user.has_role?(:admin) || user.id === record.user_id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
