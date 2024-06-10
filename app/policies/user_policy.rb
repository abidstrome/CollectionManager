class UserPolicy < ApplicationPolicy
    def index?
      user.admin?
    end

    def show?
      user.present? && (record == user || user.admin?)
    end

    def update?
      user.admin? || record == user
    end

    def destroy?
      user.admin?
    end

    def block?
      user.admin?
    end

    def unblock?
      user.admin?
    end

    def make_admin?
      user.admin?
    end

    def remove_admin?
      user.admin? && user != record
    end

    def generate_api_token?
      user == record || user.admin?
    end
    
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
