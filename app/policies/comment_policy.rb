class CommentPolicy < ApplicationPolicy

    def show?
        true
    end
    
    def create?
        user.present?
    end

    def destroy?
        user.present? && (record.user == user || user.admin?)
    end

    class Scope < Scope
        def resolve
            scope.all
        end
    end
end