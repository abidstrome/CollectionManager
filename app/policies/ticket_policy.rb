class TicketPolicy < ApplicationPolicy
 
  attr_reader :user, :ticket

  def initialize(user, ticket)
    @user= user
    @ticket= ticket
  end

  def new?
    true
  end

  def create?
    true
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    user.admin || ticket.user == user
  end
  
  def update?
    user.admin? || ticket.user == user
  end

  def destroy?
    user.admin? || ticket.user == user
  end


  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
       scope.all
    end
  end
end
