class CollectionPolicy < ApplicationPolicy
  
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present? && (user.user? || user.admin?)
  end

  def update?
    user.present? && (user.admin? || record.user == user)
  end

  def destroy?
    user.present? && (user.admin? || record.user== user)
  end
  

  class Scope < ApplicationPolicy::Scope
   
    def resolve
      if user&.admin?
        scope.all
      elsif user.present?
        scope.where(user: user)
      else
        scope.all
      end
    end
  end

end
