class RafflePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    if user.instance_of? Admin
      return true
    end

    false
  end

  def show?
    false
  end

  def create?
    if user.instance_of? Admin
      return true
    elsif user.instance_of? Institution 
      return true
    end
    false
  end

  def new?
    create?
  end

  def update?
    if user.instance_of? Admin
      return true
    elsif user.instance_of? Institution 
      if user = record.institution
        return true
      end
    end
    false
  end

  def edit?
    update?
  end

  def destroy?
    if user.instance_of? Admin
      return true
    elsif user.instance_of? Institution
      if user = record.institution
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
