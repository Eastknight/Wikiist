class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    record.private != true || record.user == user
  end

  def mine?
    user.present?
  end
end