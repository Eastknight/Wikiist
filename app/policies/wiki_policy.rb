class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.private
  end

  def mine?
    user.present?
  end
end