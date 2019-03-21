class OrganizationPolicy < ApplicationPolicy
  attr_reader :user, :organizations

  def initialize(user, organizations)
    @user = user
    @organizations = organizations
  end

  def index?
    user.admin? 
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
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
