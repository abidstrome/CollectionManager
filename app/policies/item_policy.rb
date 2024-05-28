class ItemPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && (user.admin? || record.collection.user== user)
  end

  def update?
    user.present? && (user.admin? || record.collection.user == user)
  end

  def destroy?
    user.present? && (user.admin? || record.collection.user == user)
  end



  class Scope < ApplicationPolicy::Scope
    def resolve
      
      scope.all

    end
  end
end
