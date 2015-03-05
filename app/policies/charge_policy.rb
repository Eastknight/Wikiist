class ChargePolicy < ApplicationPolicy
  
  def create?
    user.present?
  end

  def new?
    create?
  end

end