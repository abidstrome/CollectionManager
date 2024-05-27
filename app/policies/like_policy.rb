class LikePolicy < ApplicationPolicy
    def create?
        user.present?
    end

    def destroy?
        user.present? && (record.user == user || user.admin? )
    end
end