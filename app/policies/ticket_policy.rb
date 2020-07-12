class TicketPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    if user.instance_of? User
      return true
    end

    false
  end

  def show?
    false
  end

  def create?
    if user.instance_of? User
      return true
    end
    false
  end

  def new?
    create?
  end


  def edit?
    update?
  end

  def destroy?
    if user.instance_of? User
      if user = record.user
        return true
      end
    end

    false
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
